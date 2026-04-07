import 'package:monify_app_mobile/data/models/category_model.dart';
import 'package:monify_app_mobile/data/models/transaction_model.dart';
import 'package:monify_app_mobile/data/services/transaction_service.dart';
import 'package:monify_app_mobile/domain/entities/transaction_entity.dart';

abstract class TransactionRepository {
  Future<List<TransactionEntity>> getTransactions();
  Future<TransactionEntity> createTransaction(TransactionModel transaction);
  Future<List<CategoryModel>> getCategories();
  Future<Map<String, dynamic>> getTodaySummary();
  Future<Map<String, dynamic>> getWeeklyStats();
}


class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionService _transactionService;

  TransactionRepositoryImpl(this._transactionService);


  @override 
  Future<List<TransactionEntity>> getTransactions() async {
    final models = await _transactionService.getTransactions();
    return models.map((transaction) => transaction.toEntity()).toList();
  }

  Future<TransactionEntity> createTransaction(TransactionModel transaction) async {
    final model = await _transactionService.createTransaction({
      'category':transaction.category,
      'tipo':transaction.tipo,
      'monto':transaction.monto,
      'descripcion':transaction.descripcion,
    });

    return model.toEntity();
  }


  @override
  Future<List<CategoryModel>> getCategories() async {
    return await _transactionService.getCategories();
  }


  @override
  Future<Map<String, dynamic>> getTodaySummary() async {
    return await _transactionService.getTodaySummary();
  }


  @override
  Future<Map<String, dynamic>> getWeeklyStats() async {
    return await _transactionService.getWeeklyStats();
  }
}