import '../../core/network/api_client.dart';
import '../../core/constants/api_constants.dart';

class HomeRemoteDS {
  final ApiClient api;

  HomeRemoteDS(this.api);

  Future<dynamic> categories() {
    return api.get(ApiConstants.categoryList);
  }

  Future<dynamic> feeds() {
    return api.get(ApiConstants.home);
  }
}
