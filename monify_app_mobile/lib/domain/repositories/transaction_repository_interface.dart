import 'package:monify_app_mobile/data/models/category_model.dart';
import 'package:monify_app_mobile/domain/entities/transaction_entity.dart';

abstract class TransactionRepository {
  Future<List<TransactionEntity>> getTransactions();
  Future<TransactionEntity> createTransaction(TransactionEntity transaction);
  Future<List<CategoryModel>> getCategories();
  Future<Map<String, dynamic>> getTodaySummary();
  Future<Map<String, dynamic>> getWeeklyStats();
}