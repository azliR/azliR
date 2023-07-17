import 'package:azlir_portfolio/blocs/home/home_cubit.dart';
import 'package:azlir_portfolio/core/constants.dart';
import 'package:azlir_portfolio/models/project.dart';
import 'package:azlir_portfolio/views/home/widgets/project_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    return Material(
      color: colorScheme.background,
      child: BlocSelector<HomeCubit, HomeState, List<String>>(
        selector: (state) => state.selectedTags,
        builder: (context, selectedTags) {
          List<Project> filteredProjects;

          if (selectedTags.isNotEmpty) {
            filteredProjects = projects.where(
              (project) {
                return project.tags.any((tag) => selectedTags.contains(tag));
              },
            ).toList();
          } else {
            filteredProjects = projects;
          }

          return Column(
            children: [
              Text(
                'My Projects',
                style: textTheme.headlineMedium
                    ?.copyWith(color: colorScheme.onBackground),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'You can find my projects on ',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onBackground,
                        ),
                  ),
                  TextButton(
                    onPressed: () =>
                        launchUrl(Uri.parse('https://github.com/azliR')),
                    child: const Text('my GitHub profile'),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
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
              const SizedBox(height: 16),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                shrinkWrap: true,
                itemCount: filteredProjects.length,
                itemBuilder: (context, index) {
                  final project = filteredProjects[index];

                  return ProjectTile(project: project);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
