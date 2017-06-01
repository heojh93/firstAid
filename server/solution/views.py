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
		t['image_url'] = textbook.image.url
		textbooks_list.append(t)
	data = json.dumps(textbooks_list, ensure_ascii=False)
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
		q['answer_number'] = len(Answer.objects.filter(quest=quest.id))
		quests_list.append(q)
	data = json.dumps(quests_list, ensure_ascii=False)
	return HttpResponse(data)

def quest_post(request, textbook_id):
	if request.method != "POST":
		return HttpResponse("unvalid")

	textbook_id = int(textbook_id)



def quest_detail(request, quest_id):
	quest_id = int(quest_id)
	quest = Quest.objects.get(id=quest_id)
	q = {}
	q['id'] = quest.id
	q['number'] = quest.number
	q['author'] = quest.author
	q['title'] = quest.title
	q['content'] = quest.content
	q['created_at'] = str(quest.created_at)
	q['tag'] = []
	q['image_url'] = quest.image.url
	for tag in quest.tags.all():
		q['tag'].append(tag.title)
	
	data = json.dumps(q, ensure_ascii=False)
	return HttpResponse(data)



