import 'package:azlir_portfolio/core/constants.dart';
import 'package:azlir_portfolio/notifier/home/home_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends ConsumerWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final selectedTags =
        ref.watch(homeProvider.select((value) => value.selectedTags));

    final tags = projects.fold(<String>{}, (previousValue, element) {
      return previousValue..addAll(element.tags);
    }).toList()
      ..sort();

    return Column(
      children: [
        Text(
          'My Projects',
          style: textTheme.headlineMedium
              ?.copyWith(color: colorScheme.onBackground),
        ),
        const SizedBox(height: 16),
        Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              'You can find my projects on my ',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onBackground,
                  ),
            ),
            FilledButton.tonalIcon(
              onPressed: () => launchUrl(Uri.parse('https://github.com/azliR')),
              icon: Icon(MdiIcons.github),
              label: const Text('GitHub Profile'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            children: tags.map(
              (tag) {
                return FilterChip(
                  label: Text(tag),
                  selected: selectedTags.contains(tag),
                  onSelected: (value) {
                    final homeNotifier = ref.read(homeProvider.notifier);
                    if (value) {
                      homeNotifier.onSelectTag(tag);
                    } else {
                      homeNotifier.onUnselectTag(tag);
                    }
                  },
                );
              },
            ).toList(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
