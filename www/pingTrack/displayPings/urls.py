from django.conf.urls import url
from django.conf import settings
from django.conf.urls.static import static

from . import views

urlpatterns = [
        url(r'testme', views.testme, name="testme"),
        url(r'^$', views.index, name="index"),
        url(r'st', views.speedtest, name="speedtest"),
        url(r'^plotMe$', views.plotMe, name="plotMe"),
        url(r'methodology', views.methodology, name="methodology"),
        url(r'', views.page404, name="page404"),
] + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
