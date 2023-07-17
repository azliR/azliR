import 'package:azlir_portfolio/blocs/home/home_cubit.dart';
import 'package:azlir_portfolio/views/home/widgets/about_section.dart';
import 'package:azlir_portfolio/views/home/widgets/home_section.dart';
import 'package:azlir_portfolio/views/home/widgets/projects_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Section {
  home,
  profile,
  projects;

  ColorScheme getColorScheme(Brightness brightness) {
    switch (this) {
      case Section.home:
        return ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: brightness,
        );
      case Section.profile:
        return ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: brightness,
        );
      case Section.projects:
        return ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: brightness,
        );
    }
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController();

  @override
  void initState() {
    final homeCubit = context.read<HomeCubit>();

    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;

      if (page != homeCubit.state.selectedSection &&
          page < Section.values.length) {
        final section = Section.values[page];
        final colorScheme =
            section.getColorScheme(homeCubit.state.colorScheme.brightness);

        homeCubit
          ..onColorSchemeChanged(colorScheme)
          ..onSelectedSectionChanged(page);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();

    return Scaffold(
      body: Row(
        children: [
          BlocSelector<HomeCubit, HomeState, int>(
            selector: (state) => state.selectedSection,
            builder: (context, selectedSection) {
              return NavigationRail(
                selectedIndex: selectedSection,
                labelType: NavigationRailLabelType.all,
                onDestinationSelected: (value) {
                  _pageController.animateToPage(
                    value,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
                trailing: Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: BlocSelector<HomeCubit, HomeState, ColorScheme>(
                        selector: (state) => state.colorScheme,
                        builder: (context, colorScheme) {
                          return IconButton.outlined(
                            onPressed: () {
                              homeCubit.onColorSchemeChanged(
                                Section.values[selectedSection].getColorScheme(
                                  colorScheme.brightness == Brightness.light
                                      ? Brightness.dark
                                      : Brightness.light,
                                ),
                              );
                            },
                            icon: colorScheme.brightness == Brightness.dark
                                ? const Icon(Icons.light_mode_outlined)
                                : const Icon(Icons.dark_mode_outlined),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.question_mark_rounded),
                    selectedIcon: Icon(Icons.question_mark_rounded),
                    label: Text('What?'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.person_outline_rounded),
                    selectedIcon: Icon(Icons.person_rounded),
                    label: Text('Profile'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.emoji_events_outlined),
                    selectedIcon: Icon(Icons.emoji_events),
                    label: Text('Projects'),
                  ),
                ],
              );
            },
          ),
          const VerticalDivider(width: 2),
          Expanded(
            child: CustomScrollView(
              controller: _pageController,
              slivers: const [
                SliverToBoxAdapter(
                  child: HomeSection(),
                ),
                SliverToBoxAdapter(
                  child: AboutSection(),
                ),
                SliverToBoxAdapter(
                  child: ProjectsSection(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
