import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HybridShellApp());
}

class HybridShellApp extends StatelessWidget {
  const HybridShellApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HybridHomeScreen(),
    );
  }
}

class HybridHomeScreen extends StatefulWidget {
  const HybridHomeScreen({super.key});

  @override
  State<HybridHomeScreen> createState() => _HybridHomeScreenState();
}

class _HybridHomeScreenState extends State<HybridHomeScreen> {
  static const String _remotePwaUrl = String.fromEnvironment(
    'PWA_URL',
    defaultValue: 'https://ayush-charjan.github.io/bajaj-pwa',
  );

  WebViewController? _controller;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  String _startUrl = 'about:blank';
  bool _hasLoadError = false;
  bool _isNativeLoggedIn = false;
  int _selectedBottomNavIndex = 0;
  String? _lastFeatureOpened;
  DateTime? _lastFeatureOpenedAt;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _handleNativeLoginSuccess(
    String username,
    String password,
  ) async {
    debugPrint('Native login success for user: $username');

    if (mounted) {
      setState(() {
        _isNativeLoggedIn = true;
        _hasLoadError = false;
      });
    }

    await _initializeMobileWebView();
  }

  bool _isPwaLoginRoute(Uri uri) {
    final String url = uri.toString().toLowerCase();
    final String path = uri.path.toLowerCase();
    return path.contains('/login') ||
        path.contains('/signin') ||
        path.endsWith('/auth') ||
        url.contains('#/login') ||
        url.contains('#/signin') ||
        url.contains('route=login') ||
        url.contains('page=login');
  }

  Future<void> _ensureCameraPermission() async {
    final PermissionStatus status = await Permission.camera.status;
    if (status.isGranted) {
      debugPrint('Android camera runtime permission already granted.');
      return;
    }

    final PermissionStatus result = await Permission.camera.request();
    debugPrint('Android camera runtime permission result: $result');
  }

