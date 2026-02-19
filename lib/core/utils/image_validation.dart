import 'dart:io';
import '../error/exceptions.dart';

class ImageValidation {
  static void validate(File file) {
    if (!file.existsSync()) {
      throw ValidationException("Thumbnail required");
    }

    final ext = file.path.split(".").last.toLowerCase();

    const allowed = ["jpg", "jpeg", "png", "webp"];

    if (!allowed.contains(ext)) {
      throw ValidationException("Invalid image format");
    }
  }
}
