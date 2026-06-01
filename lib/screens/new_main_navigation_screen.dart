// New Main Navigation with 6 bottom tabs
import 'dart:async';
import 'package:flutter/material.dart';
import 'new_home_screen.dart';
import 'profile_screen.dart';
import 'scan_qr_screen.dart';
import 'pay_emi_screen.dart';
import 'menu_screen.dart';
import 'chat_screen.dart';
import '../utils/app_colors.dart';
import '../services/native_shell_bridge.dart';

class NewMainNavigationScreen extends StatefulWidget {
  final bool isEmbedded;
  final bool useNativeShell;
  final int initialIndex;
  final Stream<int>? externalTabStream;

  const NewMainNavigationScreen({
    Key? key,
    this.isEmbedded = false,
    this.useNativeShell = false,
    this.initialIndex = 0,
    this.externalTabStream,
  }) : super(key: key);

  @override
  State<NewMainNavigationScreen> createState() =>
      _NewMainNavigationScreenState();
}

class _NewMainNavigationScreenState extends State<NewMainNavigationScreen> {
  int _currentIndex = 0;
  final NativeShellBridge _nativeShellBridge = NativeShellBridge();
  StreamSubscription<int>? _externalTabSubscription;
  DateTime? _lastBackPressedAt;

  List<Widget> get _screens => [
        NewHomeScreen(
          isEmbedded: widget.isEmbedded,
          useNativeShell: widget.useNativeShell,
        ),
        ProfileScreen(
          isEmbedded: widget.isEmbedded,
          useNativeShell: widget.useNativeShell,
        ),
        Container(),
        PayEmiScreen(
          isEmbedded: widget.isEmbedded,
          useNativeShell: widget.useNativeShell,
        ),
        MenuScreen(
          isEmbedded: widget.isEmbedded,
          useNativeShell: widget.useNativeShell,
        ),
        ChatScreen(
          isEmbedded: widget.isEmbedded,
          useNativeShell: widget.useNativeShell,
        ),
      ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _externalTabSubscription = widget.externalTabStream?.listen((index) {
      if (!mounted) {
        return;
      }
      _handleTabSelection(index, fromNativeShell: true);
    });

    // Notify Native Shell that PWA is fully loaded and ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _nativeShellBridge.openFeature('READY');
      });
    });
  }

  @override
  void dispose() {
    _externalTabSubscription?.cancel();
    super.dispose();
  }

  Future<void> _handleTabSelection(
    int index, {
    bool fromNativeShell = false,
  }) async {
    if (index == 2) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ScanQRScreen(),
          fullscreenDialog: true,
        ),
      );
      return;
    }

    if (!fromNativeShell &&
        widget.useNativeShell &&
        (index == 4 || index == 5)) {
      _nativeShellBridge.openFeature(index == 4 ? 'menu' : 'chat');
      return;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // If there is a pushed route on the Navigator stack, allow it to pop.
        if (Navigator.of(context).canPop()) {
          return true;
        }

        // If we're not on the home tab, go to home tab instead of exiting.
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          return false;
        }

        // Double back to exit from root tab: show a toast/snackbar on first press.
        final DateTime now = DateTime.now();
        if (_lastBackPressedAt == null ||
            now.difference(_lastBackPressedAt!) > const Duration(seconds: 2)) {
          _lastBackPressedAt = now;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Press back again to exit')),
          );
          return false;
        }

        return true;
      },
      child: Scaffold(
        body: _currentIndex == 2
            ? NewHomeScreen(
                isEmbedded: widget.isEmbedded,
                useNativeShell: widget.useNativeShell,
              )
            : _screens[_currentIndex],
        bottomNavigationBar: widget.isEmbedded || widget.useNativeShell
            ? null
            : Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: BottomNavigationBar(
                  currentIndex: _currentIndex,
                  onTap: (index) => _handleTabSelection(index),
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  selectedItemColor: AppColors.primary,
                  unselectedItemColor: Colors.grey.shade600,
                  selectedFontSize: 11,
                  unselectedFontSize: 11,
                  selectedLabelStyle:
                      const TextStyle(fontWeight: FontWeight.w600),
                  items: [
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      activeIcon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline),
                      activeIcon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: AppColors.accent,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.qr_code_scanner,
                            color: Colors.white, size: 24),
                      ),
                      label: 'Scan QR',
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.payment_outlined),
                      activeIcon: Icon(Icons.payment),
                      label: 'Pay EMI',
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.menu),
                      activeIcon: Icon(Icons.menu_open),
                      label: 'Menu',
                    ),
                    BottomNavigationBarItem(
                      icon: Stack(
                        children: [
                          const Icon(Icons.chat_bubble_outline),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      activeIcon: const Icon(Icons.chat_bubble),
                      label: 'Chat',
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
