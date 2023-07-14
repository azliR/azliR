import 'package:azlir_portfolio/main.dart';
import 'package:azlir_portfolio/views/home/widgets/about_section.dart';
import 'package:azlir_portfolio/views/home/widgets/home_section.dart';
import 'package:azlir_portfolio/views/home/widgets/projects_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Section {
  home,
  profile,
  projects;

  ColorScheme getColorScheme(Brightness brightness) {
    switch (this) {
      case Section.home:
        return ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: brightness,
        );
      case Section.profile:
        return ColorScheme.fromSeed(
          seedColor: Colors.yellow,
          brightness: brightness,
        );
      case Section.projects:
        return ColorScheme.fromSeed(
          seedColor: Colors.green,
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
  var _selectedPage = 0;

  @override
  void initState() {
    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;

      if (page != _selectedPage) {
        final section = Section.values[page];

        ref
            .read(colorSchemeProvider.notifier)
            .update((state) => section.getColorScheme(state.brightness));

        setState(() {
          _selectedPage = page;
        });
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
    final brightness = ref.watch(colorSchemeProvider).brightness;

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedPage,
            labelType: NavigationRailLabelType.all,
            elevation: 4,
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
                      ref.read(colorSchemeProvider.notifier).update(
                            (state) => state.copyWith(
                              brightness: state.brightness == Brightness.light
                                  ? Brightness.dark
                                  : Brightness.light,
                            ),
                          );
                    },
                    icon: brightness == Brightness.dark
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
                icon: Icon(Icons.emoji_events_outlined),
                selectedIcon: Icon(Icons.emoji_events),
                label: Text('Projects'),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              pageSnapping: false,
              children: const [
                HomeSection(),
                AboutSection(),
                ProjectsSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
