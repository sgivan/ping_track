from django.conf.urls import url

from . import views

urlpatterns = [
        url(r'testme', views.testme, name="testme"),
        url(r'^$', views.index, name="index"),
        url(r'^plotMe$', views.plotMe, name="plotMe"),
        url(r'', views.page404, name="page404"),
]
