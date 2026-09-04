class CategoryModel {
  final int id;
  final String nombre;
  final String icono;
  final String color;

  CategoryModel({
    required this.id,
    required this.nombre,
    required this.icono,
    required this.color,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      nombre: json['nombre'],
      icono: json['icono'],
      color: json['color'],
    );
  }
}
