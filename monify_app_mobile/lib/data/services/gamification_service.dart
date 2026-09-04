import 'package:monify_app_mobile/data/models/achievement_model.dart';
import 'package:monify_app_mobile/data/models/streak_model.dart';
import 'package:monify_app_mobile/data/services/local_app_store.dart';

class GamificationService {
  Future<List<AchievementModel>> getAchievements() async {
    return LocalAppStore.instance.getAchievements();
  }

  Future<List<AchievementModel>> getUserAchievements() async {
    return LocalAppStore.instance.getAchievements();
  }

  Future<StreakModel> getStreak() async {
    return LocalAppStore.instance.getStreak();
  }

  Future<StreakModel> updateStreak() async {
    return LocalAppStore.instance.getStreak();
  }
}
