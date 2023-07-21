import 'package:azlir_portfolio/core/constants.dart';
import 'package:azlir_portfolio/models/project.dart';
import 'package:azlir_portfolio/notifier/home/home_notifier.dart';
import 'package:azlir_portfolio/views/home/widgets/project_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProjectsGrid extends ConsumerWidget {
  const ProjectsGrid({required this.crossAxisCount, super.key});

  final int crossAxisCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTags =
        ref.watch(homeProvider.select((value) => value.selectedTags));

    List<Project> filteredProjects;

    if (selectedTags.isNotEmpty) {
      filteredProjects = projects
          .where(
            (project) => project.tags.any(selectedTags.contains),
          )
          .toList();
    } else {
      filteredProjects = projects;
    }
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 24),
      sliver: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 3 / 4,
        ),
        // shrinkWrap: true,
        itemCount: filteredProjects.length,
        itemBuilder: (context, index) {
          final project = filteredProjects[index];

          return ProjectTile(project: project);
        },
      ),
    );
  }
}
