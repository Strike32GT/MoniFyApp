class UserEntity {
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

  UserEntity({
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

  //Las Reglas de negocio de la App
  bool canUpgradeToNextLevel() {
    return xpActual >= (nivel * 100);
  }

  int getXpForNextLevel() {
    return (nivel + 1) * 100 - xpActual;
  }

  bool hasAvatar() => avatar != null && avatar!.isNotEmpty;
}
