import 'package:podlove_flutter/data/models/sign_up_response.dart';
import 'package:podlove_flutter/data/services/api_service.dart';

class SignUpRepository {
  final ApiService apiService;
  SignUpRepository(this.apiService);

  Future<SignUpResponse> signUp(String endpoint, Map<String, dynamic> data) async {
    final Map<String, dynamic> response = await apiService.post(endpoint, data);
    return SignUpResponse.fromJson(response);
  }
}