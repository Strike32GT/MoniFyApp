import 'package:monify_app_mobile/data/models/user_model.dart';
import 'package:monify_app_mobile/data/services/api_service.dart';
import 'package:monify_app_mobile/data/services/auth_service.dart';
import 'package:monify_app_mobile/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String correo, String password);
  Future<UserEntity> register(Map<String, dynamic> userData);
  Future<UserEntity> getProfile();
  Future<UserEntity> updateProfile(Map<String, dynamic> userData);
  Future<void> logout(String refreshToken);
}


class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;
  final ApiService _apiService;

  AuthRepositoryImpl(this._authService, this._apiService);


  @override 
  Future<UserEntity> login(String correo, String password) async {
    final response = await _authService.login(correo, password);

    final accessToken = response['tokens']['access'];
    final refreshToken = response['tokens']['refresh'];

    _apiService.setAuthToken(accessToken);
    await _saveTokensLocally(accessToken, refreshToken);


    _apiService.setAuthToken(accessToken);
    final userModel = UserModel.fromJson(response['user']);
    return userModel.toEntity();
  }


  @override
  Future<UserEntity> register(Map<String, dynamic> userData) async {
    final response = await _authService.register(userData);
    final userModel = UserModel.fromJson(response['user']);
    return userModel.toEntity();
  }
  
  @override
  Future<UserEntity> getProfile() async {
    final response = await _authService.getProfile();
    final userModel = UserModel.fromJson(response);
    return userModel.toEntity();
  }
  
  @override
  Future<UserEntity> updateProfile(Map<String, dynamic> userData) async {
    final response = await _authService.updateProfile(userData);
    final userModel = UserModel.fromJson(response);
    return userModel.toEntity();
  }
  
  @override
  Future<void> logout(String refreshToken) async {
    await _authService.logout(refreshToken);
    _apiService.clearAuthToken();
    await _clearTokensLocally();
  }


  Future<void> _saveTokensLocally(String accessToken, String refreshToken) async {
    //
  }


  Future<void> _clearTokensLocally() async {
    //
  }
}