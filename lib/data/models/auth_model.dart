import '../../domain/entities/auth.dart';

class AuthModel extends Auth {
  AuthModel(super.token);

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    final token = json["token"]?["access"];

    if (token == null) {
      throw Exception("Access token missing");
    }

    return AuthModel(token.toString());
  }
}
