import 'dart:io';
import 'package:flutter_project_tools/core/core.dart';
import 'package:flutter_project_tools/services/overlay_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:flutter_project_tools/common/common_widgets.dart';

const videoSuffixes = ['mp4', 'mov'];

class MediaWidget extends StatefulWidget {
  const MediaWidget({
    Key? key,
    this.media,
    this.height,
    this.onRemoved,
    this.fit,
    this.width,
    this.radius,
    this.withRadius,
  }) : super(key: key);

  final String? media;
  final double? height;
  final double? width;
  final VoidCallback? onRemoved;
  final BoxFit? fit;
  final double? radius;
  final bool? withRadius;

  @override
  _MediaWidgetState createState() => _MediaWidgetState();
}

class _MediaWidgetState extends State<MediaWidget> {
  final defaultDuration = const Duration(seconds: 2);

  //late Future<String?> videoThumbnailInitialization;
  late OverlayContract _overlayService;

  bool get isVideoMedia => videoSuffixes.contains(widget.media?.split('.').last.toLowerCase());
  final _videoPlayerThumbNotifier = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    _overlayService = GetIt.I<OverlayService>();
    if (isVideoMedia) {
      videoThumbnailGeneration();
    }
  }

  void videoThumbnailGeneration() async {
    final res = await VideoThumbnail.thumbnailFile(
      video: widget.media as String,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 200,
      quality: 80,
    );
    if (mounted) {
      _videoPlayerThumbNotifier.value = res;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const SizedBox();
    }

    if (widget.media?.isEmpty ?? true) {
      return Container();
    }
    if (isVideoMedia) {
      return _wrapWithRemoveButton(
        child: ValueListenableBuilder<String?>(
            valueListenable: _videoPlayerThumbNotifier,
            builder: (context, snapshot, child) {
              if (snapshot == null) {
                return ClipRRect(
                  borderRadius:
                      widget.withRadius ?? true ? BorderRadius.circular(widget.radius ?? 10) : BorderRadius.zero,
                  child: ShimmerComponent(
                    child: Container(
                      height: widget.height ?? 200,
                      width: widget.width,
                      color: Colors.black,
                    ),
                  ),
                );
              }
              if (snapshot != null) {
                return GestureDetector(
                  onTap: () {
                    _overlayService.showModal(
                      ModalType.fullscreenVideo,
                      arguments: {'path': widget.media},
                    );
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius:
                            widget.withRadius ?? true ? BorderRadius.circular(widget.radius ?? 10) : BorderRadius.zero,
                        child: Image.file(File(snapshot),
                            height: widget.height ?? 200,
                            fit: widget.fit,
                            width: widget.width,
                            alignment: Alignment.topCenter),
                      ),
                      const Positioned.fill(
                          child: Icon(
                        Icons.play_arrow,
                        size: 32,
                        color: Colors.white,
                      ))
                    ],
                  ),
                );
              } else {
                return const SizedBox();
              }
            }),
      );
    }
    return _wrapWithRemoveButton(
      child: GestureDetector(
        onTap: () {
          _overlayService.showModal(
            ModalType.fullscreenImage,
            arguments: {'path': widget.media},
          );
          // arguments: {'path': widget.media});
        },
        child: ClipRRect(
          borderRadius: widget.withRadius ?? true ? BorderRadius.circular(widget.radius ?? 10) : BorderRadius.zero,
          child: widget.media!.startsWith('/')
              ? Image.file(
                  File(widget.media as String),
                  height: widget.height ?? 200,
                  fit: widget.fit,
                  width: widget.width,
                  alignment: Alignment.center,
                )
              : ImageCacherComponent(
                  imageUrl: widget.media as String,
                  width: widget.width as double,
                  height: widget.height ?? 200,
                  fit: widget.fit as BoxFit,
                  alignment: Alignment.center,
                ),
        ),
      ),
    );
  }

  Widget _wrapWithRemoveButton({required Widget child}) {
    if (widget.onRemoved == null) {
      return child;
    }
    return Stack(
      children: [
        child,
        Positioned(
          top: 8,
          left: 8,
          child: GestureDetector(onTap: widget.onRemoved, child: const Icon(Icons.close)),
        )
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _videoPlayerThumbNotifier.dispose();
    super.dispose();
  }
}
