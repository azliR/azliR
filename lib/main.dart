import 'package:azlir_portfolio/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_strategy/url_strategy.dart';

final colorSchemeProvider = StateProvider(
  (ref) => ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.dark,
  ),
);

void main() {
  setPathUrlStrategy();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = ref.watch(colorSchemeProvider);

    return MaterialApp(
      title: 'Portfolio',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        textTheme: GoogleFonts.robotoTextTheme().apply(
          bodyColor: colorScheme.onBackground,
          displayColor: colorScheme.onBackground,
        ),
      ),
      home: const HomePage(),
    );
  }
}
