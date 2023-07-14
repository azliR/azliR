import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ColoredBox(
      color: colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    'About me',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: colorScheme.onBackground,
                        ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 2,
                child: Text(
                  'I am a Flutter developer',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onBackground,
                      ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
