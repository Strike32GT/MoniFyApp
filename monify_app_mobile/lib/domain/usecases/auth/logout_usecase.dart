import 'package:monify_app_mobile/data/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository _repository;
  LogoutUseCase(this._repository);

  Future<void> execute(String refreshToken) async {
    if (refreshToken.isEmpty) {
      throw ValidationException('Refresh token requerido');
    }

    await _repository.logout(refreshToken);
  }
}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);

  @override
  String toString() => message;
}
