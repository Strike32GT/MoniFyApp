from django.db import models

# Create your models here.
class User(models.Model):
    ROLE_CHOICES = [
        ('usuario','Usuario'),
        ('admin','Admin'),
    ]
    id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=120)
    correo = models.EmailField(unique=True)
    password = models.CharField(max_length=255)
    rol = models.CharField(max_length=20, choices=ROLE_CHOICES, default='usuario')
    avatar = models.URLField(blank=True, null=True)
    presupuesto = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
    moneda = models.CharField(max_length=10,default="PEN")
    nivel = models.PositiveIntegerField(default=1)
    xp_actual = models.PositiveIntegerField(default=0)
    mejor_racha = models.PositiveIntegerField(default=0)
    fecha_creacion = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return f"{self.nombre} - {self.rol}"