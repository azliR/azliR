import 'package:azlir_portfolio/core/constants.dart';
import 'package:azlir_portfolio/views/home/widgets/project_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
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
            SizedBox(
              height: 400,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  final project = projects[index];

                  return ProjectTile(project: project);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
