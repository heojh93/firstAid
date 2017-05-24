from django.conf.urls import url
from . import views


urlpatterns = [
	url(r'^$', views.textbook_list, name='textbook_list'),

]


