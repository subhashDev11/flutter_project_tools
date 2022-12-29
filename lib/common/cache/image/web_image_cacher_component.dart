import 'package:flutter/cupertino.dart';
import 'package:flutter_project_tools/core/utils/utils_image.dart';
import 'package:transparent_image/transparent_image.dart';
import 'image_cacher.component.dart';

class ImageCacherComponentWeb extends StatefulWidget {
  static const String name = 'ImageCacherComponentWeb';

  final String? imageUrl;
  final double? width;
  final double imageRatio;
  final double? height;
  final BoxFit? fit;
  final bool squareWidth;
  final bool isTrackCompletedImage;
  final Alignment alignment;
  final double radius;
  final bool? useEmptyImagePlaceholder;

  const ImageCacherComponentWeb(
      {Key? key,
      this.imageUrl,
      this.width,
      this.imageRatio = 1,
      this.height,
      this.fit,
      this.squareWidth = false,
      this.isTrackCompletedImage = false,
      this.alignment = Alignment.center,
      this.radius = 0,
      this.useEmptyImagePlaceholder})
      : super(key: key);

  @override
  ImageCacherComponentWebState createState() => ImageCacherComponentWebState();
}

class ImageCacherComponentWebState extends State<ImageCacherComponentWeb> {
  bool imagesLoaded = false;
  bool preloadedImages = false;

  @override
  void didUpdateWidget(ImageCacherComponentWeb oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl) {
      preloadedImages = false;
      imagesLoaded = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrl == null) {
      return const SizedBox();
    }

    if (widget.imageUrl!.isEmpty) {
      return const SizedBox();
    }

    if (!preloadedImages) {
      preloadedImages = true;
      ImageUtils.preloadNetworkImages(context, [
        widget.imageUrl!,
      ]).whenComplete(() {
        if (mounted) {
          imagesLoaded = true;
          setState(() {});
        }
      });
    }

    return LayoutBuilder(builder: (context, constraints) {
      double width = widget.width ?? constraints.maxWidth;
      double height = widget.height ?? (width * widget.imageRatio).roundToDouble();
      return SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            FadeInImage.memoryNetwork(
              image: widget.imageUrl!,
              width: width,
              height: height,
              fit: widget.fit ?? BoxFit.cover,
              fadeOutDuration: const Duration(milliseconds: 100),
              fadeInDuration: const Duration(milliseconds: 200),
              placeholder: kTransparentImage,
              imageErrorBuilder: (context, _, __) => MyPlaceholder(
                  width: width, height: height, useEmptyImagePlaceholder: widget.useEmptyImagePlaceholder ?? false),
              placeholderErrorBuilder: (context, _, error) => MyPlaceholder(
                  width: width, height: height, useEmptyImagePlaceholder: widget.useEmptyImagePlaceholder ?? false),
              alignment: widget.alignment,
            ),
          ],
        ),
      );
    });
  }
}
