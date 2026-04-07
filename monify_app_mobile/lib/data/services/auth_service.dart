import 'package:monify_app_mobile/data/services/api_service.dart';

class AuthService {
  final ApiService _apiService;

  AuthService(this._apiService);

  Future<Map<String, dynamic>> login(String correo, String password) async {
    return await _apiService.post('/users/login', {
      'correo':correo,
      'password':password,
    });
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> userData) async {
    return await _apiService.post('/users/register/',userData);
  }

  Future<Map<String, dynamic>> getProfile() async {
    return await _apiService.get('/users/profile/');
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> userData) async {
    return await _apiService.put('/users/profile/',userData);
  }

  Future<Map<String, dynamic>> logout(String refreshToken) async {
    return await _apiService.put('/users/profile/', {
      'refresh': refreshToken,
    });
  }
}