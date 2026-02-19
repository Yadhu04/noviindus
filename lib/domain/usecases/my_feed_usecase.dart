import '../../data/repositories/feed_repository_impl.dart';
import '../../domain/entities/feed.dart';

class MyFeedUseCase {
  final FeedRepositoryImpl repo;

  MyFeedUseCase(this.repo);

  Future<(List<Feed>, String?)> call(String token, {String? next}) {
    return repo.myFeeds(token, next: next);
  }
}
