import 'package:flutter/material.dart';

class WrapTags extends StatelessWidget {
  const WrapTags({
    required this.tags,
    super.key,
    this.alignment = WrapAlignment.start,
    this.runAlignment = WrapAlignment.start,
  });

  final WrapAlignment alignment;
  final WrapAlignment runAlignment;
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Wrap(
      alignment: alignment,
      runAlignment: runAlignment,
      spacing: 4,
      runSpacing: 4,
      children: tags.map((platform) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: colorScheme.secondary,
          ),
          child: Text(
            platform,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
        );
      }).toList(),
    );
  }
}
