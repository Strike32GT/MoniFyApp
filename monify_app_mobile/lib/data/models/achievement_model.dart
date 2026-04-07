class AchievementModel {
  final int id;
  final String nombre;
  final String descripcion;
  final String icono;

  AchievementModel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.icono,
  });


  factory AchievementModel.fromJson(Map<String, dynamic> json) {
    return AchievementModel(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      icono: json['icono'],
    );
  }
}