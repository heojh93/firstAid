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
		try: t['image_url'] = textbook.image.url
		except: t['image_url'] = ""
		textbooks_list.append(t)
	data = json.dumps(textbooks_list, ensure_ascii=False)
	return HttpResponse(data)
#return render(request, 'solution/textbook.html', {})




def problem_list(request, textbook_id):
	textbook_id = int(textbook_id)
	problem_list = []
	problems = Problem.objects.filter(textbook=textbook_id)
	for problem in problems:
		p = {}
		p['id'] = problem.id
		p['number'] = problem.number
		p['chapter'] = problem.chapter
		p['author'] = problem.author
		p['tag'] = ""
		for tag in problem.tags.all():
			p['tag'] = p['tag'] + "#" + str(tag.title) + " "
			#q['tag'].append(tag.title)
		p['tag'] = p['tag'][:-1]
#p['answer_number'] = len(Answer.objects.filter(quest=quest.id))
		quests_list.append(q)
	data = json.dumps(quests_list, ensure_ascii=False)
	return HttpResponse(data)





from django.views.decorators.csrf import csrf_exempt
@csrf_exempt
def problem_post(request, textbook_id):
	if request.method != "POST":
		return HttpResponse("unvalid")

	textbook_id = int(textbook_id)
	chapter = request.POST.get('chapter', '')
	number = request.POST.get('number', '')
	author = request.POST.get('author', '')
	title = request.POST.get('title', '')
	content = request.POST.get('content', '')

	quest = Qeust(textbook=textbook_id, chapter=chapter, number=number,
			author=author, title=title, content=content)
	quest.save()
	
	return HttpResponse("good")


def problem_detail(request, quest_id):
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



