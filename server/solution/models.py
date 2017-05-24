from django.db import models
from django.utils import timezone

# Create your models here.


class Textbook(models.Model):
	author = models.CharField(max_length = 100)
	title = models.CharField(max_length = 200)

	def __str__(self):
		return self.title


