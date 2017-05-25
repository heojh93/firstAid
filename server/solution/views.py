from django.shortcuts import render
from django.http import HttpResponse
from .models import Textbook

import json

# Create your views here.


def textbook_list(request):
	textbooks_list = []
	textbooks = Textbook.objects.all()
	for textbook in textbooks:
		t = {}
		t['title'] = textbook.title
		t['author'] = textbook.author
		textbooks_list.append(t)
	data = json.dumps(textbooks_list)
	return HttpResponse(data)
#return render(request, 'solution/textbook.html', {})


