import 'package:monify_app_mobile/domain/entities/streak_entity.dart';
import 'package:monify_app_mobile/domain/repositories/gamification_repository_interface.dart';

class UpdateStreakUsecase {
  final GamificationRepository _repository;

  UpdateStreakUsecase(this._repository);

  Future<StreakEntity> execute() async {
    try {
      final updatedStreak = await _repository.updateStreak();
      _checkStreakMilestones(updatedStreak);
      return updatedStreak;
    } catch (e) {
      throw Exception('Error al actualizar racha: $e');
    }
  }

  Future<StreakEntity> executeWithDate(DateTime specificDate) async {
    try {
      final currentStreak = await _repository.getStreak();
      final newStreakData = _calculateNewStreak(currentStreak, specificDate);

      final updatedStreak = StreakEntity(
        id: currentStreak.id,
        userId: currentStreak.userId,
        rachaActual: newStreakData['racha_actual'] as int,
        mejorRacha: newStreakData['mejor_racha'] as int,
        ultimaFecha: newStreakData['ultima_fecha'] as DateTime,
      );

      _checkStreakMilestones(updatedStreak);
      return updatedStreak;
    } catch (e) {
      throw Exception('Error al actualizar racha con fecha especifica: $e');
    }
  }

  Map<String, dynamic> _calculateNewStreak(
    StreakEntity currentStreak,
    DateTime today,
  ) {
    final newRacha = currentStreak.calculateNewStreak(today);
    final isPersonalBest = newRacha > currentStreak.mejorRacha;

    return {
      'racha_actual': newRacha,
      'mejor_racha': isPersonalBest ? newRacha : currentStreak.mejorRacha,
      'ultima_fecha': today,
      'is_personal_best': isPersonalBest,
      'streak_broken': newRacha == 1 && currentStreak.rachaActual > 1,
      'streak_continued': newRacha > currentStreak.rachaActual,
    };
  }

  void _checkStreakMilestones(StreakEntity streak) {
    final milestones = _getStreakMilestones(streak);

    for (final milestone in milestones) {
      _notifyStreakMilestone(milestone);
    }
  }

  List<String> _getStreakMilestones(StreakEntity streak) {
    final milestones = <String>[];

    if (_isSameDay(streak.ultimaFecha, DateTime.now()) &&
        streak.rachaActual == 1) {
      milestones.add('Comenzaste una nueva racha hoy!');
    }

    if (streak.rachaActual == 3) {
      milestones.add('3 dias seguidos! Sigue asi');
    }

    if (streak.rachaActual == 7) {
      milestones.add('Una semana completa!');
    }

    if (streak.rachaActual == 14) {
      milestones.add('Dos semanas seguidas!');
    }

    if (streak.rachaActual == 30) {
      milestones.add('Un mes completo! Eres increible');
    }

    if (streak.rachaActual == 100) {
      milestones.add('100 dias! Eres leyenda');
    }

    if (streak.isPersonalBest() && streak.rachaActual > 1) {
      milestones.add('Nueva mejor racha personal!');
    }

    return milestones;
  }

  bool _isSameDay(DateTime? firstDate, DateTime secondDate) {
    if (firstDate == null) {
      return false;
    }

    return firstDate.year == secondDate.year &&
        firstDate.month == secondDate.month &&
        firstDate.day == secondDate.day;
  }

  void _notifyStreakMilestone(String message) {
    print('Streak Milestone: $message');
  }

  Future<bool> shouldUpdateStreakToday() async {
    try {
      final currentStreak = await _repository.getStreak();
      final today = DateTime.now();

      if (currentStreak.ultimaFecha != null) {
        final lastUpdate = currentStreak.ultimaFecha!;
        final todayDate = DateTime(today.year, today.month, today.day);
        final lastUpdateDate = DateTime(
          lastUpdate.year,
          lastUpdate.month,
          lastUpdate.day,
        );

        return !todayDate.isAtSameMomentAs(lastUpdateDate);
      }

      return true;
    } catch (e) {
      return true;
    }
  }

  Future<Map<String, dynamic>> getStreakStats() async {
    try {
      final currentStreak = await _repository.getStreak();

      return {
        'current_streak': currentStreak.rachaActual,
        'best_streak': currentStreak.mejorRacha,
        'has_active_streak': currentStreak.hasActiveStreak(),
        'days_to_next_milestone': _getDaysToNextMilestone(
          currentStreak.rachaActual,
        ),
        'streak_status': _getStreakStatus(currentStreak),
        'last_update': currentStreak.ultimaFecha,
        'streak_percentage': _getStreakPercentage(currentStreak),
      };
    } catch (e) {
      throw Exception('Error al obtener estadisticas de racha: $e');
    }
  }

  int _getDaysToNextMilestone(int currentStreak) {
    final milestones = [3, 7, 14, 30, 60, 100, 365];

    for (final milestone in milestones) {
      if (currentStreak < milestone) {
        return milestone - currentStreak;
      }
    }

    return 0;
  }

  String _getStreakStatus(StreakEntity streak) {
    if (!streak.hasActiveStreak()) {
      return 'inactive';
    }

    if (streak.isPersonalBest()) {
      return 'personal_best';
    }

    if (streak.rachaActual >= 7) {
      return 'excellent';
    }

    if (streak.rachaActual >= 3) {
      return 'good';
    }

    return 'active';
  }

  double _getStreakPercentage(StreakEntity streak) {
    if (streak.mejorRacha == 0) {
      return 0.0;
    }

    return (streak.rachaActual / streak.mejorRacha) * 100;
  }

  Future<void> resetStreak() async {
    throw UnimplementedError(
      'resetStreak requiere un endpoint o metodo de repositorio dedicado.',
    );
  }
}
