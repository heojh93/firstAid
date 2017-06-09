from django.shortcuts import render
from django.http import HttpResponse
from .models import *
from django.views.decorators.csrf import csrf_exempt

import json
import time

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
		p['answer_number'] = 0
		problem_list.append(p)
	data = json.dumps(problem_list, ensure_ascii=False)
	return HttpResponse(data)


@csrf_exempt
def textbook_post(request):
	if request.method != "POST":
		return HttpResponse("unvalid")

	data = json.loads(request.body.decode())

	author = data.get('author', '')
	title = data.get('title', '')

	textbook =Textbook(author=author, title=title)
	textbook.save()

	t = {}
	t['title'] = textbook.title
	t['author'] = textbook.author
	t['id'] = textbook.id
	try: t['image_url'] = textbook.image.url
	except: t['image_url'] = ""
	data = json.dumps(t, ensure_ascii=False)
	return HttpResponse(data)


@csrf_exempt
def problem_post(request):
	if request.method != "POST":
		return HttpResponse("unvalid")

	data = json.loads(request.body.decode())

	textbook_id = int(data.get('textbook_id', 0))
	chapter = int(data.get('chapter', 0))
	number = int(data.get('number', 0))
	author = data.get('author', '')
	title = data.get('title', '')
	content = data.get('content', '')
	tag = data.get('tag', '')

	tag_list = tag.split(' ')
	tag_list = [ tag.strip(' #') for tag in tag_list ]


	problem = Problem(textbook=Textbook.objects.get(id=textbook_id), chapter=chapter, number=number,
			author=author, title=title, content=content)
	problem.save()

	for tag in tag_list:
		if tag == '': break
		try:
			t = Tag.objects.get(title=tag)
		except:
			t = Tag(title=tag)
			t.save()
		problem.tags.add(t)

	
	p = {}
	p['id'] = problem.id
	p['number'] = problem.number
	p['chapter'] = problem.chapter
	p['author'] = problem.author
	p['tag'] = ""
	for tag in problem.tags.all():
		p['tag'] = p['tag'] + "#" + str(tag.title) + " "
	p['tag'] = p['tag'][:-1]
	p['answer_number'] = 0
	data = json.dumps(p, ensure_ascii=False)
	return HttpResponse(data)


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



