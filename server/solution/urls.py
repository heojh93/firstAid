from django.conf.urls import url
from . import views


urlpatterns = [
	url(r'^textbook_list/$', views.textbook_list, name='textbook_list'),
	url(r'^textbook/(?P<textbook_id>[0-9]+)/problem_list/$', views.problem_list, name='problem_list'),
	url(r'^problem/(?P<problem_id>[0-9]+)/$', views.problem_detail, name='problem_detail'),
	url(r'^problem_post/$', views.problem_post, name='problem_post'),
	url(r'^textbook_post/$', views.textbook_post, name='textbook_post'),
]


