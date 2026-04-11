import 'package:flutter/foundation.dart';
import 'package:monify_app_mobile/domain/entities/user_entity.dart';
import 'package:monify_app_mobile/domain/repositories/auth_repository_interface.dart';
import 'package:monify_app_mobile/domain/usecases/auth/login_usecase.dart';
import 'package:monify_app_mobile/domain/usecases/auth/logout_usecase.dart';
import 'package:monify_app_mobile/domain/usecases/auth/register_usecase.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUsecase _loginUsecase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;
  final AuthRepository _authRepository;

  AuthProvider({
    required LoginUsecase loginUseCase,
    required RegisterUseCase registerUseCase,
    required LogoutUseCase logoutUseCase,
    required AuthRepository authRepository,
  }) : _loginUsecase = loginUseCase,
       _registerUseCase = registerUseCase,
       _logoutUseCase = logoutUseCase,
       _authRepository = authRepository;

  UserEntity? _currentUser;
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _errorMessage;
  String? _refreshToken;

  UserEntity? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get refreshToken => _refreshToken;

  Future<void> login(String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      final user = await _loginUsecase.execute(email.trim(), password);
      _currentUser = user;
      _isAuthenticated = true;
    } catch (e) {
      _errorMessage = e.toString();
      _isAuthenticated = false;
      _currentUser = null;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> register({
    required String nombre,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (password != confirmPassword) {
      _errorMessage = 'Los passwords no coinciden';
      notifyListeners();
      return;
    }

    _setLoading(true);
    _clearError();

    try {
      final userData = {
        'nombre': nombre.trim(),
        'correo': email.trim(),
        'password': password,
        'rol': 'usuario',
      };

      await _registerUseCase.execute(userData);
      await login(email, password);
    } catch (e) {
      _errorMessage = e.toString();
      _setLoading(false);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _setLoading(true);
    _clearError();

    try {
      if (_refreshToken != null && _refreshToken!.isNotEmpty) {
        await _logoutUseCase.execute(_refreshToken!);
      }
    } catch (_) {
      // Limpiamos estado local aunque el logout remoto falle.
    } finally {
      await _clearAuthState();
      _setLoading(false);
    }
  }

  Future<void> loadUserFromStoredTokens() async {
    _setLoading(true);
    _clearError();

    try {
      final user = await _authRepository.getProfile();
      _currentUser = user;
      _isAuthenticated = true;
    } catch (e) {
      await _clearAuthState();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateProfile(Map<String, dynamic> profileData) async {
    _setLoading(true);
    _clearError();

    try {
      final updatedUser = await _authRepository.updateProfile(profileData);
      _currentUser = updatedUser;
    } catch (e) {
      _errorMessage = e.toString();
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

  Future<void> _clearAuthState() async {
    _currentUser = null;
    _isAuthenticated = false;
    _refreshToken = null;
  }

  String get userDisplayName => _currentUser?.nombre ?? 'Usuario';
  String get userEmail => _currentUser?.correo ?? '';
  int getUserLevel() => _currentUser?.nivel ?? 1;
  int getUserXP() => _currentUser?.xpActual ?? 0;
  double getUserBudget() => _currentUser?.presupuesto ?? 0.0;
  String getUserCurrency() => _currentUser?.moneda ?? 'PEN';
}
