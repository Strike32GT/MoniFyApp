from django.urls import path
from .views import AchievementListCreateView, UserAchievementDetailView, UserAchievementListCreateView, StreakListCreateView, StreakDetailView

urlpatterns = [
    path('achievements/', AchievementListCreateView.as_view()),
    path('achievements/<int:pk>/', UserAchievementDetailView.as_view()),

    path('user-achievements/', UserAchievementListCreateView.as_view()),
    path('user-achievements/<int:pk>/', UserAchievementDetailView.as_view()),

    path('streaks/', StreakListCreateView.as_view()),
    path('streaks/<int:pk>/', StreakDetailView.as_view()),
]