  Future<void> _initializeMobileWebView() async {
    await _ensureCameraPermission();
    _startUrl = _buildStartUrl(tab: 'home');
    debugPrint('Hybrid shell start URL: $_startUrl');

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'NativeShell',
        onMessageReceived: (JavaScriptMessage message) {
          debugPrint('NativeShell JS message: ${message.message}');
          _openNativeFeature(message.message);
        },
      )
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (mounted) {
              setState(() {
                _hasLoadError = false;
              });
            }
          },
          onPageFinished: (_) {
            _injectNativeScanInterceptor();
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('WebView navigation request: ${request.url}');
            final Uri? uri = Uri.tryParse(request.url);
            if (uri == null) {
              return NavigationDecision.navigate;
            }

            if (_isPwaLoginRoute(uri)) {
              debugPrint('Blocked PWA login route: ${request.url}');
              if (mounted) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Session ended. Please use native login again.',
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                setState(() {
                  _isNativeLoggedIn = false;
                  _controller = null;
                  _hasLoadError = false;
                });
              }
              return NavigationDecision.prevent;
            }

            if (uri.scheme == 'native') {
              final String feature = uri.host.isNotEmpty
                  ? uri.host
                  : uri.pathSegments.isNotEmpty
                  ? uri.pathSegments.first
                  : '';
              _openNativeFeature(feature);
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('WebView error: ${error.description}');
            if (mounted) {
              setState(() {
                _hasLoadError = true;
              });
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(_startUrl));

    if (_controller!.platform is AndroidWebViewController) {
      final AndroidWebViewController androidController =
          _controller!.platform as AndroidWebViewController;
      await androidController.setMediaPlaybackRequiresUserGesture(false);
      await androidController.setOnPlatformPermissionRequest((request) {
        debugPrint('WebView permission request: ${request.types}');
        request.grant();
      });
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _injectNativeScanInterceptor() async {
    // Expose a stable explicit bridge for hosted PWA code to invoke native features.
    await _controller?.runJavaScript(r'''
      (function() {
        if (window.__nativeScanHookInstalled) {
          return;
        }
        window.__nativeScanHookInstalled = true;

        window.openNativeFeature = function(feature) {
          if (window.NativeShell && typeof window.NativeShell.postMessage === 'function') {
            window.NativeShell.postMessage(String(feature || ''));
          }
        };

        window.addEventListener('nativeFeature', function(event) {
          var feature = event && event.detail && event.detail.feature;
          if (feature) {
            window.openNativeFeature(feature);
          }
        });
      })();
    ''');
  }

  Future<void> _reloadPwaApp() async {
    if (_startUrl != 'about:blank') {
      await _controller?.loadRequest(Uri.parse(_startUrl));
    }
  }

  String _buildStartUrl({required String tab, String? searchQuery}) {
    final String trimmed = _remotePwaUrl.trim();
    if (trimmed.isEmpty) {
      return 'about:blank';
    }

    final Uri? baseUri = Uri.tryParse(trimmed);
    if (baseUri == null ||
        (baseUri.scheme != 'http' && baseUri.scheme != 'https')) {
      return 'about:blank';
    }

    final Map<String, String> query = Map<String, String>.from(
      baseUri.queryParameters,
    );
    query['nativeShell'] = 'true';
    query['tab'] = tab;
    if (searchQuery != null && searchQuery.trim().isNotEmpty) {
      query['search'] = searchQuery.trim();
    }

    String normalizedPath = baseUri.path;
    if (RegExp(
      r'(login|signin)/?$',
      caseSensitive: false,
    ).hasMatch(normalizedPath)) {
      normalizedPath = normalizedPath.replaceFirst(
        RegExp(r'(login|signin)/?$', caseSensitive: false),
        '',
      );
    }

    if (normalizedPath.isEmpty) {
      normalizedPath = '/';
    }

    return baseUri
        .replace(path: normalizedPath, queryParameters: query)
        .toString();
  }

  Future<void> _loadPwaTab(int index, {String? searchQuery}) async {
    setState(() {
      _selectedBottomNavIndex = index;
    });

    final List<String> tabs = <String>[
      'home',
      'profile',
      'scan',
      'payemi',
      'menu',
      'chat',
    ];
    final String tab = tabs[index.clamp(0, tabs.length - 1)];
    final String url = _buildStartUrl(tab: tab, searchQuery: searchQuery);
    if (url != 'about:blank') {
      await _controller?.loadRequest(Uri.parse(url));
    }
  }

  Future<void> _openQRScanner() async {
    final String? scannedCode = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const _NativeQRScannerScreen()),
    );

    if (scannedCode != null && scannedCode.trim().isNotEmpty) {
      debugPrint('Scanned QR link: $scannedCode');
    }
  }

  Future<void> _submitSearch(String query) async {
    final String trimmed = query.trim();
    if (trimmed.isEmpty) {
      return;
    }
    await _loadPwaTab(0, searchQuery: trimmed);
  }

  String _normalizeFeature(String feature) {
    final String normalized = feature.toLowerCase().trim();
    if (normalized == 'scanqr' || normalized == 'scan qr') {
      return 'scan-qr';
    }
    if (normalized == 'scan_qr' || normalized == 'scan' || normalized == 'qr') {
      return 'scan-qr';
    }
    return normalized;
  }

  Future<void> _openNativeFeature(String feature) async {
    final String normalizedFeature = _normalizeFeature(feature);
    debugPrint('Opening native feature: $normalizedFeature');

    final DateTime now = DateTime.now();
    final int throttleMs = normalizedFeature == 'scan-qr' ? 3000 : 900;
    if (_lastFeatureOpened == normalizedFeature &&
        _lastFeatureOpenedAt != null &&
        now.difference(_lastFeatureOpenedAt!).inMilliseconds < throttleMs) {
      debugPrint(
        'Skipping duplicate native feature trigger: $normalizedFeature',
      );
      return;
    }
    _lastFeatureOpened = normalizedFeature;
    _lastFeatureOpenedAt = now;

    switch (normalizedFeature) {
      case 'scan-qr':
        await _openQRScanner();
        return;
      case 'menu':
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const _NativeMenuScreen()),
        );
        return;
      case 'chat':
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const _NativeChatScreen()),
        );
        return;
      default:
        return;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Scaffold(
        body: SafeArea(
          child: (_startUrl == 'about:blank')
              ? const _InternetRequiredView()
              : (_controller == null
                    ? const Center(child: CircularProgressIndicator())
                    : (_hasLoadError
                          ? _InternetRequiredView(onRetry: _reloadWebApp)
                          : SizedBox.expand(
                              child: WebViewWidget(controller: _controller!),
                            ))),
        ),
      );
    }

    if (!_isNativeLoggedIn) {
      return _NativeLoginScreen(onLoginSuccess: _handleNativeLoginSuccess);
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 42, 84, 1),
      appBar: _NativeTopSearchBar(
        controller: _searchController,
        focusNode: _searchFocusNode,
        onSubmitted: _submitSearch,
        onScanTap: _openQRScanner,
        onMenuTap: () => _loadPwaTab(4),
      ),
      bottomNavigationBar: _NativeBottomNavBar(
        selectedIndex: _selectedBottomNavIndex,
        onSelected: (index) async {
          if (index == 2) {
            await _openQRScanner();
            return;
          }
          await _loadPwaTab(index);
        },
      ),
      body: SafeArea(
        child: (_startUrl == 'about:blank')
            ? const _InternetRequiredView()
            : (_controller == null
                  ? const Center(child: CircularProgressIndicator())
                  : (_hasLoadError
                        ? _InternetRequiredView(onRetry: _reloadPwaApp)
                        : SizedBox.expand(
                            child: WebViewWidget(controller: _controller!),
                          ))),
      ),
    );
  }
}

