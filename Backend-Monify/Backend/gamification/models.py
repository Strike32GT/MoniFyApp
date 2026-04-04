from django.db import models
from users.models import User
# Create your models here.
class Achievement(models.Model):
    id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=100)
    descripcion = models.TextField()
    icono = models.CharField(max_length=50)


    def __str__(self):
        return self.nombre
    


class UserAchievement(models.Model):
    id = models.AutoField(primary_key=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    achievement = models.ForeignKey(Achievement, on_delete=models.CASCADE)
    desbloqueado = models.BooleanField(default=False)
    fecha = models.DateTimeField(blank=True, null=True) 

    def __str__(self):
        return f"{self.user.nombre} - {self.achievement.nombre}"



class Streak(models.Model):
    id = models.AutoField(primary_key=True)
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    racha_actual = models.PositiveIntegerField(default=0)
    mejor_racha = models.PositiveIntegerField(default=0)
    ultima_fecha = models.DateField(blank=True, null=True)
    
    def __str__(self):
        return f"Racha de {self.user.nombre}"      
    

