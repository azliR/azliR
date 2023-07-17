import 'package:azlir_portfolio/models/project.dart';
import 'package:azlir_portfolio/views/home/widgets/wrap_tags_widget.dart';
import 'package:azlir_portfolio/views/project_detail/views/project_detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProjectTile extends StatelessWidget {
  const ProjectTile({required this.project, super.key});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Flex(
          direction: project.vertical ? Axis.vertical : Axis.horizontal,
          children: [
            Flexible(
              flex: project.vertical ? 0 : 1,
              child: Align(
                alignment: Alignment.topCenter,
                child: Hero(
                  tag: project.images.first,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: CachedNetworkImage(
                      imageUrl: project.images.first,
                      placeholder: (context, url) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: project.vertical ? 0 : 12,
              height: project.vertical ? 8 : 0,
            ),
            Expanded(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: project.vertical ? 0 : 200,
                  minHeight: project.vertical ? 200 : 0,
                ),
                child: Column(
                  crossAxisAlignment: project.vertical
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      project.name,
                      style: textTheme.titleMedium,
                      textAlign:
                          project.vertical ? TextAlign.center : TextAlign.start,
                    ),
                    const SizedBox(height: 2),
                    Flexible(
                      flex: 0,
                      child: SelectableText(
                        project.shortDescription,
                        style: textTheme.bodySmall?.copyWith(
                          overflow: TextOverflow.ellipsis,
                        ),
                        textAlign: project.vertical
                            ? TextAlign.center
                            : TextAlign.start,
                      ),
                    ),
                    if (project.platforms != null) ...[
                      const SizedBox(height: 8),
                      WrapTags(
                        alignment: project.vertical
                            ? WrapAlignment.center
                            : WrapAlignment.start,
                        runAlignment: project.vertical
                            ? WrapAlignment.center
                            : WrapAlignment.start,
                        tags: project.platforms!,
                      ),
                    ],
                    const Spacer(),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.tonal(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) =>
                                  ProjectDetailPage(id: project.id),
                            ),
                          );
                        },
                        child: const Text('Detail'),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
