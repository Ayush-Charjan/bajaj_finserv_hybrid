import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/new_main_navigation_screen.dart';
import 'utils/app_colors.dart';
import 'utils/native_shell_tab_bridge.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final bool isEmbedded = Uri.base.queryParameters['embedded'] == 'true';
  final bool useNativeShell = Uri.base.queryParameters['nativeShell'] == 'true';

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(
    BajajFinservApp(
      isEmbedded: isEmbedded,
      useNativeShell: useNativeShell,
      nativeShellTabStream: NativeShellTabBridge.instance.stream,
    ),
  );
}

class BajajFinservApp extends StatefulWidget {
  final bool isEmbedded;
  final bool useNativeShell;
  final Stream<int>? nativeShellTabStream;

  const BajajFinservApp({
    Key? key,
    required this.isEmbedded,
    required this.useNativeShell,
    required this.nativeShellTabStream,
  }) : super(key: key);

  @override
  State<BajajFinservApp> createState() => _BajajFinservAppState();
}

class _BajajFinservAppState extends State<BajajFinservApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  DateTime? _lastBackPressedAt;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      // App title
      title: 'Bajaj Finserv ',

      // Remove debug banner
      debugShowCheckedModeBanner: false,

      // Theme configuration
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
        ),
        primaryColor: AppColors.primary,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          elevation: 0,
          centerTitle: false,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
          ),
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey.shade600,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Roboto',
      ),

      initialRoute: '/home',

      routes: {
        '/': (context) => NewMainNavigationScreen(
              isEmbedded: widget.isEmbedded,
              useNativeShell: widget.useNativeShell,
              externalTabStream: widget.nativeShellTabStream,
            ),
        '/home': (context) => NewMainNavigationScreen(
              isEmbedded: widget.isEmbedded,
              useNativeShell: widget.useNativeShell,
              externalTabStream: widget.nativeShellTabStream,
            ),
      },

      builder: (context, child) {
        return WillPopScope(
          onWillPop: () async {
            final NavigatorState? nav = _navigatorKey.currentState;
            if (nav == null) return true;

            if (nav.canPop()) {
              nav.maybePop();
              return false;
            }

            final DateTime now = DateTime.now();
            if (_lastBackPressedAt == null ||
                now.difference(_lastBackPressedAt!) >
                    const Duration(seconds: 2)) {
              _lastBackPressedAt = now;
              final messengerContext = _navigatorKey.currentContext ?? context;
              ScaffoldMessenger.of(messengerContext).showSnackBar(
                const SnackBar(content: Text('Press back again to exit')),
              );
              return false;
            }

            return true;
          },
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
