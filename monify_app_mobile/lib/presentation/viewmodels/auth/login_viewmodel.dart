import 'package:flutter/foundation.dart';
import 'package:monify_app_mobile/domain/entities/user_entity.dart';
import 'package:monify_app_mobile/domain/usecases/auth/login_usecase.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginUsecase _loginUsecase;

  LoginViewModel(this._loginUsecase);

  bool _isLoading = false;
  String? _errorMessage;
  UserEntity? _currentUser;
  bool _loginSuccess = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  UserEntity? get currentUser => _currentUser;
  bool get loginSuccess => _loginSuccess;

  Future<void> login(String email, String password) async {
    if (email.trim().isEmpty || password.isEmpty) {
      _errorMessage = 'Completa los campos';
      notifyListeners();
      return;
    }

    _setLoading(true);
    _clearError();

    try {
      _currentUser = await _loginUsecase.execute(email.trim(), password);
      _loginSuccess = true;
    } catch (e) {
      _errorMessage = e.toString();
      _loginSuccess = false;
      _currentUser = null;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }

  void clearError() {
    _clearError();
    notifyListeners();
  }

  void reset() {
    _isLoading = false;
    _errorMessage = null;
    _currentUser = null;
    _loginSuccess = false;
    notifyListeners();
  }
}
