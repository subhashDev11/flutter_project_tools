import 'dart:async';
import 'package:flutter_project_tools/common/common_widgets.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:video_player/video_player.dart';

class FullscreenPlayer extends StatefulWidget {
  final String path;

  const FullscreenPlayer({required this.path});

  @override
  _FullscreenPlayerState createState() => _FullscreenPlayerState();
}

class _FullscreenPlayerState extends State<FullscreenPlayer> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  final StreamController<void> _touchEvents = StreamController<void>();
  final _hasVisibleControleNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    _touchEvents.stream
        .doOnData((event) {
          if (_hasVisibleControleNotifier.value) return;
          _hasVisibleControleNotifier.value = true;
        })
        .debounceTime(const Duration(seconds: 3))
        .listen((event) {
          if (mounted) {
            _hasVisibleControleNotifier.value = false;
          }
        });
    _initVideos();
    super.initState();
  }

  @override
  void dispose() {
    if (_videoPlayerController != null) _videoPlayerController?.dispose();
    if (_chewieController != null) _chewieController?.dispose();
    _hasVisibleControleNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      child: _chewieController == null
          ? FutureBuilder(
              future: _initVideos(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                  _touchEvents.add(null);
                  _chewieController = snapshot.data as ChewieController;
                  return _drawButtonOverlay(
                    child: Chewie(
                      controller: snapshot.data as ChewieController,
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )
          : _drawButtonOverlay(
              child: Chewie(
                controller: _chewieController ??
                    ChewieController(
                      videoPlayerController: _videoPlayerController ?? VideoPlayerController.network(widget.path),
                      autoPlay: true,
                      looping: false,
                      allowedScreenSleep: false,
                      fullScreenByDefault: false,
                      placeholder: Container(
                        color: Colors.black,
                      ),
                    ),
              ),
            ),
    );
  }

  Widget _drawButtonOverlay({required Widget child}) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return ValueListenableBuilder<bool>(
        valueListenable: _hasVisibleControleNotifier,
        builder: (context, value, view) {
          return Stack(
            children: [
              child,
              Positioned.fill(
                child: Listener(
                  onPointerUp: (_) => _touchEvents.add(null),
                  behavior: HitTestBehavior.translucent,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: statusBarHeight),
                  child: AnimatedOpacity(
                    opacity: value ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const SizedBox(
                        height: 46.0,
                        width: 64.0,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  Future<ChewieController> _initVideos() async {
    _videoPlayerController = VideoPlayerController.network(widget.path);
    await _videoPlayerController?.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController ?? VideoPlayerController.network(widget.path),
      autoPlay: true,
      looping: false,
      allowedScreenSleep: false,
      fullScreenByDefault: false,
      placeholder: Container(
        color: Colors.black,
      ),
    );
    return _chewieController ??
        ChewieController(
          videoPlayerController: _videoPlayerController ?? VideoPlayerController.network(widget.path),
          autoPlay: true,
          looping: false,
          allowedScreenSleep: false,
          fullScreenByDefault: false,
          placeholder: Container(
            color: Colors.black,
          ),
        );
  }
}
