from rest_framework import serializers
from .models import Category, Transaction


class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = ['id','nombre','icono','color']


class TransactionSerializer(serializers.ModelSerializer):
    category_detalle = CategorySerializer(source='category', read_only=True)

    class Meta:
        model = Transaction
        fields = ['id', 'user', 'category','category_detalle', 'tipo', 'monto', 'descripcion', 'fecha']
        