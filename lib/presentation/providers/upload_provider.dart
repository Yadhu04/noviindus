import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../../domain/usecases/upload_feed_usecase.dart';
import '../../core/utils/video_validation.dart';
import '../../core/utils/image_validation.dart';

class UploadProvider extends ChangeNotifier {
  final UploadFeedUseCase usecase;

  UploadProvider(this.usecase);

  bool uploading = false;
  double progress = 0;
  VideoPlayerController? previewController;

  Future<void> upload({
    required String token,
    required File video,
    required File image,
    required String desc,
    required List<int> categories,
  }) async {
    uploading = true;
    progress = 0;
    notifyListeners();

    await VideoValidation.validate(video);
    ImageValidation.validate(image);

    await usecase(
      token: token,
      video: video,
      image: image,
      desc: desc,
      categories: categories,
      progress: (p) {
        progress = p;
        notifyListeners();
      },
    );

    uploading = false;
    notifyListeners();
  }

  List<int> categoryIds = [];
  bool categoriesExpanded = false;

  void toggleCategory(int id) {
    if (categoryIds.contains(id)) {
      categoryIds.remove(id);
    } else {
      categoryIds.add(id);
    }
    notifyListeners();
  }

  void toggleExpanded() {
    categoriesExpanded = !categoriesExpanded;
    notifyListeners();
  }

  File? video;
  File? image;
  String description = "";
  final picker = ImagePicker();

  Future<void> pickVideo() async {
    final file = await picker.pickVideo(source: ImageSource.gallery);

    if (file != null) {
      video = File(file.path);

      /// dispose old controller
      await previewController?.dispose();

      /// create preview controller
      previewController = VideoPlayerController.file(video!);
      await previewController!.initialize();

      notifyListeners();
    }
  }

  Future<void> pickImage() async {
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      image = File(file.path);
      notifyListeners();
    }
  }

  void setDescription(String v) {
    description = v;
  }

  Future<void> submit(String token) async {
    if (video == null) throw Exception("Video required");
    if (image == null) throw Exception("Thumbnail required");
    if (description.trim().isEmpty) throw Exception("Description required");
    if (categoryIds.isEmpty) throw Exception("Select categories");

    uploading = true;
    progress = 0;
    notifyListeners();

    try {
      await usecase(
        token: token,
        video: video!,
        image: image!,
        desc: description,
        categories: categoryIds,
        progress: (p) {
          progress = p;
          notifyListeners();
        },
      );
      print("Upload successful");

      /// ⭐ IMPORTANT — reset AFTER success
      reset();
    } finally {
      print("Upload ended");
      uploading = false;
      notifyListeners();
    }
  }

  void reset() {
    video = null;
    image = null;
    description = "";
    categoryIds.clear();

    previewController?.dispose();
    previewController = null;

    notifyListeners();
  }
}
