from rest_framework import serializers
from .models import Achievement, UserAchievement, Streak

class AchievementSerializer(serializers.ModelSerializer):
    class Meta:
        model = Achievement
        fields = ['id','nombre','descripcion','icono']


class UserAchievementSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserAchievement
        fields = ['id','user','achievement','desbloqueado','fecha']


class StreakSerializer(serializers.ModelSerializer):
    class Meta:
        model = Streak
        fields = ['id','user','racha_actual','mejor_racha','ultima_fecha']        