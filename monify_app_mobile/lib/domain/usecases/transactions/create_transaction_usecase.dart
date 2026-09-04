import 'package:monify_app_mobile/domain/entities/transaction_entity.dart';
import 'package:monify_app_mobile/domain/repositories/transaction_repository_interface.dart';

class CreateTransactionUsecase {
  final TransactionRepository _repository;

  CreateTransactionUsecase(this._repository);

  Future<TransactionEntity> execute(TransactionEntity transaction) async {
    if (!_isValidTransaction(transaction)) {
      throw ValidationException('Transaccion invalida');
    }

    try {
      final createdTransacion = await _repository.createTransaction(
        transaction,
      );

      return createdTransacion;
    } catch (e) {
      throw Exception('Error al crear transaccion: $e');
    }
  }

  bool _isValidTransaction(TransactionEntity transaction) {
    //Validar monto
    if (!transaction.isValidAmount()) {
      throw ValidationException(
        'El monto debe ser mayor a 0 y no exceder el límite diario',
      );
    }

    //Validar el tipo de transaccion
    if (!transaction.isValidType()) {
      throw ValidationException('Tipo de transaccion invalido.');
    }

    //Validar la descripcion si son montos grandes
    if (transaction.tipo == 'gasto' && transaction.monto > 10000) {
      if (transaction.descripcion == null ||
          transaction.descripcion!.trim().isEmpty) {
        throw ValidationException(
          'Los gastos mayores a S/10000 requieren una descripcion',
        );
      }
    }

    //Validar que la fecha no sea futura
    if (transaction.fecha.isAfter(DateTime.now())) {
      throw ValidationException('La fecha de transaccion no puede ser futura');
    }

    return true;
  }
}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);

  @override
  String toString() => message;
}
