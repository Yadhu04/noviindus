import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoManagerProvider extends ChangeNotifier {
  VideoPlayerController? _controller;
  int? _currentId;

  VideoPlayerController? get controller => _controller;

  bool isPlaying(int id) => _currentId == id;

  bool initialized = false;

  Future<void> prepareFirst(String url) async {
    await controller?.dispose();

    _controller = VideoPlayerController.networkUrl(Uri.parse(url));
    await _controller!.initialize();

    initialized = true;
    notifyListeners();
  }

  Future<void> play(int id, String url) async {
    if (_currentId == id) {
      if (_controller!.value.isPlaying) {
        await _controller!.pause();
      } else {
        await _controller!.play();
      }
      notifyListeners();
      return;
    }

    await _dispose();

    _currentId = id;
    _controller = VideoPlayerController.networkUrl(Uri.parse(url));

    await _controller!.initialize();
    await _controller!.play();

    notifyListeners();
  }

  Future<void> _dispose() async {
    if (_controller != null) {
      await _controller!.dispose();
      _controller = null;
      _currentId = null;
    }
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }
}
