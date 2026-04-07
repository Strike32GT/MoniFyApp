import 'package:monify_app_mobile/data/models/category_model.dart';
import 'package:monify_app_mobile/domain/entities/transaction_entity.dart';

class TransactionModel {
  final int id;
  final int user;
  final int category;
  final String tipo;
  final double monto;
  final String? descripcion;
  final DateTime fecha;
  final CategoryModel? categoryDetalle;


  TransactionModel({
    required this.id,
    required this.user,
    required this.category,
    required this.tipo,
    required this.monto,
    this.descripcion,
    required this.fecha,
    this.categoryDetalle,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
       id: json['id'],
      user: json['user'],
      category: json['category'],
      tipo: json['tipo'],
      monto: double.parse(json['monto'].toString()),
      descripcion: json['descripcion'],
      fecha: DateTime.parse(json['fecha']),
      categoryDetalle: json['category_detalle'] !=null
      ? CategoryModel.fromJson(json['category_detalle'])
      : null,
    );
  }


  TransactionEntity toEntity() {
    return TransactionEntity(
      id: id,
      userId: user,
      categoryId: category,
      tipo: tipo,
      monto: monto,
      descripcion: descripcion,
      fecha: fecha,
    );
  }
}