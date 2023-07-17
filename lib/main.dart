import 'package:azlir_portfolio/blocs/home/home_cubit.dart';
import 'package:azlir_portfolio/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();

  runApp(
    BlocProvider(
      create: (context) => HomeCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit, HomeState, ColorScheme>(
      selector: (state) => state.colorScheme,
      builder: (context, colorScheme) {
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
      },
    );
  }
}
