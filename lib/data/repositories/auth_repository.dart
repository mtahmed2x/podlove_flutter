import 'package:podlove_flutter/data/models/signup_request.dart';
import 'package:podlove_flutter/data/models/signup_response.dart';
import 'package:podlove_flutter/data/services/api_service_bak.dart';

class AuthRepository {
  final ApiService apiService;
  AuthRepository(this.apiService);

  Future<SignUpResponse> signUp(String endpoint, SignUpRequest signUpData) async {
    final Map<String, dynamic> response = await apiService.post(endpoint, signUpData);
    return SignUpResponse.fromJson(response);
  }
}