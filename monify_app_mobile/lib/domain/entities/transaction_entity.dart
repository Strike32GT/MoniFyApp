class TransactionEntity {
  final int id;
  final int userId;
  final int categoryId;
  final String tipo;
  final double monto;
  final String? descripcion;
  final DateTime fecha;

  TransactionEntity({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.tipo,
    required this.monto,
    this.descripcion,
    required this.fecha,
  });

  bool isInCome() => tipo == 'ingreso';
  bool isExpense() => tipo == 'gasto';

  bool isValidAmount() {
    return monto > 0 && monto <= 10000;
  }

  bool isValidType() {
    return ['ingreso', 'gasto'].contains(tipo);
  }

  String get formattedAmount {
    final sign = isInCome() ? '+' : '-';
    return '$sign S/${monto.toStringAsFixed(2)}';
  }
}