class _NativeTopSearchBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _NativeTopSearchBar({
    required this.controller,
    required this.focusNode,
    required this.onSubmitted,
    required this.onScanTap,
    required this.onMenuTap,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onScanTap;
  final VoidCallback onMenuTap;

  @override
  Size get preferredSize => const Size.fromHeight(76);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 2,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFF0057B8).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.account_balance_rounded,
                  color: Color(0xFF0057B8),
                  size: 22,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  textInputAction: TextInputAction.search,
                  onSubmitted: onSubmitted,
                  decoration: InputDecoration(
                    hintText: 'Search loans, cards, support...',
                    prefixIcon: const Icon(Icons.search_rounded),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.qr_code_scanner_rounded),
                      onPressed: onScanTap,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF5F7FB),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 0,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: onMenuTap,
                icon: const Icon(Icons.menu_rounded),
                color: const Color(0xFF0057B8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NativeBottomNavBar extends StatelessWidget {
  const _NativeBottomNavBar({
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onSelected,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Home'),
        NavigationDestination(
          icon: Icon(Icons.person_rounded),
          label: 'Profile',
        ),
        NavigationDestination(
          icon: Icon(Icons.qr_code_scanner_rounded),
          label: 'Scan',
        ),
        NavigationDestination(
          icon: Icon(Icons.payment_rounded),
          label: 'Pay EMI',
        ),
        NavigationDestination(icon: Icon(Icons.menu_rounded), label: 'Menu'),
        NavigationDestination(icon: Icon(Icons.chat_rounded), label: 'Chat'),
      ],
    );
  }
}

class _NativeLoginScreen extends StatelessWidget {
  const _NativeLoginScreen({required this.onLoginSuccess});

  final Future<void> Function(String username, String password) onLoginSuccess;

