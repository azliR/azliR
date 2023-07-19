import 'package:azlir_portfolio/blocs/home/home_cubit.dart';
import 'package:azlir_portfolio/core/constants.dart';
import 'package:azlir_portfolio/models/project.dart';
import 'package:azlir_portfolio/views/home/widgets/project_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectsGrid extends StatelessWidget {
  const ProjectsGrid({required this.crossAxisCount, super.key});

  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit, HomeState, List<String>>(
      selector: (state) => state.selectedTags,
      builder: (context, selectedTags) {
        List<Project> filteredProjects;

        if (selectedTags.isNotEmpty) {
          filteredProjects = projects
              .where(
                (project) =>
                    project.tags.any((tag) => selectedTags.contains(tag)),
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
      },
    );
  }
}
