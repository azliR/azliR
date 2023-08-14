import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({
    required this.title,
    required this.index,
    required this.images,
    super.key,
  });

  final String title;
  final int index;
  final List<String> images;

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.escape): () {
          Navigator.pop(context);
        },
      },
      child: Focus(
        autofocus: true,
        child: Scaffold(
          body: Stack(
            children: [
              PhotoViewGallery.builder(
                itemCount: widget.images.length,
                pageController: _pageController,
                builder: (context, index) {
                  final image = widget.images[index];

                  return PhotoViewGalleryPageOptions(
                    imageProvider: CachedNetworkImageProvider(image),
                    heroAttributes: PhotoViewHeroAttributes(tag: image),
                  );
                },
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: IconButton.filledTonal(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: IconButton.filled(
                    onPressed: () {
                      _pageController.animateToPage(
                        _pageController.page!.round() - 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                    icon: const Icon(Icons.chevron_left_rounded),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: IconButton.filled(
                    onPressed: () {
                      _pageController.animateToPage(
                        _pageController.page!.round() + 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                    icon: const Icon(Icons.chevron_right_rounded),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
