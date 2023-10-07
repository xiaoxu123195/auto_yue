"""
URL configuration for auto_yue project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
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
from django.urls import path, include
from app01.views import user, host, account

urlpatterns = [
    path("admin/", admin.site.urls),

    path("login/", account.login, name='login'),
    path("logout/", account.logout, name='logout'),

    path("index/", account.index, name='index'),

    path("user/list/", user.user_list, name="user_list"),
    path("user/add/", user.user_add, name="user_add"),
    path("user/edit/<int:pk>/", user.user_edit, name="user_edit"),
    path("user/del/<int:pk>/", user.user_del, name="user_del"),
    path('user/reset/password/<int:pk>/', user.user_reset_pwd, name='user_reset_pwd'),

    path("host/list/", host.host_list, name="host_list"),
    path("host/add/", host.host_add, name="host_add"),
    path("host/edit/<int:pk>/", host.host_edit, name="host_edit"),
    path("host/del/<int:pk>/", host.host_del, name="host_del"),

    path('rbac/', include('rbac.urls', namespace='rbac')),

]
