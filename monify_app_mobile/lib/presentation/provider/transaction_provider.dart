import 'package:flutter/foundation.dart';
import 'package:monify_app_mobile/data/models/category_model.dart';
import 'package:monify_app_mobile/domain/entities/transaction_entity.dart';
import 'package:monify_app_mobile/domain/repositories/transaction_repository_interface.dart';
import 'package:monify_app_mobile/domain/usecases/transactions/create_transaction_usecase.dart';
import 'package:monify_app_mobile/domain/usecases/transactions/get_transactions_usecase.dart';

class TransactionProvider extends ChangeNotifier {
  final GetTransactionsUsecase _getTransactionsUseCase;
  final CreateTransactionUsecase _createTransactionUseCase;
  final TransactionRepository _transactionRepository;

  TransactionProvider({
    required GetTransactionsUsecase getTransactionsUseCase,
    required CreateTransactionUsecase createTransactionUseCase,
    required TransactionRepository transactionRepository,
  }) : _getTransactionsUseCase = getTransactionsUseCase,
       _createTransactionUseCase = createTransactionUseCase,
       _transactionRepository = transactionRepository;

  List<TransactionEntity> _transactions = [];
  List<TransactionEntity> _filteredTransactions = [];
  List<CategoryModel> _categories = [];
  bool _isLoading = false;
  bool _isCreating = false;
  String? _errorMessage;
  String _searchQuery = '';
  String _selectedFilter = 'todos';
  String _selectedCategoryFilter = 'todas';

  Map<String, dynamic> _todaySummary = {};
  Map<String, dynamic> _weeklyStats = {};

  List<TransactionEntity> get transactions => _filteredTransactions;
  List<CategoryModel> get categories => _categories;
  bool get isLoading => _isLoading;
  bool get isCreating => _isCreating;
  String? get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  String get selectedFilter => _selectedFilter;
  String get selectedCategoryFilter => _selectedCategoryFilter;
  Map<String, dynamic> get todaySummary => _todaySummary;
  Map<String, dynamic> get weeklyStats => _weeklyStats;

  Future<void> loadTransactions() async {
    _setLoading(true);
    _clearError();

    try {
      _transactions = await _getTransactionsUseCase.execute();
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

      final newTransaction = await _createTransactionUseCase.execute(transaction);
      _transactions.insert(0, newTransaction);
      _applyFilters();

      await Future.wait([
        loadTodaySummary(),
        loadWeeklyStats(),
      ]);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setCreating(false);
    }
  }

  Future<void> loadCategories() async {
    _clearError();

    try {
      _categories = await _transactionRepository.getCategories();
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> loadTodaySummary() async {
    _clearError();

    try {
      _todaySummary = await _transactionRepository.getTodaySummary();
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> loadWeeklyStats() async {
    _clearError();

    try {
      _weeklyStats = await _transactionRepository.getWeeklyStats();
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

  void filterByType(String filter) {
    _selectedFilter = filter;
    _applyFilters();
    notifyListeners();
  }

  void filterByCategory(String category) {
    _selectedCategoryFilter = category;
    _applyFilters();
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedFilter = 'todos';
    _selectedCategoryFilter = 'todas';
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

      var matchesType = true;
      if (_selectedFilter != 'todos') {
        matchesType = transaction.tipo == _selectedFilter;
      }

      var matchesCategory = true;
      if (_selectedCategoryFilter != 'todas') {
        matchesCategory =
            transaction.categoryId.toString() == _selectedCategoryFilter;
      }

      return matchesSearch && matchesType && matchesCategory;
    }).toList();
  }

  Future<void> refreshAll() async {
    await Future.wait([
      loadTransactions(),
      loadCategories(),
      loadTodaySummary(),
      loadWeeklyStats(),
    ]);
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

  int get transactionCount => _filteredTransactions.length;

  List<TransactionEntity> get recentTransactions {
    return _filteredTransactions.take(5).toList();
  }

  List<TransactionEntity> get todayTransactions {
    final today = DateTime.now();
    return _filteredTransactions.where((t) {
      return t.fecha.year == today.year &&
          t.fecha.month == today.month &&
          t.fecha.day == today.day;
    }).toList();
  }

  List<TransactionEntity> getTransactionsByCategory(int categoryId) {
    return _filteredTransactions.where((t) => t.categoryId == categoryId).toList();
  }
}
