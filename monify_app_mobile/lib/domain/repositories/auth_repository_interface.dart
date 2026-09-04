import 'package:monify_app_mobile/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> register(Map<String, dynamic> userData);
  Future<UserEntity> getProfile();
  Future<UserEntity> updateProfile(Map<String, dynamic> userData);
  Future<void> logout(String refreshToken);
}