  Future<void> _continueWithNativeLogin(BuildContext context) async {
    await onLoginSuccess('native_user', 'native_session');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B2A5B),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.phone_android,
                    size: 60,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Log in to your account',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Use your MPIN or fingerprint to log in',
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                TextButton(
                  onPressed: () => _continueWithNativeLogin(context),
                  child: const Text(
                    'Log in using MPIN',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(color: Colors.white38, thickness: 1),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'OR',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: Colors.white38, thickness: 1),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () => _continueWithNativeLogin(context),
                  child: const Icon(
                    Icons.fingerprint,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WebUnsupportedView extends StatelessWidget {
  const _WebUnsupportedView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.web_asset_off_rounded,
              size: 52,
              color: Color(0xFF0057B8),
            ),
            SizedBox(height: 12),
            Text(
              'WebView shell is not supported on Flutter Web.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8),
            Text(
              'Run this hybrid shell on Android, iOS, Windows, macOS, or Linux for a full-screen PWA with native app QR, menu, and chat flows.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

class _NativeQRScannerScreen extends StatefulWidget {
  const _NativeQRScannerScreen();

  @override
  State<_NativeQRScannerScreen> createState() => _NativeQRScannerScreenState();
}

class _NativeQRScannerScreenState extends State<_NativeQRScannerScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _animationController;
  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );
  bool _detectedOnce = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    debugPrint('Native QR scanner screen opened');
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    unawaited(_startScanner());
  }

  Future<void> _startScanner() async {
    try {
      await controller.start();
      debugPrint('MobileScanner started');
    } catch (e) {
      debugPrint('MobileScanner start failed: $e');
    }
  }

  Future<void> _stopScanner() async {
    try {
      await controller.stop();
      debugPrint('MobileScanner stopped');
    } catch (e) {
      debugPrint('MobileScanner stop failed: $e');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      unawaited(_startScanner());
    }
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      unawaited(_stopScanner());
    }
  }

  @override
  void dispose() {
    debugPrint('Native QR scanner screen closed');
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_stopScanner());
    _animationController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Scan QR Code',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            errorBuilder: (context, error, child) {
              debugPrint('MobileScanner error: ${error.toString()}');
              return Container(
                color: Colors.black,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                      size: 42,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Camera unavailable',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      error.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Back'),
                    ),
                  ],
                ),
              );
            },
            onDetect: (capture) {
              if (_detectedOnce) {
                return;
              }
              final barcode = capture.barcodes.first;
              final String? code = barcode.rawValue;
              final String? normalizedCode = code?.trim();
              if (normalizedCode != null && normalizedCode.isNotEmpty) {
                _detectedOnce = true;
                final NavigatorState navigator = Navigator.of(context);
                debugPrint('Scanned QR: $normalizedCode');
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text('Scanned: $normalizedCode'),
                      duration: const Duration(seconds: 5),
                      backgroundColor: const Color(0xFF0057B8),
                    ),
                  );
                Future.delayed(const Duration(seconds: 5), () {
                  if (!mounted || !navigator.mounted) {
                    return;
                  }
                  navigator.pop(normalizedCode);
                });
              }
            },
          ),
          IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.35),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.35),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF0057B8), width: 3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Positioned(
                        top: _animationController.value * 270,
                        left: 10,
                        right: 10,
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0057B8),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF0057B8,
                                ).withValues(alpha: 0.5),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            bottom: 60,
            left: 20,
            right: 20,
            child: Text(
              'Position QR code within the frame',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NativeMenuScreen extends StatelessWidget {
  const _NativeMenuScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0057B8),
        title: const Text('Menu', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          _NativeMenuSection(
            title: 'Financial Services',
            items: const [
              _NativeMenuItem(
                Icons.account_balance,
                'All Loans',
                'View all loan products',
              ),
              _NativeMenuItem(
                Icons.credit_card,
                'Credit Cards',
                'Apply for credit cards',
              ),
              _NativeMenuItem(
                Icons.assessment,
                'Credit Score',
                'Check your credit score',
              ),
              _NativeMenuItem(
                Icons.account_balance_wallet,
                'Insurance',
                'Life & health insurance',
              ),
              _NativeMenuItem(
                Icons.trending_up,
                'Investments',
                'Mutual funds & stocks',
              ),
            ],
          ),
          const Divider(height: 1),
          _NativeMenuSection(
            title: 'Help & Support',
            items: [
              const _NativeMenuItem(
                Icons.chat_bubble_outline,
                'Chat Support',
                '24/7 customer support',
              ),
              const _NativeMenuItem(
                Icons.help_outline,
                'Help Center',
                'FAQs and support',
              ),
              const _NativeMenuItem(
                Icons.star_outline,
                'Rate Us',
                'Share your feedback',
              ),
            ],
            onItemTap: (title) {
              if (title == 'Chat Support') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const _NativeChatScreen()),
                );
              }
            },
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back to native app'),
            ),
          ),
        ],
      ),
    );
  }
}

