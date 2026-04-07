import 'package:monify_app_mobile/data/models/category_model.dart';
import 'package:monify_app_mobile/data/models/transaction_model.dart';
import 'package:monify_app_mobile/data/services/api_service.dart';

class TransactionService {
  final ApiService _apiService;

  TransactionService(this._apiService);


  Future<List<TransactionModel>> getTransactions() async {
    final response = await _apiService.get('/expenses/transactions/');
    return (response['results'] as List)
    .map((json) => TransactionModel.fromJson(json))
    .toList();
  }



  Future<TransactionModel> createTransaction(Map<String, dynamic> transactionData) async {
    final response = await _apiService.post('/expenses/transactions/', transactionData);
    return TransactionModel.fromJson(response);
  }
  
  Future<List<CategoryModel>> getCategories() async {
    final response = await _apiService.get('/expenses/categories/');
    return (response['results'] as List)
        .map((json) => CategoryModel.fromJson(json))
        .toList();
  }


  Future<Map<String, dynamic>> getTodaySummary() async {
    return await _apiService.get('/expenses/sumary/today/');
  }

  Future<Map<String, dynamic>> getWeeklyStats() async {
    return await _apiService.get('/expenses/stats/weekly/');
  }
}