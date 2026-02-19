import '../../domain/entities/category.dart';
import '../../domain/entities/feed.dart';
import '../datasource/home_remote_ds.dart';
import '../models/category_model.dart';
import '../models/feed_model.dart';

class HomeRepositoryImpl {
  final HomeRemoteDS ds;

  HomeRepositoryImpl(this.ds);

  Future<List<Category>> getCategories() async {
    final res = await ds.categories();

    return (res["categories"] as List)
        .map((e) => CategoryModel.fromJson(e))
        .toList();
  }

  Future<List<Feed>> getFeeds() async {
    final res = await ds.feeds();

    return (res["results"] as List).map((e) => FeedModel.fromJson(e)).toList();
  }
}
