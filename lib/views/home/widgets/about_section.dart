import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Align(
          alignment: Alignment.centerLeft,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final direction =
                  constraints.maxWidth > 800 ? Axis.horizontal : Axis.vertical;

              return Flex(
                direction: direction,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        'About me',
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  color: colorScheme.onSurface,
                                ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 2,
                    child: Text(
                      '''
Hi! I am a mobile application developer, especially using the Flutter SDK. I can help you build apps with beautiful design, either from Figma, Adobe XD, or our creative design. My expertise in state management is using BloC with clean architecture, so that the lines of code are clean, modular, structured, and easily testable, making them easy to maintain.

I have worked in other fields as well such as web, backend, database and machine learning. You can see some of the projects I've worked on on the Projects page.

I look forward to working with you to design and provide the right solution to fit your budget, deadlines, and requirements. Together, let's turn your creative ideas into extraordinary products!
          ''',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: colorScheme.onSurface,
                          ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
