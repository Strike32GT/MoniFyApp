import 'package:flutter/material.dart';
import 'package:monify_app_mobile/domain/entities/user_entity.dart';

class LoginViewmodel extends ChangeNotifier {
  final LoginUseCase = _loginUseCase;

  bool _isLoading = false;

  String? _errorMessage;
  UserEntity? _currentUser;
  bool _loginSucess = false;

  LoginViewmodel(this._loginSucess);


  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      _errorMessage = "Completa los campos";
      notifyListeners();
      return;
    }

    _setLoading(true);
    _cleanError();

    try {
      _currentUser = await _loginSucess.execute(email,password);
      _loginSucess = true;

      notifyListeners();
    }catch (e) {
      _errorMessage = e.toString();
      _loginSucess = false;
      notifyListeners();
    }
  }


  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _cleanError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() {
    _cleanError();
  }


  void reset() {
    _isLoading = false;
    _errorMessage = null;
    _currentUser = null;
    _loginSucess = false;
    notifyListeners();
  }
}