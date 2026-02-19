import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';
import '../error/exceptions.dart';

class ApiClient {
  Future<dynamic> get(
    String endpoint, {
    String? token,
    Map<String, String>? query,
  }) async {
    try {
      final uri = Uri.parse(
        ApiConstants.baseUrl + endpoint,
      ).replace(queryParameters: query);

      final response = await http
          .get(uri, headers: _headers(token))
          .timeout(const Duration(seconds: 30));

      return _handleResponse(response);
    } on TimeoutException {
      throw NetworkException("Request timeout");
    } catch (e) {
      throw NetworkException(e.toString());
    }
  }

  Future<dynamic> post(
    String endpoint, {
    String? token,
    Map<String, String>? body,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse(ApiConstants.baseUrl + endpoint),
            headers: _headers(token, isJson: false),
            body: body,
          )
          .timeout(const Duration(seconds: 30));

      return _handleResponse(response);
    } on TimeoutException {
      throw NetworkException("Request timeout");
    } catch (e) {
      throw NetworkException(e.toString());
    }
  }

  Future<dynamic> multipart(
    String endpoint, {
    required Map<String, String> fields,
    required List<http.MultipartFile> files,
    String? token,
    Function(double progress)? onProgress,
  }) async {
    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse(ApiConstants.baseUrl + endpoint),
      );

      request.headers.addAll(_headers(token, isJson: false));
      request.fields.addAll(fields);
      request.files.addAll(files);

      final streamed = await request.send();

      final total = streamed.contentLength ?? 1;
      int bytes = 0;

      final completer = Completer<http.Response>();

      streamed.stream.listen(
        (chunk) {
          bytes += chunk.length;
          if (onProgress != null) {
            onProgress(bytes / total);
          }
        },
        onDone: () async {
          final response = await http.Response.fromStream(streamed);
          completer.complete(response);
        },
        onError: (e) {
          completer.completeError(e);
        },
      );

      final response = await completer.future;
      return _handleResponse(response);
    } on TimeoutException {
      throw NetworkException("Upload timeout");
    } catch (e) {
      throw NetworkException(e.toString());
    }
  }

  Map<String, String> _headers(String? token, {bool isJson = true}) {
    return {
      if (isJson) "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  dynamic _handleResponse(http.Response response) {
    final data = response.body.isNotEmpty ? jsonDecode(response.body) : null;

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    } else {
      throw ServerException(
        data?["message"] ?? "Server error (${response.statusCode})",
      );
    }
  }

  Future<dynamic> getAbsolute(String url, {String? token}) async {
    final response = await http.get(Uri.parse(url), headers: _headers(token));

    return _handleResponse(response);
  }
}
