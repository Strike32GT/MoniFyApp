import 'package:monify_app_mobile/domain/entities/achievement_entity.dart';
import 'package:monify_app_mobile/domain/entities/streak_entity.dart';

abstract class GamificationRepository {
  Future<List<AchievementEntity>> getAchievements();
  Future<List<AchievementEntity>> getUserAchievements();
  Future<StreakEntity> getStreak();
  Future<StreakEntity> updateStreak();
}
