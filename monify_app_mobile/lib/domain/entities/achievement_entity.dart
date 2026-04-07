class AchievementEntity {
  final int id;
  final String nombre;
  final String descripcion;
  final String icono;

  AchievementEntity({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.icono,
  });

  bool isUnlocked() {
    return false;
  }
}