import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key, required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
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
                'You can find my projects on my ',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onBackground,
                    ),
              ),
              TextButton(
                onPressed: () =>
                    launchUrl(Uri.parse('https://github.com/azliR')),
                child: const Text('GitHub profile'),
              )
            ],
          )
        ],
      ),
    );
  }
}
