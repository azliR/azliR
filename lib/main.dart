import 'package:azlir_portfolio/blocs/home/home_cubit.dart';
import 'package:azlir_portfolio/notifier/home/home_notifier.dart';
import 'package:azlir_portfolio/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();

  runApp(
    ProviderScope(
      child: BlocProvider(
        create: (context) => HomeCubit(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme =
        ref.watch(homeProvider.select((value) => value.colorScheme));

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
