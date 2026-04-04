
from datetime import date
from django.db.models import Sum, Avg
from django.db.models.functions import TruncDate
from rest_framework.generics import ListCreateAPIView, RetrieveUpdateDestroyAPIView, ListAPIView
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework import status
from .models import Category, Transaction
from .serializers import CategorySerializer, TransactionSerializer

# Create your views here.
class CategoryListView(ListAPIView):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer


class TransactionListCreateView(ListCreateAPIView):
    queryset = Transaction.objects.all().order_by('-fecha')
    serializer_class = TransactionSerializer


class TransactionDetailView(RetrieveUpdateDestroyAPIView):
    queryset = Transaction.objects.all()
    serializer_class = TransactionSerializer





class TodaySummaryView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self,request):
        user = request.user
        queryset = Transaction.objects.filter(user=user, fecha__date=date.today())

        ingresos = queryset.filter(tipo='ingreso').aggregate(total=Sum('monto'))['total'] or 0
        gastos = queryset.filter(tipo='gasto').aggregate(total=Sum('monto'))['total'] or 0          
        ahorro = ingresos - gastos

        return Response({
            'ingresos':ingresos,
            'gastos':gastos,
            'ahorro': ahorro
        }, status= status.HTTP_200_OK)
    


class WeeklyStatsView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        user = request.user
        gastos = Transaction.objects.filter(user=user, tipo ='gasto')
        gastos_total = gastos.aggregate(total=Sum('monto'))['total'] or 0
        promedio_diario = gastos.aggregate(promedio =Avg('monto'))['promedio'] or 0
        por_dia = gastos.annotate(dia=TruncDate('fecha')).values('dia').annotate(total=Sum('monto')).order_by('dia')
        dia_mayor = gastos.annotate(dia=TruncDate('fecha')).values('dia').annotate(total=Sum('monto')).order_by('-total').first()

        return Response({
            'gastos_total':gastos_total,
            'promedio_diario': promedio_diario,
            'dia_mayor_gasto' : dia_mayor,
            'gasto_por_dia' : list(por_dia)
        }, status=status.HTTP_200_OK
        )