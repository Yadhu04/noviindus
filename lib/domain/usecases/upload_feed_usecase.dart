import 'dart:io';
import '../../data/repositories/feed_repository_impl.dart';

class UploadFeedUseCase {
  final FeedRepositoryImpl repo;

  UploadFeedUseCase(this.repo);

  Future<void> call({
    required String token,
    required File video,
    required File image,
    required String desc,
    required List<int> categories,
    Function(double)? progress,
  }) {
    return repo.upload(
      token: token,
      video: video,
      image: image,
      desc: desc,
      categories: categories,
      progress: progress,
    );
  }
}
