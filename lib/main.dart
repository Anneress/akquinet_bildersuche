import 'package:akquinet_bildersuche/ui/bildersuche/bildersuche_screen.dart';
import 'package:akquinet_bildersuche/ui/bildersuche/bildersuche_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    // Initialisere Provider Riverpod
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

// App für Konfiguration der Navigation, locale, Themes, etc.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Navigation in App, sollte für Webapp Verlauf in GoRouter o.ä. geändert werden
      initialRoute: "/",
      routes: {
        "/": (context) => const BildersucheScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == BildersucheDetailScreen.routeName) {
          final index = settings.arguments as int;
          return MaterialPageRoute(
            builder: (context) => BildersucheDetailScreen(index: index),
          );
        }
        throw ArgumentError();
      },
    );
  }
}
