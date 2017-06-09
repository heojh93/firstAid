from django.contrib import admin
from .models import *

admin.site.register(Textbook)
admin.site.register(Problem)
admin.site.register(Quest)
admin.site.register(Answer)
admin.site.register(Tag)

# Register your models here.
