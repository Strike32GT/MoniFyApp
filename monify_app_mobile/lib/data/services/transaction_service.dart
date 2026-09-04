import 'package:monify_app_mobile/data/models/category_model.dart';
import 'package:monify_app_mobile/data/models/transaction_model.dart';
import 'package:monify_app_mobile/data/services/local_app_store.dart';

class TransactionService {
  Future<List<TransactionModel>> getTransactions() async {
    return LocalAppStore.instance.getTransactions();
  }

  Future<TransactionModel> createTransaction(
    Map<String, dynamic> transactionData,
  ) async {
    return LocalAppStore.instance.createTransaction(transactionData);
  }

  Future<List<CategoryModel>> getCategories() async {
    return LocalAppStore.instance.categories;
  }

  Future<Map<String, dynamic>> getTodaySummary() async {
    return LocalAppStore.instance.getTodaySummary();
  }

  Future<Map<String, dynamic>> getWeeklyStats() async {
    return LocalAppStore.instance.getWeeklyStats();
  }
}
