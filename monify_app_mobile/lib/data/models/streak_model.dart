class StreakModel {
  final int id;
  final int user;
  final int rachaActual;
  final int mejorRacha;
  final DateTime? ultimaFecha;


  StreakModel({
    required this.id,
    required this.user,
    required this.rachaActual,
    required this.mejorRacha,
    this.ultimaFecha,
  });


  factory StreakModel.fromJson(Map<String, dynamic> json) {
    return StreakModel(
      id: json['id'],
      user: json['user'],
      rachaActual: json['racha_actual'],
      mejorRacha: json['mejor_racha'],
      ultimaFecha: json['ultima_fecha'] != null
      ? DateTime.parse(json['ultima_fecha'])
      : null,
    );
  }
}