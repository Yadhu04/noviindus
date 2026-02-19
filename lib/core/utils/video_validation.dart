import 'dart:io';

// ...existing code...
import 'package:video_player/video_player.dart';

import '../error/exceptions.dart';

class VideoValidation {
  static const maxDuration = Duration(minutes: 5);

  static Future<void> validate(File file) async {
    if (!file.existsSync()) {
      throw ValidationException("Video not found");
    }

    final ext = file.path.split(".").last.toLowerCase();

    if (ext != "mp4") {
      throw ValidationException("Only MP4 videos allowed");
    }

    final controller = VideoPlayerController.file(file);
    await controller.initialize();

    final duration = controller.value.duration;

    await controller.dispose();

    if (duration > maxDuration) {
      throw ValidationException("Video must be under 5 minutes");
    }
  }
}
