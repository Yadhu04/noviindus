import '../../data/repositories/home_repository_impl.dart';
import '../entities/category.dart';
import '../entities/feed.dart';

class GetHomeUseCase {
  final HomeRepositoryImpl repo;

  GetHomeUseCase(this.repo);

  Future<List<Category>> categories() => repo.getCategories();
  Future<List<Feed>> feeds() => repo.getFeeds();
}
