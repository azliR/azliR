import 'package:azlir_portfolio/models/project.dart';
import 'package:azlir_portfolio/views/home/widgets/wrap_tags_widget.dart';
import 'package:azlir_portfolio/views/project_detail/views/project_detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProjectTile extends StatelessWidget {
  const ProjectTile({required this.project, super.key});

  final Project project;

  Future<void> _onVisitPressed(BuildContext context) async {
    if (project.visits!.length == 1) {
      await launchUrlString(project.visits!.first);
    } else {
      await showDialog<void>(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Select a link'),
            children: [
              for (final link in project.visits!)
                SimpleDialogOption(
                  onPressed: () async {
                    await launchUrlString(link).then(
                      (value) => Navigator.pop(context),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        switch (Uri.parse(link).host) {
                          'play.google.com' => MdiIcons.googlePlay,
                          'apps.apple.com' => MdiIcons.apple,
                          'www.microsoft.com' => MdiIcons.microsoft,
                          _ => MdiIcons.web,
                        },
                      ),
                      const SizedBox(width: 12),
                      Text(
                        switch (Uri.parse(link).host) {
                          'play.google.com' => 'Google Play',
                          'apps.apple.com' => 'App Store',
                          'www.microsoft.com' => 'Microsoft Store',
                          _ => link,
                        },
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      );
    }
  }

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
                      alignment: Alignment.topCenter,
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
                      child: Flex(
                        direction:
                            project.vertical ? Axis.horizontal : Axis.vertical,
                        children: [
                          Flexible(
                            flex: project.vertical ? 1 : 0,
                            child: SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(4),
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
                            ),
                          ),
                          if (project.visits?.isNotEmpty ?? false)
                            Flexible(
                              flex: project.vertical ? 1 : 0,
                              child: SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: FilledButton.icon(
                                    onPressed: () => _onVisitPressed(context),
                                    icon: const Icon(
                                      Icons.open_in_new,
                                      size: 16,
                                    ),
                                    label: const Text('Visit'),
                                  ),
                                ),
                              ),
                            ),
                        ],
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
