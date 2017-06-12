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
		p['quest_number'] = len(Quest.objects.filter(problem=problem.id))
		p['answer_number'] = 0
		for quest in Quest.objects.filter(problem=problem.id):
			p['answer_number'] += len(Answer.objects.filter(quest=quest.id))
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

	if request.FILES:
		image = request.FILES['cover']
		textbook = Textbook(author=author, title=title, image=image)
	else:
		textbook = Textbook(author=author, title=title)
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

	try:
		problem = Problem.objects.get(number=number)
		flag = 1
	except:
		problem = Problem(textbook=Textbook.objects.get(id=textbook_id), chapter=chapter, number=number, author=author)
		problem.save()
		flag = 0

	quest = Quest(problem=problem, title=title, content=content)


	for tag in tag_list:
		if tag == '': break
		try:
			t = Tag.objects.get(title=tag)
		except:
			t = Tag(title=tag)
			t.save()
		problem.tags.add(t)
		quest.tags.add(t)

	
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
	p['append'] = flag
	data = json.dumps(p, ensure_ascii=False)
	
	return HttpResponse(data)



def problem_detail(request, problem_id):
	problem_id = int(problem_id)

	data = []
	problem = Problem.objects.get(id=problem_id)
	quests = Quest.objects.filter(problem=problem)
	for quest in quests:
		q = {}
		q['id'] = quest.id
		q['title'] = quest.title
		q['content'] = quest.content
		q['tag'] = ""
		for tag in quest.tags.all():
			q['tag'] = q['tag'] + "#" + str(tag.title) + " "
		q['tag'] = q['tag'][:-1]
		q['answer_list'] = []

		answers = Answer.objects.filter(quest=quest)
		for answer in answers:
			a = {}
			a['id'] = answer.id
			a['content'] = answer.content
			#a['image_url'] = answer.image.url
			a['like'] = answer.like
			q['answer_list'].append(a)
		
		data.append(q)

	
	data = json.dumps(data, ensure_ascii=False)
	return HttpResponse(data)


@csrf_exempt
def answer_post(request):
	if request.method != "POST":
		return HttpResponse("unvalid")

	data = json.loads(request.body.decode())


	quest_id = int(data.get('quest_id', 0))
	content = data.get('content', '')

	quest = Quest.objects.get(id=quest_id)

	answer = Answer(quest=quest, content=content, like=0)
	answer.save()
	
	data = "success"
	data = json.dumps(data, ensure_ascii=False)

	return HttpResponse(data)



def like(request, answer_id):
	answer = Answer.objects.get(id=answer_id)
	answer.like = answer.like + 1
	answer.save()

	return HttpResponse("")

def hate(request, answer_id):
	answer = Answer.objects.get(id=answer_id)
	answer.like = answer.like - 1
	answer.save()
	
	return HttpResponse("")
