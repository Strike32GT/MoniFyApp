import 'package:monify_app_mobile/domain/entities/achievement_entity.dart';
import 'package:monify_app_mobile/domain/repositories/gamification_repository_interface.dart';

class GetAchievementsUsecase {
  final GamificationRepository _repository;

  GetAchievementsUsecase(this._repository);

  Future<List<AchievementEntity>> execute({bool onlyUnlocked = false}) async {
    try {
      final achievements = await _repository.getAchievements();

      if (onlyUnlocked) {
        final userAchievements = await _repository.getAchievements();
        final unlockedIds = userAchievements.map((a) => a.id).toSet();

        return achievements.where((a) => unlockedIds.contains(a.id)).toList();
      }

      return achievements;
    } catch (e) {
      throw Exception('Error al obtener logros: $e');
    }
  } 


  Future<Map<String,dynamic>> getAchievementProgress() async {
    try {
      final allAchievements = await _repository.getAchievements();
      final userAchievements = await _repository.getUserAchievements();  


      final unlockedCount = userAchievements.length;
      final totalCount = allAchievements.length;
      final progressPercentage = totalCount > 0 ? (unlockedCount / totalCount) * 100 : 0;

      return {
        'unlocked_count': unlockedCount,
        'total_count': totalCount,
        'progress_percentage': progressPercentage,
        'next_achievement': _getNextAchievement(allAchievements, userAchievements),
        'recently_unlocked': _getRecentlyUnlocked(userAchievements),
      };
    } catch (e) {
      throw Exception('Error al obtener progreso de logros: $e');
    }
  }


  AchievementEntity? _getNextAchievement(
    List<AchievementEntity> allAchievements,
    List<AchievementEntity> userAchievements,
  ) {
    final unlockedIds = userAchievements.map((a) => a.id).toSet();

    for (final achievement in allAchievements) {
      if (!unlockedIds.contains(achievement.id)) {
        return achievement;
      }
    }

    return null;
  }


  List<AchievementEntity> _getRecentlyUnlocked(List<AchievementEntity> userAchievements) {
    //final now = DateTime.now();
    //final onWeekAgo = now.subtract(Duration(days: 7));

    //return userAchievements
           //.where((achievement) => achievement.fecha != null && 
                        //achievement.fecha!.isAfter(onWeekAgo))
    //.toList();
    return [];
  }


  Future<bool> checkNewAchievements(int userId) async {
    try {
      final currentAchievements = await _repository.getUserAchievements();
      final allAchievements = await _repository.getAchievements();

      final newUnlocked = <AchievementEntity> [];

      for(final achievement in allAchievements) {
        if(!_isUnlocked(achievement, currentAchievements)) {
          if(_shouldUnlockAchievement(achievement, userId)) {
            newUnlocked.add(achievement);
          }
        }
      }

      return newUnlocked.isNotEmpty;
    } catch (e) {
      throw Exception('Error al verificar nuevos logros: $e');
    }
  }


  bool _isUnlocked(AchievementEntity achievement, List<AchievementEntity> userAchievements) {
    return userAchievements.any((ua) => ua.id == achievement.id);
  }


  bool _shouldUnlockAchievement(AchievementEntity achievement, int userId) {
    switch (achievement.nombre.toLowerCase()) {
      case 'primera transaccion':
        return _hasTransactions(userId);
      case 'ahorrador':
        return _hasPositiveBalance(userId);  
      case 'racha semanal':
        return _hasWeeklystreak(userId);
      default:
        return false;    
    }
  }


  bool _hasTransactions(int userId) {
    return false;
  }


  bool _hasPositiveBalance(int userId) {
    return false;
  }


  bool _hasWeeklystreak(int userId) {
    return false;
  }
}