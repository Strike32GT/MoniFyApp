import 'package:flutter/foundation.dart';
import 'package:monify_app_mobile/domain/entities/transaction_entity.dart';
import 'package:monify_app_mobile/domain/repositories/transaction_repository_interface.dart';
import 'package:monify_app_mobile/domain/usecases/transactions/get_transactions_usecase.dart';

class HomeViewModel extends ChangeNotifier {
  final GetTransactionsUsecase _getTransactionsUsecase;
  final TransactionRepository _transactionRepository;

  HomeViewModel(this._getTransactionsUsecase, this._transactionRepository);

  bool _isLoading = false;
  String? _errorMessage;
  List<TransactionEntity> _recentTransactions = [];
  Map<String, dynamic> _todaySummary = {};
  double _balance = 0.0;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<TransactionEntity> get recentTransactions => _recentTransactions;
  Map<String, dynamic> get todaySummary => _todaySummary;
  double get balance => _balance;

  Future<void> loadHomeData() async {
    _setLoading(true);
    _clearError();

    try {
      _recentTransactions = await _getTransactionsUsecase.execute(limit: 5);
      _todaySummary = await _transactionRepository.getTodaySummary();
      _calculateBalance();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> refreshData() async {
    await loadHomeData();
  }

  void _calculateBalance() {
    final ingresos = (_todaySummary['ingresos'] ?? 0).toDouble();
    final gastos = (_todaySummary['gastos'] ?? 0).toDouble();
    _balance = ingresos - gastos;
  }

  void _setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }

  void clearError() {
    _clearError();
    notifyListeners();
  }

  List<TransactionEntity> get lastFiveTransactions {
    if (_recentTransactions.length <= 5) {
      return _recentTransactions;
    }

    return _recentTransactions.take(5).toList();
  }
}
