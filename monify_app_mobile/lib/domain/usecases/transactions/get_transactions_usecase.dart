import 'package:monify_app_mobile/data/repositories/transaction_repository.dart';
import 'package:monify_app_mobile/domain/entities/transaction_entity.dart';

class GetTransactionsUsecase {
  final TransactionRepository _repository;
  GetTransactionsUsecase(this._repository);

  Future<List<TransactionEntity>> execute({
    String? category,
    String? type,
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
  }) async {
    try {
      final transactions = await _repository.getTransactions();

      final filteredTransactions = _applyFilters(
        transactions,
        category: category,
        type: type,
        startDate: startDate,
        endDate: endDate,
        limit: limit,
      );

      filteredTransactions.sort((a, b) => b.fecha.compareTo(a.fecha));

      return filteredTransactions;
    } catch (e) {
      throw Exception('Error al obtener transacciones: $e');
    }
  }

  List<TransactionEntity> _applyFilters(
    List<TransactionEntity> transactions, {
    String? category,
    String? type,
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
  }) {
    List<TransactionEntity> filtered = List.from(transactions);

    //Filtro por categoria
    if (category != null && category.isNotEmpty) {
      filtered = filtered
          .where((t) => t.categoryId.toString() == category)
          .toList();
    }


    //Filtro por tipo(ingreso/gasto)
    if (type != null && type.isNotEmpty) {
      filtered = filtered.where((t) => t.tipo == type).toList();
    }

    
    //Filtro por rango de fechas
    if (startDate != null) {
      filtered = filtered.where((t) => t.fecha.isAfter(startDate)).toList();
    }


    if (endDate != null) {
      filtered = filtered.where((t) => t.fecha.isBefore(endDate)).toList();
    }


    if (limit != null && limit > 0) {
      filtered = filtered.take(limit).toList();
    }

    return filtered;
  }
}
