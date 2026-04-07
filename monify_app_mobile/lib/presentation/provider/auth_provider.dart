import 'package:flutter/foundation.dart';
import 'package:monify_app_mobile/data/services/api_service.dart';
import 'package:monify_app_mobile/domain/entities/user_entity.dart';
import 'package:monify_app_mobile/domain/usecases/auth/login_usecase.dart';
import 'package:monify_app_mobile/domain/usecases/auth/logout_usecase.dart';
import 'package:monify_app_mobile/domain/usecases/auth/register_usecase.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUsecase _loginUsecase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;
  final ApiService _apiService;


  AuthProvider({
    required LoginUsecase loginUseCase,
    required RegisterUseCase registerUseCase,
    required LogoutUseCase logoutUseCase,
    required ApiService apiService,
  }) : _loginUsecase = loginUseCase,
       _registerUseCase = registerUseCase,
       _logoutUseCase = logoutUseCase,
       _apiService = apiService;

  UserEntity? _currentUser;
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _errorMessage;
  String? _accessToken;
  String? _refreshToken;



  UserEntity? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;      
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;



  Future<void> login(String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      final user = await _loginUsecase.execute(email, password);
      _accessToken = await _getAccessTokenFromLogin(email, password);
      _refreshToken = await _getRefreshTokenFromLogin(email, password);


      _apiService.setAuthToken(_accessToken!);

      _currentUser = user;
      _isAuthenticated = true;

      await _saveTokensLocally();

      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isAuthenticated = false;
      notifyListeners();
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

      final user = await _registerUseCase.execute(userData);

      await login(email, password);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    } 
  }


  Future<void> logout() async {
    _setLoading(true);


    try {
      if (_refreshToken != null) {
        await _logoutUseCase.execute(_refreshToken!);
      }

      await _clearAuthState();

      notifyListeners();
    } catch (e) {
      await _clearAuthState();
      notifyListeners();
    }
  }


  Future<void> loadUserFromStoredTokens() async {
    try {
      final storedToken = await _getStoredAccessToken();
      final storedRefreshToken = await _getStoredRefreshToken();

      if(storedToken != null && storedRefreshToken != null) {
        _accessToken = storedToken;
        _refreshToken = storedRefreshToken;
        _apiService.setAuthToken(_accessToken!);

        _isAuthenticated = true;

        notifyListeners();
      }
    }catch (e) {
      await _clearAuthState();
      notifyListeners();
    }
  }


  Future<void> updateProfile(Map<String, dynamic> profifileData) async {
    _setLoading(true);
    _clearError();

    try {
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }



  Future<bool> refreshToken() async {
    try {
      if(_refreshToken == null) return false;

      await _saveTokensLocally();
      _apiService.setAuthToken(_accessToken!);

      return true;
    } catch(e) {
      await logout();
      return false;
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



  Future<void> _clearAuthState() async {
    _currentUser = null;
    _isAuthenticated = false;
    _accessToken = null;
    _refreshToken = null;
    _apiService.clearAuthToken();
    await _clearStoredTokens();
  }



  Future<void> _saveTokensLocally() async {
    //
  }


  Future<void> _clearStoredTokens() async {
    //
  }


  Future<String?> _getStoredAccessToken() async {
    //
    return null;
  }


  Future<String?> _getStoredRefreshToken() async{
    //
    return null;
  }


  Future<String> _getAccessTokenFromLogin(String email, String password) async {
    return 'temp_access_token';
  }


  Future<String> _getRefreshTokenFromLogin(String email, String password) async {
    return 'temp_refresh_token';
  }



  String get userDisplayName => _currentUser?.nombre ?? 'Usuario';
  String get userEmail => _currentUser?.correo ?? '';
  int getUserLevel() => _currentUser?.nivel ?? 1;
  int getUserXP() => _currentUser?.xpActual ?? 0;
  double getUserBudget() => _currentUser?.presupuesto ?? 0.0;
  String getUserCurrency() => _currentUser?.moneda ?? 'PEN';

}