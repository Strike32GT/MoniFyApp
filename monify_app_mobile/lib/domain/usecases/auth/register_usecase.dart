import 'package:monify_app_mobile/data/repositories/auth_repository.dart';
import 'package:monify_app_mobile/domain/entities/user_entity.dart';

class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  Future<UserEntity> execute(Map<String, dynamic> userData) async {
    final nombre = userData['nombre'] as String?;
    final email = userData['correo'] as String?;
    final password = userData['password'] as String?;
    if(nombre == null || nombre.trim().isEmpty) {
      throw ValidationException('El nombre requerido');
    }

    if (email == null || !_isValidEmail(email)) {
      throw ValidationException('Email invalido');
    }

    if (password == null || password.length < 6) {
      throw ValidationException('El password debe tener 6 caracteres como minimo');
    }

    final user = await _repository.register(userData);
    return user;
  }

  bool _isValidEmail(String email) {
    return email.contains('@') && email.contains('.') && email.length > 5;
  }
}


class ValidationException  implements Exception {
  final String message;
  ValidationException(this.message);

  @override
  String toString() => message;
}