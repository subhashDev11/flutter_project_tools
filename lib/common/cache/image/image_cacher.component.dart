import 'package:flutter_project_tools/common/common_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_tools/common/cache/image/web_image_cacher_component.dart';

class ImageCacherComponent extends StatelessWidget {
  const ImageCacherComponent({
    Key? key,
    this.imageUrl = '',
    this.width = double.maxFinite,
    this.fit = BoxFit.fitWidth,
    this.useEmptyImagePlaceholder = false,
    this.height = 200,
    this.squareWidth = false,
    this.isTrackCompletedImage = false,
    this.radius = 0,
    this.alignment = Alignment.center,
    this.onTap,
  }) : super(key: key);

  final String? imageUrl;
  final double height;
  final double width;
  final BoxFit fit;
  final bool squareWidth;
  final bool isTrackCompletedImage;
  final Alignment alignment;
  final double radius;
  final bool useEmptyImagePlaceholder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? ImageCacherComponentWeb(
            imageUrl: imageUrl,
            width: width,
            squareWidth: squareWidth,
            isTrackCompletedImage: isTrackCompletedImage,
            alignment: alignment,
            radius: radius,
            useEmptyImagePlaceholder: useEmptyImagePlaceholder,
            height: height,
            fit: fit,
          )
        : ImageCacherComponentMobile(
            imageUrl: imageUrl,
            width: width,
            squareWidth: squareWidth,
            isTrackCompletedImage: isTrackCompletedImage,
            alignment: alignment,
            radius: radius,
            useEmptyImagePlaceholder: useEmptyImagePlaceholder,
            height: height,
            fit: fit,
            onTap: onTap,
          );
  }
}

class ImageCacherComponentMobile extends StatelessWidget {
  ImageCacherComponentMobile({
    Key? key,
    this.imageUrl = '',
    this.width = double.maxFinite,
    this.fit = BoxFit.fitWidth,
    this.useEmptyImagePlaceholder = false,
    this.height = 200,
    this.squareWidth = false,
    this.isTrackCompletedImage = false,
    this.radius = 0,
    this.alignment = Alignment.center,
    this.onTap,
  }) : super(key: key);

  final String? imageUrl;
  final double height;
  final double width;
  final BoxFit fit;
  final bool squareWidth;
  final bool isTrackCompletedImage;
  final Alignment alignment;
  final double radius;
  final bool useEmptyImagePlaceholder;
  final CustomImageCacheManager _cacheManager = CustomImageCacheManager(key: '');
  final Function()? onTap;

  Widget _image(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: GestureDetector(
        onTap: onTap ??
            () => (imageUrl != null
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => FullScreenImagePlayer(
                              image: imageUrl!,
                            )))
                : null),
        child: CachedNetworkImage(
          cacheManager: _cacheManager,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider, fit: fit, alignment: alignment),
            ),
            child: isTrackCompletedImage
                ? Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, right: 8),
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: const Center(
                          child: Icon(Icons.done, color: Colors.orange, size: 12),
                        ),
                      ),
                    ),
                  )
                : null,
          ),
          imageUrl: imageUrl ?? "",
          errorWidget: (context, _, __) =>
              MyPlaceholder(width: width, height: height, useEmptyImagePlaceholder: useEmptyImagePlaceholder),
          placeholder: (context, _) =>
              MyPlaceholder(width: width, height: height, useEmptyImagePlaceholder: useEmptyImagePlaceholder),
          fit: fit,
          width: width,
          useOldImageOnUrlChange: false,
        ),
      ),
    );
  }

  Future<String> getPath(String imageUrl) {
    return _cacheManager.getPath(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return squareWidth
        ? SizedBox(
            width: width,
            child: AspectRatio(
              aspectRatio: 1,
              child: _image(context),
            ),
          )
        : SizedBox(
            width: width,
            height: height,
            child: _image(context),
          );
  }
}

class MyPlaceholder extends StatelessWidget {
  final double height;
  final double width;
  final bool useEmptyImagePlaceholder;

  const MyPlaceholder({Key? key, this.height = 0, this.width = 0, this.useEmptyImagePlaceholder = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (useEmptyImagePlaceholder) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: const DecorationImage(image: AssetImage('assets/images/logo.png'), fit: BoxFit.contain),
          color: theme.primaryColor,
        ),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blueGrey.shade300,
            theme.primaryColor,
          ],
        ),
      ),
    );
  }
}
