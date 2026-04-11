import 'package:flutter/foundation.dart';
import 'package:monify_app_mobile/domain/entities/transaction_entity.dart';
import 'package:monify_app_mobile/domain/usecases/transactions/create_transaction_usecase.dart';
import 'package:monify_app_mobile/domain/usecases/transactions/get_transactions_usecase.dart';

class HistoryViewModel extends ChangeNotifier {
  final GetTransactionsUsecase _getTransactionsUsecase;
  final CreateTransactionUsecase _createTransactionUsecase;

  HistoryViewModel(
    this._getTransactionsUsecase,
    this._createTransactionUsecase,
  );

  bool _isLoading = false;
  bool _isCreating = false;
  String? _errorMessage;
  List<TransactionEntity> _transactions = [];
  List<TransactionEntity> _filteredTransactions = [];
  String _searchQuery = '';
  String _selectedFilter = 'todos';

  bool get isLoading => _isLoading;
  bool get isCreating => _isCreating;
  String? get errorMessage => _errorMessage;
  List<TransactionEntity> get transactions => _transactions;
  List<TransactionEntity> get filteredTransactions => _filteredTransactions;
  String get searchQuery => _searchQuery;
  String get selectedFilter => _selectedFilter;

  Future<void> loadTransactions() async {
    _setLoading(true);
    _clearError();

    try {
      _transactions = await _getTransactionsUsecase.execute();
      _applyFilters();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> createTransaction({
    required int categoryId,
    required String tipo,
    required double monto,
    String? descripcion,
  }) async {
    _setCreating(true);
    _clearError();

    try {
      final transaction = TransactionEntity(
        id: 0,
        userId: 0,
        categoryId: categoryId,
        tipo: tipo,
        monto: monto,
        descripcion: descripcion,
        fecha: DateTime.now(),
      );

      final newTransaction = await _createTransactionUsecase.execute(transaction);
      _transactions.insert(0, newTransaction);
      _applyFilters();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setCreating(false);
    }
  }

  void searchTransactions(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
    notifyListeners();
  }

  void filterTransactions(String filter) {
    _selectedFilter = filter;
    _applyFilters();
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedFilter = 'todos';
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    _filteredTransactions = _transactions.where((transaction) {
      var matchesSearch = true;
      if (_searchQuery.isNotEmpty) {
        matchesSearch =
            transaction.descripcion?.toLowerCase().contains(_searchQuery) == true ||
            transaction.monto.toString().contains(_searchQuery);
      }

      var matchesFilter = true;
      if (_selectedFilter != 'todos') {
        matchesFilter = transaction.tipo == _selectedFilter;
      }

      return matchesSearch && matchesFilter;
    }).toList();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setCreating(bool creating) {
    _isCreating = creating;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }

  void clearError() {
    _clearError();
    notifyListeners();
  }

  double get totalIncome {
    return _filteredTransactions
        .where((t) => t.tipo == 'ingreso')
        .fold(0.0, (sum, t) => sum + t.monto);
  }

  double get totalExpense {
    return _filteredTransactions
        .where((t) => t.tipo == 'gasto')
        .fold(0.0, (sum, t) => sum + t.monto);
  }

  double get balance => totalIncome - totalExpense;
}
