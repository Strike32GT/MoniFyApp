from django.db import models
from users.models import User
# Create your models here.
class Category(models.Model):
    id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=100)
    icono = models.CharField(max_length=50)
    color = models.CharField(max_length=20)

    def __str__(self):
        return self.nombre
    


class Transaction(models.Model):
    TIPO_CHOICES=[
        ('ingreso','Ingreso'),
        ('gasto','Gasto'),
    ]


    id = models.AutoField(primary_key=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE) 
    category = models.ForeignKey(Category, on_delete=models.CASCADE)   
    tipo = models.CharField(max_length=20, choices=TIPO_CHOICES)
    monto = models.DecimalField(max_digits=10, decimal_places=2)
    descripcion = models.CharField(max_length=200, blank=True, null=True)
    fecha = models.DateTimeField(auto_now_add=True)
    def __str__(self):
        return f"{self.tipo}, {self.monto}"    

    