import '../../domain/entities/auth.dart';
import '../datasource/auth_remote_ds.dart';
import '../models/auth_model.dart';

class AuthRepositoryImpl {
  final AuthRemoteDS ds;

  AuthRepositoryImpl(this.ds);

  Future<Auth> login(String phone) async {
    final res = await ds.login(phone);
    return AuthModel.fromJson(res);
  }
}
