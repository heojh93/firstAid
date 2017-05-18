from django.db import models
from django.utils import timezone


class Textbook(models.Model):
	title = models.CharField(max_length=200)
	author = models.CharField(max_length=200)
	
	chapter_list = [];

	def __str__(self):
		return self.title
	
	

# Create your models here.
