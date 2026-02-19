import 'dart:io';
import 'package:http/http.dart' as http;
import '../../core/network/api_client.dart';
import '../../core/constants/api_constants.dart';

class FeedRemoteDS {
  final ApiClient api;

  FeedRemoteDS(this.api);

  Future<void> upload({
    required String token,
    required File video,
    required File image,
    required String desc,
    required List<int> categories,
    Function(double)? progress,
  }) {
    return api.multipart(
      ApiConstants.myFeed,
      token: token,
      fields: {"desc": desc, "category": categories.join(",")},
      files: [
        http.MultipartFile.fromBytes(
          "video",
          video.readAsBytesSync(),
          filename: video.path.split("/").last,
        ),
        http.MultipartFile.fromBytes(
          "image",
          image.readAsBytesSync(),
          filename: image.path.split("/").last,
        ),
      ],
      onProgress: progress,
    );
  }

  /// FIRST PAGE (GET)
  Future<Map<String, dynamic>> myFeeds(String token) async {
    final res = await api.get(ApiConstants.myFeed, token: token);

    return Map<String, dynamic>.from(res);
  }

  /// NEXT PAGE USING URL
  Future<Map<String, dynamic>> myFeedsNext(String token, String nextUrl) async {
    final res = await api.getAbsolute(nextUrl, token: token);

    return Map<String, dynamic>.from(res);
  }
}
