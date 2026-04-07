import 'package:flutter/foundation.dart';
import 'package:monify_app_mobile/domain/entities/user_entity.dart';
import 'package:monify_app_mobile/domain/usecases/auth/register_usecase.dart';

class RegisterViewmodel extends ChangeNotifier{
  final RegisterUseCase _registerUseCase;

  bool _isLoading = false;
  String? _errorMessage;
  UserEntity? _currentUser;
  bool _registerSuccess  = false;

  RegisterViewmodel(this._registerUseCase);


  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  UserEntity? get currentUser => _currentUser;
  bool get registerSucess => _registerSuccess ;


  Future<void> register({
    required String nombre,
    required String email,
    required String password,
    required String confirmPassword
  }) async {
    if (nombre.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _errorMessage = "Completa los campos";
      notifyListeners();
      return;
    }
    
    if (password != confirmPassword) {
      _errorMessage = "Password no coinciden";
      notifyListeners();
      return;
    }

    if (password.length < 6) {
      _errorMessage = "El password debe tener 6 caracteres";
      notifyListeners();
      return;
    }

    _setLoading(true);
    _clearError();


    try {
      final userData = {
        'nombre': nombre.trim(),
        'correo': email.trim(),
        'password': password.trim(),
        'rol' : 'usuario',
      };

      _currentUser = await _registerUseCase.execute(userData);
      _registerSuccess  = true;

      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _registerSuccess = false;
      notifyListeners();
    }
  }


  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }


  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() {
    _clearError();
  }

  void reset() {
    _isLoading = false;
    _errorMessage = null;
    _currentUser = null;
    _registerSuccess = false;
    notifyListeners();
  }
}