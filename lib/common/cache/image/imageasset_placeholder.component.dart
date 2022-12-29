import 'package:flutter/material.dart';

class ImageAssetPlaceholderComponent extends StatelessWidget {
  /// This is the base component for every asset image, and must be used
  /// whenever you need to display any asset image.
  const ImageAssetPlaceholderComponent({
    Key? key,
    required this.image,
    this.fit = BoxFit.cover,
    this.height = 200,
    this.width = double.maxFinite,
  }) : super(key: key);

  final ImageProvider image;
  final BoxFit fit;

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: image,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }

        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: const Duration(milliseconds: 500),
          child: child,
        );
      },
      fit: fit,
      height: height,
      width: width,
    );
  }
}
