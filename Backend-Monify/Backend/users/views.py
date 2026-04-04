from rest_framework import status
from rest_framework.views import APIView
from rest_framework.generics import ListAPIView, CreateAPIView, RetrieveAPIView, UpdateAPIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework_simplejwt.tokens import RefreshToken
from .models import User
from .serializers import UserSerializer, UserRegisterSerializer, UserLoginSerializer
# Create your views here.

class UserListView(ListAPIView):
    queryset = User.objects.all().order_by('-fecha_creacion')
    serializer_class = UserSerializer


class UserDetailView(RetrieveAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer


class UserRegisterView(CreateAPIView):
    queryset = User.objects.all()
    serializer_class = UserRegisterSerializer


    def create(self, request, *args, **kwargs):
        try:
            seralizer = self.get_serializer(data=request.data)
            if seralizer.is_valid():
                user = seralizer.save()
                return Response(
                    {
                        "message": "Usuario creado correctamente",
                        "user": UserSerializer(user).data
                    },
                    status=status.HTTP_201_CREATED
                )        
            return Response(
                {
                    "message": "Error de validacion",
                    "errors": seralizer.errors
                },
                status=status.HTTP_400_BAD_REQUEST
            )
        except Exception as e:
            return Response(
                {
                    "message": "Error interno del servidor",
                    "error": str(e)
                },
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )


class UserLoginView(APIView):
    def post(self,request):
        serializer = UserLoginSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.validated_data['user']
            refresh = RefreshToken.for_user(user)
            return Response({
                'user': UserSerializer(user).data,
                'tokens': {
                    'refresh': str(refresh),
                    'access': str(refresh.access_token),
                }
            })
        return Response(serializer.errors, status=400)
    


class UserProfileView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        serializer = UserSerializer(request.user) 
        return Response(serializer.data)



class UserUpdateView(UpdateAPIView):
    permission_classes  = [IsAuthenticated]
    serializer_class  = UserSerializer

    def get_object(self):
        return self.request.user
    


class UserLogoutView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        try:
            refresh_token = request.data.get("refresh")
            if refresh_token:
                token = RefreshToken(refresh_token)
                token.blacklist()
            return Response({'message':'Logout exitoso'})
        except Exception as e:
            return Response({'error': 'Error en logout'}, status=400)