from django.conf.urls import url

from . import views

urlpatterns = [
        url(r'testme', views.testme, name="testme"),
        url(r'^$', views.index, name="index"),
]
