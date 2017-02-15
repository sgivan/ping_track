from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader
from django.utils import timezone


# Create your views here.
def index(request):
    today_date = timezone.now()
    template = loader.get_template('polls/index.html')
    context = {
            'current_date' : today_date,
            }
    return HttpResponse(template.render(context,request))

def testme(request):
    return HttpResponse("<h1>This is a test</h1>")

