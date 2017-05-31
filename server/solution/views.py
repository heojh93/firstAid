from django.shortcuts import render
from django.http import HttpResponse
from .models import *

import json

# Create your views here.


def textbook_list(request):
	textbooks_list = []
	textbooks = Textbook.objects.all()
	for textbook in textbooks:
		t = {}
		t['title'] = textbook.title
		t['author'] = textbook.author
		t['id'] = textbook.id
		textbooks_list.append(t)
	data = json.dumps(textbooks_list)
	return HttpResponse(data)
#return render(request, 'solution/textbook.html', {})




def quest_list(request, textbook_id):
	textbook_id = int(textbook_id)
	quests_list = []
	quests = Quest.objects.filter(textbook=textbook_id)
	for quest in quests:
		q = {}
		q['id'] = quest.id
		q['number'] = quest.number
		q['title'] = quest.title
		q['author'] = quest.author
		q['tag'] = []
		for tag in quest.tags.all():
			q['tag'].append(tag.title)
		quests_list.append(q)
	data = json.dumps(quests_list)
	return HttpResponse(data)


def quest_detail(request, qeust_id):
	quest_id = int(quest_id)
	pass



