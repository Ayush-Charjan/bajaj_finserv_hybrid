import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/login_screen.dart';
import 'screens/new_main_navigation_screen.dart';
import 'utils/app_colors.dart';

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
    ),
  );
}

class BajajFinservApp extends StatelessWidget {
  final bool isEmbedded;
  final bool useNativeShell;

  const BajajFinservApp({
    Key? key,
    required this.isEmbedded,
    required this.useNativeShell,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

        // App bar theme
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

        // Elevated button theme
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

        // Text button theme
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
          ),
        ),

        // Card theme
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        // Input decoration theme
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),

        // Bottom navigation bar theme
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey.shade600,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),

        // Scaffold background color
        scaffoldBackgroundColor: AppColors.background,

        // Font family (using default)
        fontFamily: 'Roboto',
      ),

      // In embedded mode, skip login and show only app body content.
      initialRoute: isEmbedded ? '/home' : '/',

      // Routes configuration
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => NewMainNavigationScreen(
              isEmbedded: isEmbedded,
              useNativeShell: useNativeShell,
            ),
      },
    );
  }
}
