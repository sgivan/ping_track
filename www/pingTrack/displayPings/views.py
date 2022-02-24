from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader
from django.utils import timezone
from django.http import Http404


# Create your views here.
def index(request):
    today_date = timezone.now()
    template = loader.get_template('displayPings/index.html')
    context = { 'current_date' : today_date }
#    return HttpResponse(template.render(context,request))
    return render(request, 'displayPings/index.html', context)

def speedtest(request):
    today_date = timezone.now()
    template = loader.get_template('displayPings/st.html')
    context = { 'current_date' : today_date }
#    return HttpResponse(template.render(context,request))
    return render(request, 'displayPings/st.html', context)

def methodology(request):
    return render(request, 'displayPings/methodology.html')

def testme(request):
    return HttpResponse("<h1>This is a test</h1>")

def page404(request):
    raise Http404('Page does not exist')

def plotMe(request):
    return HttpResponse('This is the plotMe page')

