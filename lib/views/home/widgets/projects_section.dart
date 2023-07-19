import 'package:azlir_portfolio/blocs/home/home_cubit.dart';
import 'package:azlir_portfolio/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();

    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final tags = projects.fold(<String>{}, (previousValue, element) {
      return previousValue..addAll(element.tags);
    }).toList()
      ..sort();

    return BlocSelector<HomeCubit, HomeState, List<String>>(
      selector: (state) => state.selectedTags,
      builder: (context, selectedTags) {
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
                  onPressed: () =>
                      launchUrl(Uri.parse('https://github.com/azliR')),
                  icon: Icon(MdiIcons.github),
                  label: const Text('GitHub Profile'),
                )
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
                        if (value) {
                          homeCubit.onSelectTag(tag);
                        } else {
                          homeCubit.onUnselectTag(tag);
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
      },
    );
  }
}
