import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:myapp/screens/login_screen.dart'; // Import the actual LoginScreen
import 'package:myapp/screens/dashboard_screen.dart'; // Import DashboardScreen
import 'package:myapp/screens/cultivation_zones_screen.dart'; // Import CultivationZonesScreen
import 'package:myapp/screens/plot_registration_screen.dart'; // Import PlotRegistrationScreen
import 'package:myapp/screens/user_registration_screen.dart'; // Import UserRegistrationScreen
import 'package:myapp/screens/participation_registration_screen.dart'; // Import ParticipationRegistrationScreen

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setSystemTheme() {
    _themeMode = ThemeMode.system;
    notifyListeners();
  }
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: '/dashboard',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardScreen();
      },
    ),
    GoRoute(
      path: '/cultivation-zones',
      builder: (BuildContext context, GoRouterState state) {
        return const CultivationZonesScreen();
      },
    ),
    GoRoute(
      path: '/plot-registration',
      builder: (BuildContext context, GoRouterState state) {
        return const PlotRegistrationScreen();
      },
    ),
    GoRoute(
      path: '/user-registration',
      builder: (BuildContext context, GoRouterState state) {
        return const UserRegistrationScreen();
      },
    ),
    GoRoute(
      path: '/participation-registration',
      builder: (BuildContext context, GoRouterState state) {
        return const ParticipationRegistrationScreen();
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primarySeedColor = Color(0xFF4CAF50); // A green color for Huertix

    final TextTheme appTextTheme = TextTheme(
      displayLarge: GoogleFonts.oswald(fontSize: 57, fontWeight: FontWeight.bold),
      titleLarge: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.w500),
      bodyMedium: GoogleFonts.openSans(fontSize: 14),
      labelLarge: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),
    );

    final ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primarySeedColor,
        brightness: Brightness.light,
      ),
      textTheme: appTextTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: primarySeedColor,
        foregroundColor: Colors.white,
        titleTextStyle: GoogleFonts.oswald(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: primarySeedColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: appTextTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );

    final ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primarySeedColor,
        brightness: Brightness.dark,
      ),
      textTheme: appTextTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        titleTextStyle: GoogleFonts.oswald(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer, // Corrected line
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: appTextTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[800],
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp.router(
          title: 'Huertix',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeProvider.themeMode,
          routerConfig: _router,
        );
      },
    );
  }
}

// Placeholder for DashboardScreen - NO LONGER NEEDED AS IT'S IN ITS OWN FILE
