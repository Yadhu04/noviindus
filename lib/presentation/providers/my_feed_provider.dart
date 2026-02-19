import 'package:flutter/material.dart';
import '../../domain/entities/feed.dart';
import '../../domain/usecases/my_feed_usecase.dart';

class MyFeedProvider extends ChangeNotifier {
  final MyFeedUseCase usecase;

  MyFeedProvider(this.usecase);

  List<Feed> feeds = [];
  bool loading = false;
  String? nextUrl;

  Future<void> load(String token) async {
    if (loading) return;

    loading = true;
    notifyListeners();

    try {
      final result = await usecase(token, next: nextUrl);

      feeds.addAll(result.$1);
      nextUrl = result.$2;
    } catch (e) {
      debugPrint("MY FEED ERROR => $e");
    }

    loading = false;
    notifyListeners();
  }

  bool get hasMore => nextUrl != null;

  void refresh() {
    feeds.clear();
    nextUrl = null;
    notifyListeners();
  }
}
