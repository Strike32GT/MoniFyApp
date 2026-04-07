class StreakEntity {
  final int id;
  final int userId;
  final int rachaActual;
  final int mejorRacha;
  final DateTime? ultimaFecha;

  StreakEntity({
    required this.id,
    required this.userId,
    required this.rachaActual,
    required this.mejorRacha,
    this.ultimaFecha
  });

  bool hasActiveStreak() => rachaActual > 0;

  bool isPersonalBest() => rachaActual >= mejorRacha;

  bool shouldResetStreak(DateTime today) {
    if (ultimaFecha == null) return true;

    final daysDifference =today.difference(ultimaFecha!).inDays;
    return daysDifference > 1;
  }


  int calculateNewStreak(DateTime today) {
    if(ultimaFecha == null) return 1;

    final daysDifference = today.difference(ultimaFecha!).inDays;

    if (daysDifference == 1) {
      return rachaActual + 1;
    } else if (daysDifference == 0) {
      return rachaActual;
    } else {
      return 1;
    }
  }


}