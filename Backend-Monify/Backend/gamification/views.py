from rest_framework.generics import ListCreateAPIView, ListAPIView, RetrieveUpdateDestroyAPIView
from rest_framework.permissions import IsAuthenticated
from .models import Achievement, UserAchievement, Streak
from .serializers import AchievementSerializer, StreakSerializer, UserAchievementSerializer
# Create your views here.
class AchievementListCreateView(ListCreateAPIView):
    queryset = Achievement.objects.all()
    serializer_class = AchievementSerializer


class AchievementDetailView(RetrieveUpdateDestroyAPIView):
    queryset = Achievement.objects.all()
    serializer_class = AchievementSerializer


class UserAchievementListCreateView(ListCreateAPIView):
    serializer_class = UserAchievementSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return UserAchievement.objects.filter(user=self.request.user)


class UserAchievementDetailView(RetrieveUpdateDestroyAPIView):
    serializer_class = UserAchievementSerializer
    permission_classes  = [IsAuthenticated]


class StreakListCreateView(ListCreateAPIView):
    serializer_class = UserAchievementSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return Streak.objects.filter(user=self.request.user)



class StreakDetailView(RetrieveUpdateDestroyAPIView):
    serializer_class = StreakSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return Streak.objects.filter(user=self.request.user)