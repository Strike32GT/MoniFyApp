import 'package:monify_app_mobile/data/models/achievement_model.dart';
import 'package:monify_app_mobile/data/models/category_model.dart';
import 'package:monify_app_mobile/data/models/streak_model.dart';
import 'package:monify_app_mobile/data/models/transaction_model.dart';
import 'package:monify_app_mobile/data/models/user_model.dart';

/// Estado temporal de la aplicación para la etapa de solo frontend.
/// No persiste datos ni realiza comunicaciones de red.
class LocalAppStore {
  LocalAppStore._();

  static final LocalAppStore instance = LocalAppStore._();

  UserModel? _currentUser;
  final List<_LocalAccount> _accounts = [];
  final List<TransactionModel> _transactions = [];
  int _nextUserId = 1;
  int _nextTransactionId = 1;

  final List<CategoryModel> categories = [
    CategoryModel(
      id: 1,
      nombre: 'Alimentación',
      icono: 'restaurant',
      color: '#EF5350',
    ),
    CategoryModel(
      id: 2,
      nombre: 'Transporte',
      icono: 'directions_car',
      color: '#42A5F5',
    ),
    CategoryModel(
      id: 3,
      nombre: 'Entretenimiento',
      icono: 'movie',
      color: '#AB47BC',
    ),
    CategoryModel(
      id: 4,
      nombre: 'Servicios',
      icono: 'receipt_long',
      color: '#FFA726',
    ),
  ];

  Future<UserModel> register({
    required String nombre,
    required String correo,
    required String password,
  }) async {
    if (_accounts.any((account) => account.user.correo == correo)) {
      throw Exception('Ya existe una cuenta con este correo');
    }
    final user = _newUser(nombre: nombre, correo: correo);
    _accounts.add(_LocalAccount(user, password));
    return user;
  }

  Future<UserModel> login(String correo, String password) async {
    final account = _accounts
        .where((item) => item.user.correo == correo)
        .firstOrNull;
    if (account != null && account.password != password) {
      throw Exception('Credenciales incorrectas');
    }
    // El prototipo permite entrar con cualquier correo y contraseña no vacíos.
    _currentUser =
        account?.user ??
        _newUser(nombre: _nameFromEmail(correo), correo: correo);
    return _currentUser!;
  }

  Future<UserModel> getProfile() async => _currentUser ??= _newUser(
    nombre: 'Usuario',
    correo: 'usuario@monify.local',
  );

  Future<UserModel> updateProfile(Map<String, dynamic> data) async {
    final previous = await getProfile();
    _currentUser = UserModel(
      id: previous.id,
      nombre: data['nombre']?.toString() ?? previous.nombre,
      correo: data['correo']?.toString() ?? previous.correo,
      rol: previous.rol,
      avatar: previous.avatar,
      presupuesto: (data['presupuesto'] ?? previous.presupuesto).toDouble(),
      moneda: data['moneda']?.toString() ?? previous.moneda,
      nivel: previous.nivel,
      xpActual: previous.xpActual,
      mejorRacha: previous.mejorRacha,
      fechaCreacion: previous.fechaCreacion,
    );
    return _currentUser!;
  }

  Future<void> logout() async => _currentUser = null;

  Future<List<TransactionModel>> getTransactions() async =>
      List.unmodifiable(_transactions);

  Future<TransactionModel> createTransaction(Map<String, dynamic> data) async {
    final categoryId = (data['category'] as num?)?.toInt() ?? 1;
    final transaction = TransactionModel(
      id: _nextTransactionId++,
      user: (await getProfile()).id,
      category: categoryId,
      tipo: data['tipo']?.toString() ?? 'gasto',
      monto: (data['monto'] as num?)?.toDouble() ?? 0,
      descripcion: data['descripcion']?.toString(),
      fecha: DateTime.now(),
      categoryDetalle: categories
          .where((item) => item.id == categoryId)
          .firstOrNull,
    );
    _transactions.insert(0, transaction);
    return transaction;
  }

  Future<Map<String, dynamic>> getTodaySummary() async {
    final today = DateTime.now();
    final total = _transactions
        .where(
          (item) =>
              item.fecha.year == today.year &&
              item.fecha.month == today.month &&
              item.fecha.day == today.day,
        )
        .fold<double>(0, (sum, item) => sum + item.monto);
    return {
      'total_gastos': total,
      'presupuesto_diario': 50.0,
      'disponible': 50.0 - total,
    };
  }

  Future<Map<String, dynamic>> getWeeklyStats() async {
    final total = _transactions.fold<double>(
      0,
      (sum, item) => sum + item.monto,
    );
    return {
      'total_semana': total,
      'promedio_diario': total / 7,
      'transacciones': _transactions.length,
    };
  }

  Future<List<AchievementModel>> getAchievements() async => [
    AchievementModel(
      id: 1,
      nombre: 'Primer gasto',
      descripcion: 'Registra tu primer gasto',
      icono: 'star',
    ),
    AchievementModel(
      id: 2,
      nombre: 'Semana organizada',
      descripcion: 'Mantén tus gastos al día',
      icono: 'calendar_today',
    ),
  ];

  Future<StreakModel> getStreak() async {
    final user = await getProfile();
    return StreakModel(
      id: 1,
      user: user.id,
      rachaActual: 0,
      mejorRacha: user.mejorRacha,
      ultimaFecha: null,
    );
  }

  UserModel _newUser({required String nombre, required String correo}) =>
      UserModel(
        id: _nextUserId++,
        nombre: nombre,
        correo: correo,
        rol: 'usuario',
        presupuesto: 50,
        moneda: 'PEN',
        nivel: 1,
        xpActual: 0,
        mejorRacha: 0,
        fechaCreacion: DateTime.now(),
      );

  String _nameFromEmail(String correo) =>
      correo.split('@').first.isEmpty ? 'Usuario' : correo.split('@').first;
}

class _LocalAccount {
  final UserModel user;
  final String password;
  const _LocalAccount(this.user, this.password);
}
