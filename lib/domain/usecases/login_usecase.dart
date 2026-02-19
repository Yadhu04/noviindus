import '../../data/repositories/auth_repository_impl.dart';
import '../entities/auth.dart';

class LoginUseCase {
  final AuthRepositoryImpl repo;

  LoginUseCase(this.repo);

  Future<Auth> call(String phone) {
    return repo.login(phone);
  }
}
