import 'package:monify_app_mobile/domain/entities/user_entity.dart';

class UserModel {
  final int id;
  final String nombre;
  final String correo;
  final String rol;
  final String? avatar;
  final double presupuesto;
  final String moneda;
  final int nivel;
  final int xpActual;
  final int mejorRacha;
  final DateTime fechaCreacion;

  UserModel({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.rol,
    this.avatar,
    required this.presupuesto,
    required this.moneda,
    required this.nivel,
    required this.xpActual,
    required this.mejorRacha,
    required this.fechaCreacion,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nombre: json['nombre'],
      correo: json['correo'],
      rol: json['rol'],
      avatar: json['avatar'],
      presupuesto: json['presupuesto'].toDouble(),
      moneda: json['moneda'],
      nivel: json['nivel'],
      xpActual: json['xpActual'],
      mejorRacha: json['mejorRacha'],
      fechaCreacion: DateTime.parse(json['fechaCreacion']),
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      nombre: nombre,
      correo: correo,
      rol: rol,
      presupuesto: presupuesto,
      moneda: moneda,
      nivel: nivel,
      xpActual: xpActual,
      mejorRacha: mejorRacha,
      fechaCreacion: fechaCreacion,
    );
  }
}
