  import 'package:monify_app_mobile/data/models/achievement_model.dart';
  import 'package:monify_app_mobile/data/models/streak_model.dart';
  import 'package:monify_app_mobile/data/services/api_service.dart';

  class GamificationService {
    final ApiService _apiService;

    GamificationService(this._apiService);

    Future<List<AchievementModel>> getAchievements() async {
      final response = await _apiService.get('/gamification/achievements/');
      return (response['results'] as List)
      .map((json) => AchievementModel.fromJson(json))
      .toList();
    }


    Future<List<AchievementModel>> getUserAchievements() async {
      final response = await _apiService.get('/gamification/user-achievements/');
      return (response['results'] as List)
          .map((json) => AchievementModel.fromJson(json))
          .toList();
    }
    
    Future<StreakModel> getStreak() async {
      final response = await _apiService.get('/gamification/streaks/');
      return StreakModel.fromJson(response['results'][0]);
    }
    
    Future<StreakModel> updateStreak() async {
      final response = await _apiService.post('/gamification/streaks/update/',{});
      return StreakModel.fromJson(response);
    }
  }