class _NativeMenuSection extends StatelessWidget {
  const _NativeMenuSection({
    required this.title,
    required this.items,
    this.onItemTap,
  });

  final String title;
  final List<_NativeMenuItem> items;
  final void Function(String title)? onItemTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ),
        ...items.map(
          (item) => ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF0057B8).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(item.icon, color: const Color(0xFF0057B8)),
            ),
            title: Text(
              item.title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(item.subtitle, style: const TextStyle(fontSize: 12)),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: onItemTap == null ? () {} : () => onItemTap!(item.title),
          ),
        ),
      ],
    );
  }
}

class _NativeMenuItem {
  const _NativeMenuItem(this.icon, this.title, this.subtitle);

  final IconData icon;
  final String title;
  final String subtitle;
}

class _NativeChatScreen extends StatefulWidget {
  const _NativeChatScreen();

  @override
  State<_NativeChatScreen> createState() => _NativeChatScreenState();
}

class _NativeChatScreenState extends State<_NativeChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'text':
          'Hello! Welcome to Bajaj Fintech Support. How can I help you today?',
      'isUser': false,
      'time': '10:30 AM',
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final String text = _messageController.text.trim();
    if (text.isEmpty) {
      return;
    }

    setState(() {
      _messages.add({'text': text, 'isUser': true, 'time': 'Now'});
    });

    _messageController.clear();

    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) {
        return;
      }
      setState(() {
        _messages.add({
          'text':
              'Thank you for your message. Our team will assist you shortly.',
          'isUser': false,
          'time': 'Now',
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0057B8),
        title: const Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.support_agent, color: Color(0xFF0057B8)),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Customer Support',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  'Online',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.blue.shade50,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildQuickHelpChip('EMI Payment'),
                  const SizedBox(width: 8),
                  _buildQuickHelpChip('Loan Status'),
                  const SizedBox(width: 8),
                  _buildQuickHelpChip('Account Info'),
                  const SizedBox(width: 8),
                  _buildQuickHelpChip('Other'),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(
                  message['text'] as String,
                  message['isUser'] as bool,
                  message['time'] as String,
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.2),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file, color: Colors.grey),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: const Color(0xFF0057B8),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickHelpChip(String label) {
    return ActionChip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      onPressed: () {
        setState(() {
          _messages.add({
            'text': 'I need help with $label',
            'isUser': true,
            'time': 'Now',
          });
          _messages.add({
            'text':
                'Sure! I can help you with $label. Please provide more details.',
            'isUser': false,
            'time': 'Now',
          });
        });
      },
      backgroundColor: Colors.white,
      side: const BorderSide(color: Color(0xFF0057B8)),
    );
  }

  Widget _buildMessageBubble(String text, bool isUser, String time) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isUser ? const Color(0xFF0057B8) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        constraints: const BoxConstraints(maxWidth: 280),
        child: Column(
          crossAxisAlignment: isUser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                color: isUser ? Colors.white : Colors.black87,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(
                color: isUser ? Colors.white70 : Colors.grey,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InternetRequiredView extends StatelessWidget {
  const _InternetRequiredView({this.onRetry});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.wifi_off_rounded,
              size: 56,
              color: Color(0xFF0057B8),
            ),
            const SizedBox(height: 12),
            const Text(
              'Connect to internet',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            const Text(
              'Unable to load hosted PWA. Check your internet connection and try again.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
