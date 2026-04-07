import 'package:flutter/foundation.dart';
import 'package:monify_app_mobile/domain/entities/transaction_entity.dart';

class HistoryViewmodel extends ChangeNotifier {
  final GetTransactionsUseCase  _getTransactionsUseCase;
  final CreateTransactionUseCase  _createTransactionUseCase;


  bool _isLoading = false;
  bool _isCreating = false;
  String? _errorMessage;
  List<TransactionEntity> _transactions = [];
  List<TransactionEntity> _filteredTransactions = [];
  String _searchQuery = '';
  String _selectedFilter = 'todos';

  HistoryViewmodel(
    this._getTransactionsUseCase,
    this._createTransactionUseCase,
  );

  bool get isLoading => _isLoading;
  bool get isCreating => _isCreating;
  String? get errorMessage => _errorMessage;
  List<TransactionEntity> get transactions => _transactions;
  List<TransactionEntity> get filteredTransactions => _filteredTransactions;
  String get searchQuery => _searchQuery;
  String get selectedFilter => _selectedFilter;

  Future<void> loadTransactions() async {
    _setLoading(false);
    _clearError();

    try {
      _transactions = await _getTransactionsUseCase.execute();
      _applyFilters();
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> createTransaction({
    required int categoryId,
    required String tipo,
    required double monto,
    String? descripcion
  }) async {
    _setCreating(true);
    _clearError();

    try {
      final transaction = TransactionEntity(
        id: 0, 
        userId: 1, 
        categoryId: categoryId, 
        tipo: tipo, 
        monto: monto, 
        fecha: DateTime.now(),
        );

        final newTransaction = await _createTransactionUseCase.execute(transaction);
        _transactions.insert(0, newTransaction);
        _applyFilters();
        notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  void searchTransactions(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
    notifyListeners();
  }


  void filterTransactions (String filter) {
    _selectedFilter = filter;
    _applyFilters();
    notifyListeners();
  }


  void _applyFilters() {
    _filteredTransactions = _transactions.where((transaction) {
      //Filtro por busqueda
      bool matchesSearch = true;
      if (_searchQuery.isNotEmpty) {
        matchesSearch = transaction.descripcion?.toLowerCase().contains(_searchQuery) == true ||
                                    transaction.monto.toString().contains(_searchQuery);
      }

      bool matchesFilter = true;
      if(_selectedFilter != 'todos') {
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
    notifyListeners();
  }

  void clearError() {
    _clearError();
  }


  double get totalIncome {
    return _filteredTransactions
    .where((t) => t.tipo == 'ingreso')
    .fold(0.0, (sum,t) => sum +t.monto);
  }


  double get totalExpense {
    return _filteredTransactions
    .where((t) => t.tipo == 'gasto')
    .fold(0.0, (sum,t) => sum +t.monto);
  }


  double get balance {
    return totalIncome - totalExpense;
  }
}