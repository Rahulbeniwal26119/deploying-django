"""docker_app URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
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
from django.urls import path, include, re_path
from rest_framework import permissions
from drf_yasg.views import get_schema_view
from drf_yasg import openapi

TITLE = "Django Docker Walkthrough"

schema_view = get_schema_view(
    openapi.Info(
        title=TITLE,
        default_version="v1",
        description=TITLE,
        license=openapi.License("BSD License")
    ),
    public=True,
    permission_classes=[permissions.AllowAny]
)

urlpatterns = [
    path('starwars/admin/', admin.site.urls),
    path("starwars/", include("first_app.urls")),
    re_path(r'^starwars/swagger(?P<format>\.json|\.yaml)$',
         schema_view.without_ui(cache_timeout=0), name="schema-json"),
    re_path(r'^starwars/swagger/$', schema_view.with_ui('swagger',
         cache_timeout=0), name="schema-swagger"),
    re_path(r'^starwars/redoc/$', schema_view.with_ui("redoc",
    cache_timeout=0), name="schema-redoc"),
    path('starwars/tinymce/', include('tinymce.urls'))
]
