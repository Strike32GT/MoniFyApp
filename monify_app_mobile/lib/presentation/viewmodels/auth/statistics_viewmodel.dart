import 'package:flutter/foundation.dart';
import 'package:monify_app_mobile/domain/repositories/transaction_repository_interface.dart';

class StatisticsViewModel extends ChangeNotifier {
  final TransactionRepository _transactionRepository;

  StatisticsViewModel(this._transactionRepository);

  bool _isLoading = false;
  String? _errorMessage;
  Map<String, dynamic> _weeklyStats = {};
  List<Map<String, dynamic>> _chartData = [];
  String _selectedPeriod = 'semana';

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic> get weeklyStats => _weeklyStats;
  List<Map<String, dynamic>> get chartData => _chartData;
  String get selectedPeriod => _selectedPeriod;

  Future<void> loadStatistics({String period = 'semana'}) async {
    _selectedPeriod = period;
    _setLoading(true);
    _clearError();

    try {
      _weeklyStats = await _transactionRepository.getWeeklyStats();
      _prepareChartData();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  void _prepareChartData() {
    final rawChartData = _weeklyStats['gasto_por_dia'];

    if (rawChartData is! List) {
      _chartData = [];
      return;
    }

    _chartData = rawChartData.map<Map<String, dynamic>>((item) {
      final data = Map<String, dynamic>.from(item as Map);
      return {
        'day': data['dia']?.toString() ?? '',
        'amount': (data['total'] ?? 0).toDouble(),
      };
    }).toList();
  }

  Future<void> changePeriod(String period) async {
    await loadStatistics(period: period);
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

  double get totalExpenses => (_weeklyStats['gastos_total'] ?? 0).toDouble();

  double get averageDailyExpense =>
      (_weeklyStats['promedio_diario'] ?? 0).toDouble();

  double get highestExpense {
    final highestDay = _weeklyStats['dia_mayor_gasto'];
    if (highestDay is Map<String, dynamic>) {
      return (highestDay['total'] ?? 0).toDouble();
    }
    return 0.0;
  }

  String get highestExpenseDay {
    final highestDay = _weeklyStats['dia_mayor_gasto'];
    if (highestDay is Map<String, dynamic>) {
      return highestDay['dia']?.toString() ?? 'N/A';
    }
    return 'N/A';
  }
}
