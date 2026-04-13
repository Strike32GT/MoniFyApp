from django.contrib.auth.hashers import check_password, make_password
from rest_framework import serializers

from .models import User


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = [
            'id',
            'nombre',
            'correo',
            'rol',
            'avatar',
            'presupuesto',
            'moneda',
            'nivel',
            'xp_actual',
            'mejor_racha',
            'fecha_creacion',
        ]


class UserRegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = [
            'id',
            'nombre',
            'correo',
            'password',
            'rol',
            'avatar',
            'presupuesto',
            'moneda',
            'nivel',
            'xp_actual',
            'mejor_racha',
            'fecha_creacion',
        ]
        extra_kwargs = {
            'password': {'write_only': True},
            'rol': {'required': False},
        }

    def validate_rol(self, value):
        if value not in ['usuario', 'admin']:
            raise serializers.ValidationError('El rol no existe')
        return value

    def create(self, validated_data):
        validated_data['password'] = make_password(validated_data['password'])
        return User.objects.create(**validated_data)


class UserLoginSerializer(serializers.Serializer):
    correo = serializers.EmailField()
    password = serializers.CharField(write_only=True)

    def validate(self, data):
        correo = data.get('correo')
        password = data.get('password')

        if not correo or not password:
            raise serializers.ValidationError('Se requiere correo y password')

        try:
            user = User.objects.get(correo=correo)
        except User.DoesNotExist:
            raise serializers.ValidationError('Credenciales incorrectas')

        if not check_password(password, user.password):
            raise serializers.ValidationError('Credenciales incorrectas')

        data['user'] = user
        return data
