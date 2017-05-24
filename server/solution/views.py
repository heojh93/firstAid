from django.shortcuts import render
from .models import Textbook


# Create your views here.


def textbook_list(request):
	textbooks = Textbook.object.All()
	return render(request, 'solution/textbook.html', {})


