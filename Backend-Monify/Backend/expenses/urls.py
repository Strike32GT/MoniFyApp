from django.urls import path
from .views import(CategoryListView, TransactionListCreateView, TransactionDetailView, TodaySummaryView, WeeklyStatsView)

urlpatterns = [
    path('categories/',CategoryListView.as_view()),
    path('transactions/',TransactionListCreateView.as_view()),
    path('transactions/<int:pk>/',TransactionDetailView.as_view()),
    path('sumary/today/',TodaySummaryView.as_view()),
    path('stats/weekly/',WeeklyStatsView.as_view()),
]