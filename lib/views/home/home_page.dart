import 'dart:math';

import 'package:azlir_portfolio/notifier/home/home_notifier.dart';
import 'package:azlir_portfolio/views/home/widgets/about_section.dart';
import 'package:azlir_portfolio/views/home/widgets/contacts_section.dart';
import 'package:azlir_portfolio/views/home/widgets/home_section.dart';
import 'package:azlir_portfolio/views/home/widgets/projects_grid_widget.dart';
import 'package:azlir_portfolio/views/home/widgets/projects_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Section {
  home,
  profile,
  contacts,
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
          seedColor: Colors.yellow,
          brightness: brightness,
        );
      case Section.contacts:
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

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _pageController = PageController();

  @override
  void initState() {
    var currentPage = 0;

    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;

      if (page != currentPage && page < Section.values.length) {
        final homeState = ref.read(homeProvider);
        final section = Section.values[page];

        ref.read(homeProvider.notifier)
          ..onColorSchemeChanged(
            section.getColorScheme(homeState.colorScheme.brightness),
          )
          ..onSelectedSectionChanged(page);
      }
      currentPage = page;
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
    final colorScheme = Theme.of(context).colorScheme;

    final homeNotifier = ref.watch(homeProvider.notifier);
    final selectedSection =
        ref.watch(homeProvider.select((value) => value.selectedSection));
    final currentBrightness = ref.watch(
      homeProvider.select((value) => value.colorScheme.brightness),
    );

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
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
                  child: IconButton.outlined(
                    onPressed: () {
                      homeNotifier.onColorSchemeChanged(
                        Section.values[selectedSection].getColorScheme(
                          currentBrightness == Brightness.light
                              ? Brightness.dark
                              : Brightness.light,
                        ),
                      );
                    },
                    icon: currentBrightness == Brightness.dark
                        ? const Icon(Icons.light_mode_outlined)
                        : const Icon(Icons.dark_mode_outlined),
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
                icon: Icon(Icons.call_outlined),
                selectedIcon: Icon(Icons.call_rounded),
                label: Text('Contacts'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.emoji_events_outlined),
                selectedIcon: Icon(Icons.emoji_events),
                label: Text('Projects'),
              ),
            ],
          ),
          const VerticalDivider(width: 2),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return CustomScrollView(
                  controller: _pageController,
                  slivers: [
                    const SliverToBoxAdapter(
                      child: HomeSection(),
                    ),
                    const SliverToBoxAdapter(
                      child: AboutSection(),
                    ),
                    const SliverToBoxAdapter(
                      child: ContactsSection(),
                    ),
                    const SliverToBoxAdapter(
                      child: ProjectsSection(),
                    ),
                    ProjectsGrid(
                      crossAxisCount: max(constraints.maxWidth ~/ 300, 1),
                    ),
                    const SliverPadding(padding: EdgeInsets.all(8)),
                    SliverToBoxAdapter(
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Made with '),
                            Icon(Icons.favorite, color: colorScheme.primary),
                            const Text(' using '),
                            const FlutterLogo(),
                          ],
                        ),
                      ),
                    ),
                    const SliverPadding(padding: EdgeInsets.all(16)),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
