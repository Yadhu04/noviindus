import 'package:flutter/material.dart';
import '../../domain/usecases/get_home_usecase.dart';

class HomeProvider extends ChangeNotifier {
  final GetHomeUseCase usecase;

  HomeProvider(this.usecase);

  List categories = [];
  List feeds = [];
  bool loading = false;

  Future<void> load() async {
    loading = true;
    notifyListeners();

    categories = await usecase.categories();
    feeds = await usecase.feeds();

    loading = false;
    notifyListeners();
  }
}
