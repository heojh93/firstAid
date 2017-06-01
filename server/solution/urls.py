from django.conf.urls import url
from . import views


urlpatterns = [
	url(r'^$', views.textbook_list, name='textbook_list'),
	url(r'^textbook/(?P<textbook_id>[0-9]+)/quest_list/$', views.quest_list, name='quest_list'),
	url(r'^quest/(?P<quest_id>[0-9]+)/$', views.quest_detail, name='quest_detail'),
	url(r'^textbook/(?P<textbook_id>[0-9]+)/quest_post/$', views.quest_post, name='quest_post'),
]


