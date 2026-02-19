import '../../core/network/api_client.dart';
import '../../core/constants/api_constants.dart';

class AuthRemoteDS {
  final ApiClient api;

  AuthRemoteDS(this.api);

  Future<Map<String, dynamic>> login(String phone) async {
    final res = await api.post(
      ApiConstants.otpVerified,
      body: {"country_code": "+91", "phone": phone},
    );

    return Map<String, dynamic>.from(res);
  }
}
