from django.shortcuts import render

def textbook_list(request):
	return render(request, 'solution/textbook_list.html', {})



# Create your views here.
