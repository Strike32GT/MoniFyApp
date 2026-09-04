import 'package:monify_app_mobile/data/models/user_model.dart';
import 'package:monify_app_mobile/data/services/local_app_store.dart';

class AuthService {
  Future<Map<String, dynamic>> login(String correo, String password) async {
    final user = await LocalAppStore.instance.login(correo, password);
    return {'user': _userJson(user)};
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> userData) async {
    final user = await LocalAppStore.instance.register(
      nombre: userData['nombre'].toString(),
      correo: userData['correo'].toString(),
      password: userData['password'].toString(),
    );
    return {'user': _userJson(user)};
  }

  Future<Map<String, dynamic>> getProfile() async {
    return _userJson(await LocalAppStore.instance.getProfile());
  }

  Future<Map<String, dynamic>> updateProfile(
    Map<String, dynamic> userData,
  ) async {
    return _userJson(await LocalAppStore.instance.updateProfile(userData));
  }

  Future<Map<String, dynamic>> logout(String refreshToken) async {
    await LocalAppStore.instance.logout();
    return {};
  }

  Map<String, dynamic> _userJson(UserModel user) => {
    'id': user.id,
    'nombre': user.nombre,
    'correo': user.correo,
    'rol': user.rol,
    'avatar': user.avatar,
    'presupuesto': user.presupuesto,
    'moneda': user.moneda,
    'nivel': user.nivel,
    'xpActual': user.xpActual,
    'mejorRacha': user.mejorRacha,
    'fechaCreacion': user.fechaCreacion.toIso8601String(),
  };
}
