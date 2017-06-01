from django.conf.urls import url
from . import views


urlpatterns = [
	url(r'^$', views.textbook_list, name='textbook_list'),
	url(r'^textbook/(?P<textbook_id>[0-9]+)/quest/$', views.quest_list, name='quest_list'),
	url(r'^textbook/quest/(?P<quest_id>[0-9]+)/$', views.quest_detail, name='quest_detail'),
]


