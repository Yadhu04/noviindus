import 'dart:io';
import '../../domain/entities/feed.dart';
import '../datasource/feed_remote_ds.dart';
import '../models/feed_model.dart';

class FeedRepositoryImpl {
  final FeedRemoteDS ds;

  FeedRepositoryImpl(this.ds);

  Future<void> upload({
    required String token,
    required File video,
    required File image,
    required String desc,
    required List<int> categories,
    Function(double)? progress,
  }) {
    return ds.upload(
      token: token,
      video: video,
      image: image,
      desc: desc,
      categories: categories,
      progress: progress,
    );
  }

  Future<(List<Feed>, String?)> myFeeds(String token, {String? next}) async {
    final Map<String, dynamic> res = next == null
        ? await ds.myFeeds(token)
        : await ds.myFeedsNext(token, next);

    final List<Feed> feeds = (res["results"] as List)
        .map<Feed>((e) => FeedModel.fromJson(e))
        .toList();

    final String? nextUrl = res["next"]?.toString();

    return (feeds, nextUrl);
  }
}
