"""
URL configuration for drinks project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from GolfPlayer import views

urlpatterns = [
    #This empty path is added to just redirect to the base level json data
    path('', views.redirect_view),
    
    path('admin/', admin.site.urls),
    path('golfPlayers/', views.drink_list),
    path('golfPlayers/<int:id>', views.drink_detail)
]
