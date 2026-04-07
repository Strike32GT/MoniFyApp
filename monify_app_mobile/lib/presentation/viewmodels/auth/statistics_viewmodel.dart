import 'package:flutter/foundation.dart';
import 'package:monify_app_mobile/domain/entities/transaction_entity.dart';

class StatisticsViewmodel extends ChangeNotifier{
  final GetWeeklyStatsUseCase _getWeeklyStatsUseCase;

  bool _isLoading=false;
  String? _errorMessage;
  Map<String, dynamic> _weeklyStats = {};
  List<Map<String,dynamic>> _chartData = [];
  String _selectedPeriod = 'semana';

  StatisticsViewmodel(this._getWeeklyStatsUseCase);

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic> get weeklyStats => _weeklyStats;
  List<Map<String, dynamic>> get chartData => _chartData;
  String get selectedPeriod => _selectedPeriod;


  Future<void> loadStadistics({String period = 'semana'}) async {
    _selectedPeriod = period;
    _setLoading(true);
    _clearError();


    try {
      _weeklyStats = await  _getWeeklyStatsUseCase.execute(period: period);
      _prepareChartData();
      notifyListeners();
    } catch(e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  void _prepareChartData() {
    final transactions = _weeklyStats['transactions'] as List <TransactionEntity> ?? [];

    final Map<String, double> dailyData = {};

    for (final transaction in transactions) {
      final day = transaction.fecha.day.toString();
      final amount = transaction.monto;

      if (transaction.tipo == 'gasto') {
        dailyData[day] = (dailyData[day] ?? 0.0) + amount;
      }
    }

    _chartData = dailyData.entries.map((entry) {
      return {
        'day': entry.key,
        'amount':entry.value,
      };
    }).toList();
  }

  void changePeriod(String period) {
    loadStadistics(period: period);
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



  double get totalExpenses {
    return _weeklyStats['total_expenses'] ?? 0.0;
  }
 
  double get averageDailyExpense {
    return _weeklyStats['average_daily'] ?? 0.0;
  }
 
  double get highestExpense {
    return _weeklyStats['highest_expense'] ?? 0.0;
  }
 
  String get mostExpensiveCategory {
    return _weeklyStats['most_expensive_category'] ?? 'N/A';
  }


}