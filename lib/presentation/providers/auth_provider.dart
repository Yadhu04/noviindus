import 'package:flutter/material.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../core/utils/token_storage.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUseCase loginUseCase;
  final TokenStorage storage;

  AuthProvider(this.loginUseCase, this.storage);

  String? token;
  bool loading = false;

  Future<void> login(String phone) async {
    loading = true;
    notifyListeners();

    final res = await loginUseCase(phone);
    token = res.token;

    await storage.save(token!);
    loading = false;
    notifyListeners();
  }

  Future<void> loadToken() async {
    token = await storage.read();
    notifyListeners();
  }

  Future<void> logout() async {
    token = null;
    await storage.clear();
    notifyListeners();
  }

  bool get isLogged => token != null;
}
