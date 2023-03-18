import 'package:flutter/material.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({super.key, required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text.rich(
          TextSpan(
            text: "I'm ",
            style:
                textTheme.headlineLarge?.copyWith(color: colorScheme.outline),
            children: [
              TextSpan(
                text: "Rizal Hadiyansah",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onBackground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
