from django.urls import path
from .views import UserListView, UserDetailView, UserRegisterView, UserLoginView, UserProfileView, UserUpdateView, UserLogoutView


urlpatterns = [
    path('login/',UserLoginView.as_view(), name='user-login'),
    path('register/',UserRegisterView.as_view(), name='user-register'),
    path('profile/',UserProfileView.as_view(), name='user-profile'),
    path('update/', UserUpdateView.as_view(), name='user-update'),
    path('logout/', UserLogoutView.as_view(), name='user-logout'),
    path('',UserListView.as_view(), name='user-list'),
    path('<int:pk>/',UserDetailView.as_view(), name='user-detail'),
]