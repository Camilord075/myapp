# Huertix Application Blueprint

## Overview
This document outlines the design and implementation details of the Huertix mobile application. The application aims to provide a platform for managing cultivation zones, tracking user participation, and offering educational content on urban agriculture.

## Style, Design, and Features Implemented

### Theming
-   **Material Design 3:** The application will follow Material Design 3 guidelines for a modern and consistent look and feel.
-   **Color Scheme:** A `ColorScheme.fromSeed` will be used with a primary seed color (e.g., `Colors.green`).
-   **Typography:** Custom fonts will be integrated using `google_fonts` for a distinct typographic style.
-   **Dark/Light Mode:** Support for both light and dark themes will be implemented, with a user-facing toggle.
-   **Component Theming:** Specific theme properties (e.g., `appBarTheme`, `elevatedButtonTheme`) will be used to customize Material components.

### Navigation
-   Basic imperative navigation using `Navigator` will be employed for simplicity. If the application grows in complexity, `go_router` will be considered.

### State Management
-   `ChangeNotifier` and `ChangeNotifierProvider` from the `provider` package will be used for app-wide state management, especially for theme toggling.

## Current Plan for Implementation

This section details the steps for the current request, which involves creating the initial set of screens based on the provided design image.

1.  **Update `lib/main.dart`:**
    *   Integrate `ChangeNotifierProvider` for `ThemeProvider`.
    *   Define light and dark themes using `ThemeData` with `ColorScheme.fromSeed` and `google_fonts`.
    *   Set up `MaterialApp` with theme and `ThemeProvider`.
    *   Replace `MyHomePage` with `LoginScreen` as the initial home route.

2.  **Create `LoginScreen` (Inicio de sesión):**
    *   Design: Full-screen login form with a logo, text fields for user and password, and a "Iniciar Sesión" button.
    *   Components: `Scaffold`, `AppBar` (custom background), `Image` for logo, `TextFormField` for input, `ElevatedButton`.

3.  **Create `DashboardScreen` (Dashboard):**
    *   Design: Screen with a top bar displaying "Dashboard" and user name, and three main card-like sections for "Zonas de cultivo," "Mi Participación," and "Educación."
    *   Components: `Scaffold`, `AppBar`, `Column`, `Card`, `Text`, `Image` (placeholders).

4.  **Create `CultivationZonesScreen` (Zonas de cultivo):**
    *   Design: List of cultivation zones with details like size, crops, and availability, and a floating action button to add a new zone.
    *   Components: `Scaffold`, `AppBar`, `ListView.builder`, `Card`, `Text`, `FloatingActionButton`.

5.  **Create `PlotRegistrationScreen` (Registro de parcela):**
    *   Design: Form for registering a new plot with fields for name, size, category, crop type, and current status.
    *   Components: `Scaffold`, `AppBar`, `TextFormField`, `DropdownButtonFormField`, `ElevatedButton`.

6.  **Create `UserRegistrationScreen` (Registro usuario):**
    *   Design: Form for user registration with fields for name, email, phone, zone of residence, password, and password confirmation.
    *   Components: `Scaffold`, `AppBar`, `TextFormField`, `ElevatedButton`.

7.  **Create `ParticipationRegistrationScreen` (Registro de participación):**
    *   Design: Screen displaying details of a specific cultivation zone, a list of inscribed participants, and a section for tasks with radio buttons.
    *   Components: `Scaffold`, `AppBar`, `Text`, `RadioListTile`, `ElevatedButton`.
