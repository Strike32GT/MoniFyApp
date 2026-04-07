import 'package:monify_app_mobile/domain/entities/streak_entity.dart';
import 'package:monify_app_mobile/domain/repositories/gamification_repository_interface.dart';

class UpdateStreakUsecase {
  final GamificationRepository _repository;

  UpdateStreakUsecase(this._repository);

  Future<StreakEntity> execute() async {
    try {
      //Racha actual
      final currentStreak = await _repository.getStreak();

      //Calculo de nueva racha
      final today = DateTime.now();
      final newStreakData = _calculateNewStreak(currentStreak, today);

      //Actualizar racha
      final updatedStreak = await _repository.updateStreak(
        rachaActual: newStreakData['racha_actual'],
        mejorRacha: newStreakData['mejor_racha'],
        ultimaFecha: newStreakData['ultima_fecha'],
      );


      //Verifica estado de la racha(mejoro/empeoro)
      _checkStreakMilestones(updatedStreak);
      return updatedStreak;
    } catch (e) {
      throw Exception('Error al actualizar racha: $e');
    } 
  }


  Future<StreakEntity> executeWithDate(DateTime specificdate) async {
    try {
      final currentStreak = await _repository.getStreak();
      final newStreakData = _calculateNewStreak(currentStreak, specificdate);

      final updateStreak = await _repository.updateStreak(
        rachaActual: newStreakData['racha_actual'],
        mejorRacha: newStreakData['mejor_racha'],
        ultimaFecha: newStreakData['ultima_fecha'],
      );

      _checkStreakMilestones(updateStreak);
      return updateStreak;
    } catch (e) {
      throw Exception('Error al actualizar racha con fecha específica: $e');
    }
  }


  Map<String, dynamic> _calculateNewStreak(StreakEntity currentStreak, DateTime today) {
    final newRacha = currentStreak.calculateNewStreak(today);
    final isPersonalBest = newRacha > currentStreak.mejorRacha;


    return {
      'racha_actual' : newRacha,
      'mejor_racha': isPersonalBest ? newRacha : currentStreak.mejorRacha,
      'ultima_fecha': today,
      'is_personal_best': isPersonalBest,
      'streak_broken': newRacha == 1 && currentStreak.rachaActual > 1,
      'streak_continued': newRacha > currentStreak.rachaActual,
    };
  }


  //Notificar hitos de racha
  void _checkStreakMilestones(StreakEntity streak) {
    final milestones = _getStreakMilestones(streak);

    for (final milestone in milestones) {
      _notifyStreakMilestone(milestone);
    }
  }

  List<String> _getStreakMilestones(StreakEntity streak) {
    final milestones = <String>[];

    if (streak.rachaActual == 1 && streak.ultimaFecha?.day == DateTime.now().day) {
      milestones.add('¡Comenzaste una nueva racha hoy!');
    }
    
    if (streak.rachaActual == 3) {
      milestones.add('¡3 días seguidos! Sigue así');
    }
    
    if (streak.rachaActual == 7) {
      milestones.add('¡Una semana completa! 🎉');
    }
    
    if (streak.rachaActual == 14) {
      milestones.add('¡Dos semanas seguidas! 🔥');
    }
    
    if (streak.rachaActual == 30) {
      milestones.add('¡Un mes completo! Eres increíble 💪');
    }
    
    if (streak.rachaActual == 100) {
      milestones.add('¡100 días! Eres leyenda 🏆');
    }
    
    if (streak.isPersonalBest() && streak.rachaActual > 1) {
      milestones.add('¡Nueva mejor racha personal! 🌟');
    }

    return milestones;
  }


  void _notifyStreakMilestone(String message) {
    print('Streak Milestone: $message');
  }


  Future<bool> shouldUpdateStreakToday() async {
    try {
      final currentStreak = await _repository.getStreak();
      final today = DateTime.now();

      if(currentStreak.ultimaFecha != null) {
        final lastUpdate = currentStreak.ultimaFecha!;
        final todayDate = DateTime(today.year, today.month, today.day);
        final lastUpdateDate = DateTime(lastUpdate.year, lastUpdate.month, lastUpdate.day);
        
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
        'days_to_next_milestone': _getDaysToNextMilestone(currentStreak.rachaActual),
        'streak_status': _getStreakStatus(currentStreak),
        'last_update': currentStreak.ultimaFecha,
        'streak_percentage': _getStreakPercentage(currentStreak),
      };
    } catch (e) {
      throw Exception('Error al obtener estadísticas de racha: $e');
    }
  }


  int _getDaysToNextMilestone(int currentStreak) {
    final milestones = [3,7,14,30,60,100,365];

    for (final milestone in milestones) {
      if (currentStreak < milestone) {
        return milestone - currentStreak;
      }
    }

    return 0; //Alcanzo todos los hitos
  }

  String _getStreakStatus(StreakEntity streak) {
    if(!streak.hasActiveStreak()) {
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
    if (streak.mejorRacha == 0) return 0.0;
    return (streak.rachaActual / streak.mejorRacha) * 100;
  }


  Future<void> resetStreak() async {
      try {
        final currentStreak = await _repository.getStreak();
        await _repository.updateStreak(
          rachaActual: 1,
          mejorRacha: currentStreak.mejorRacha,
          ultimaFecha: DateTime.now(),
        );
      } catch (e) {
        throw Exception('Error al reiniciar racha: $e');
      }
  }
}