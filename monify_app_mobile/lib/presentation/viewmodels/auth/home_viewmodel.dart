import 'package:flutter/foundation.dart';
import 'package:monify_app_mobile/domain/entities/transaction_entity.dart';

class HomeViewmodel extends ChangeNotifier{
  final GetTransactionsUseCase _getTransactionsUseCase;
  final GetTodaySummaryUseCase  _getTodaySummaryUseCase;


  bool _isLoading = false;
  String? _errorMessage;
  List<TransactionEntity> _recentTransactions = [];
  Map<String, dynamic> _todaySummary = {};
  double _balance = 0.0;

  HomeViewmodel(
    this._getTransactionsUseCase,
    this._getTodaySummaryUseCase,
  );


  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<TransactionEntity> get recentTransactions => _recentTransactions;
  Map<String, dynamic> get todaySummary => _todaySummary;
  double get balance => _balance;

  Future<void> loadHomeData() async {
    _setLoading(true);
    _clearError();


    try {
      _recentTransactions = await _getTransactionsUseCase.execute();
      _todaySummary = await _getTodaySummaryUseCase.execute();
      _calculateBalance();
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> refreshData() async {
    await loadHomeData();
  }

  void _calculateBalance() {
    _balance = _todaySummary['balance'] ?? 0.0;
  }

  void _setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() {
    _clearError();
  }


  List<TransactionEntity> get lastFiveTransactions {
    if(_recentTransactions.length <= 5) {
      return _recentTransactions;
    }
    return _recentTransactions.take(5).toList();
  }
}