from django.db import models
from django.utils import timezone

# Create your models here.


class Textbook(models.Model):
	author = models.CharField(max_length = 100)
	title = models.CharField(max_length = 200)
	image = models.ImageField(blank=True, upload_to = 'cover')

	def delete(self, *args, **kwargs):
		self.image.delete()
		super(Textbook, self).delete(*args, **kwargs)

	def __str__(self):
		return self.title
	
	class Admin:
		pass


class Tag(models.Model):
	title = models.CharField(max_length = 30, null = False)

	def __str__(self):
		return self.title


class Quest(models.Model):
	textbook = models.ForeignKey(Textbook)
	number = models.CharField(max_length = 100)
	author = models.CharField(max_length = 100)
	title = models.CharField(max_length = 200)
	content = models.TextField(max_length = 500)
	created_at = models.DateTimeField(auto_now_add = True)
	image = models.ImageField(blank=True, upload_to = 'quest')
	tags = models.ManyToManyField(Tag)


	def __str__(self):
		return self.title


class Answer(models.Model):
	quest = models.ForeignKey(Quest)
	author = models.CharField(max_length = 100)
	title = models.CharField(max_length = 200)
	content = models.TextField(max_length = 500)
	created_at = models.DateTimeField(auto_now_add = True)
	image = models.ImageField(blank=True, upload_to = 'answer')


	def __str__(self):
		return self.title

