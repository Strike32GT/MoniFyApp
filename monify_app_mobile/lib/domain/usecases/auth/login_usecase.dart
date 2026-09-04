import 'package:monify_app_mobile/data/repositories/auth_repository.dart';
import 'package:monify_app_mobile/domain/entities/user_entity.dart';

class LoginUsecase {
  final AuthRepository _repository;

  LoginUsecase(this._repository);

  Future<UserEntity> execute(String email, String password) async {
    if (!_isValidEmail(email)) {
      throw ValidationException('Email invalido');
    }

    if (password.length < 6) {
      throw ValidationException(
        'La contraseña debe tener al menos 6 caracteres',
      );
    }

    final user = await _repository.login(email, password);

    return user;
  }

  bool _isValidEmail(String email) {
    return email.contains('@') && email.contains('.') && email.length > 5;
  }
}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);

  @override
  String toString() => message;
}
