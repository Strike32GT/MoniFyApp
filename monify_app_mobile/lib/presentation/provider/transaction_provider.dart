import 'package:flutter/foundation.dart';
import 'package:monify_app_mobile/data/models/category_model.dart';
import 'package:monify_app_mobile/domain/entities/transaction_entity.dart';

class TransactionProvider extends ChangeNotifier{
  final GetTransactionsUseCase _getTransactionsUseCase;
  final CreateTransactionUseCase _createTransactionUseCase;
  final GetTodaySummaryUseCase _getTodaySummaryUseCase;
  final GetWeeklyStatsUseCase _getWeeklyStatsUseCase;

  TransactionProvider({
    required GetTransactionsUseCase getTransactionsUseCase,
    required CreateTransactionUseCase createTransactionUseCase,
    required GetTodaySummaryUseCase getTodaySummaryUseCase,
    required GetWeeklyStatsUseCase getWeeklyStatsUseCase,
  }) : _getTodaySummaryUseCase = getTransactionsUseCase,
       _createTransactionUseCase = createTransactionUseCase,
       _getTodaySummaryUseCase = getTodaySummaryUseCase,
       _getWeeklyStatsUseCase = getWeeklyStatsUseCase;


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
    String? descripcion,
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
        descripcion: descripcion,
        fecha: DateTime.now(),
        );

        final newTransaction = await _createTransactionUseCase.execute(transaction);

        _transactions.insert(0, newTransaction);
        _applyFilters();

        await _loadTodaySummary();

        notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }


  Future<void> loadCategories() async {
    try {
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }


  Future<void> loadTodaySummary() async {
    try {
      _todaySummary = await _getTodaySummaryUseCase.execute();
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }



  Future<void> loadWeeklyStats({String period='semana'}) async {
    try {
      _weeklyStats = await _getWeeklyStatsUseCase.execute(period: period);
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
    _searchQuery = "";
    _selectedFilter = 'todos';
    _selectedCategoryFilter = 'todas';
    _applyFilters();
    notifyListeners();
  }


  //Filtro combinado
  void _applyFilters() {
    _filteredTransactions = _transactions.where((transaction) {
      
      //Por busqueda
      bool matchesSearch = true;
      if(_searchQuery.isNotEmpty) {
        matchesSearch = transaction.descripcion?.toLowerCase().contains(_searchQuery) == true || 
                           transaction.monto.toString().contains(_searchQuery);
      }



      //Por tipo
      bool matchesType = true;
      if(_selectedFilter != 'todos') {
        matchesType = transaction.tipo == _selectedFilter;
      }



      //Por categoria
      bool matchesCategory = true;
      if (_selectedCategoryFilter != 'todas') {
        matchesCategory = transaction.categoryId.toString() == _selectedCategoryFilter;
      }


      return matchesSearch && matchesType && matchesCategory;
    }).toList();
  }



  Future<void> refreshAll() async {
    await Future.wait([
      loadTransactions(),
      loadCategories(),
      loadTodaySummary(),
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
    notifyListeners();
  }


  void clearError() {
    _clearError();
  }


  //getters estadistica
  double get totalIncome {
    return _filteredTransactions
    .where((t) => t.tipo == 'ingreso')
    .fold(0.0, (sum,t) => sum + t.monto);
  }



  double get totalExpense {
    return _filteredTransactions
    .where((t) => t.tipo == 'gasto')
    .fold(0.0, (sum,t) => sum + t.monto);
  }


  double get balance {
    return totalIncome - totalExpense;
  }



  int get transactionCount => _filteredTransactions.length;


  //Ultimas 5 transacciones
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
    return _filteredTransactions
    .where((t) => t.categoryId == categoryId)
    .toList();
  }


}