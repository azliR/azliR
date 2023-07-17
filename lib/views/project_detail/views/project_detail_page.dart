import 'package:azlir_portfolio/core/constants.dart';
import 'package:azlir_portfolio/models/project.dart';
import 'package:azlir_portfolio/views/gallery/views/gallery_page.dart';
import 'package:azlir_portfolio/views/home/widgets/wrap_tags_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({required this.id, super.key});

  final String id;

  void _onImageTapped({
    required BuildContext context,
    required Project project,
    required int index,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => GalleryPage(
          images: project.images,
          index: index,
          title: '${project.name} Gallery',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final project = projects.firstWhere((project) => project.id == id);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(project.name),
          ),
          SliverToBoxAdapter(
            child: CarouselSlider.builder(
              itemCount: project.images.length,
              itemBuilder: (context, index, realIndex) {
                final image = project.images[index];

                return InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  onTap: () => _onImageTapped(
                    context: context,
                    project: project,
                    index: index,
                  ),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      side: BorderSide(
                        color: colorScheme.outline,
                      ),
                    ),
                    child: Hero(
                      tag: index,
                      child: CachedNetworkImage(
                        imageUrl: image,
                        progressIndicatorBuilder: (context, url, progress) =>
                            const CircularProgressIndicator(),
                      ),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: size.height * 0.6,
                viewportFraction: 0.2,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              ),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.all(24)),
          SliverToBoxAdapter(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final vertical = width < 600;

                return Flex(
                  direction: vertical ? Axis.vertical : Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: vertical ? 0 : 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: MarkdownBody(
                          data: project.description,
                          selectable: true,
                          extensionSet: md.ExtensionSet(
                            md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                            [
                              md.EmojiSyntax(),
                              ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (!vertical) const VerticalDivider() else const Divider(),
                    Expanded(
                      flex: vertical ? 0 : 1,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Short description:',
                              style: textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(project.shortDescription),
                            const SizedBox(height: 24),
                            Text(
                              'Technology used:',
                              style: textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            WrapTags(tags: project.tags),
                            const SizedBox(height: 24),
                            Text(
                              'Platforms:',
                              style: textTheme.titleMedium,
                            ),
                            if (project.platforms != null) ...[
                              const SizedBox(height: 8),
                              WrapTags(tags: project.platforms!),
                            ],
                            if (project.sourceCode != null) ...[
                              const SizedBox(height: 24),
                              Text(
                                'Source code:',
                                style: textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              OutlinedButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  switch (Uri.parse(project.sourceCode!).host) {
                                    'github.com' => MdiIcons.github,
                                    'gitlab.com' => MdiIcons.gitlab,
                                    'bitbucket.org' => MdiIcons.bitbucket,
                                    _ => MdiIcons.git,
                                  },
                                ),
                                label: Text(
                                  switch (Uri.parse(project.sourceCode!).host) {
                                    'github.com' => 'Github',
                                    'gitlab.com' => 'Github',
                                    'bitbucket.org' => 'BitBucket',
                                    _ => 'Source',
                                  },
                                ),
                              )
                            ],
                            if (project.documents != null) ...[
                              const SizedBox(height: 24),
                              Text(
                                'Documents:',
                                style: textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              ...project.documents!.entries.map((entry) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: OutlinedButton.icon(
                                    onPressed: () =>
                                        launchUrl(Uri.parse(entry.value)),
                                    icon: const Icon(Icons.description),
                                    label: Text(entry.key),
                                  ),
                                );
                              }),
                            ],
                            if (project.visits != null) ...[
                              const SizedBox(height: 24),
                              Text(
                                'Visits:',
                                style: textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              ...project.visits!.map((link) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: ElevatedButton.icon(
                                    onPressed: () => launchUrl(Uri.parse(link)),
                                    icon: Icon(
                                      switch (Uri.parse(link).host) {
                                        'play.google.com' =>
                                          MdiIcons.googlePlay,
                                        'apps.apple.com' => MdiIcons.apple,
                                        'www.microsoft.com' =>
                                          MdiIcons.microsoft,
                                        _ => MdiIcons.web,
                                      },
                                    ),
                                    label: Text(
                                      switch (Uri.parse(link).host) {
                                        'play.google.com' => 'Google Play',
                                        'apps.apple.com' => 'App Store',
                                        'www.microsoft.com' =>
                                          'Microsoft Store',
                                        _ => 'Visit',
                                      },
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 64),
          )
        ],
      ),
    );
  }
}
