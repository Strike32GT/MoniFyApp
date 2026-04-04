from rest_framework import serializers
from django.contrib.auth import authenticate
from django.contrib.auth.hashers import make_password
from .models import User

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'nombre', 'correo', 'rol','avatar', 'presupuesto', 'moneda',
                  'presupuesto', 'moneda', 'nivel', 'xp_actual', 'mejor_racha', 'fecha_creacion']
        

class UserRegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = [
            'id',
            'nombre',
            'password',
            'rol',
            'avatar',
            'presupuesto',
            'moneda',
            'nivel',
            'xp_actual',
            'mejor_racha',
            'fecha_creacion'
        ]     

        extra_kwargs = {
            'password': {'write_only':True},
            'rol' : {'required':False},
        }

    def validate_rol(self,value):
        if value not in ['usuario','admin']:
            raise serializers.ValidationError("El rol no existe")
        return value
    

    def create(self, validate_data):
        validate_data['password'] = make_password(validate_data['password'])
        return User.objects.create(**validate_data)




class UserLoginSerializer(serializers.ModelSerializer):
    correo = serializers.EmailField()
    password = serializers.CharField()


    def validate(self,data):
        correo = data.get('correo')
        password = data.get('password')

        if correo and password:
            user = authenticate(username=correo, password=password)
            if not user:
                raise serializers.ValidationError('Credenciales incorrectas')
            data['user'] = user
            return data
        raise serializers.ValidationError('Se requiere correo y password')
