import 'package:azlir_portfolio/main.dart';
import 'package:azlir_portfolio/widgets/about_section.dart';
import 'package:azlir_portfolio/widgets/home_section.dart';
import 'package:azlir_portfolio/widgets/projects_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Section {
  home,
  profile,
  projects;

  ColorScheme get colorScheme {
    switch (this) {
      case Section.home:
        return ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        );
      case Section.profile:
        return ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        );
      case Section.projects:
        return ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: Brightness.dark,
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
      final section = Section.values[page];

      ref
          .read(colorSchemeProvider.notifier)
          .update((state) => section.colorScheme);

      if (page != _selectedPage) {
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
              children: [
                HomeSection(colorScheme: Section.home.colorScheme),
                AboutSection(colorScheme: Section.profile.colorScheme),
                ProjectsSection(colorScheme: Section.projects.colorScheme),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
