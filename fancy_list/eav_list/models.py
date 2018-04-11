from django.db import models

# Create your models here.
class ListName(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField()
    def __str__(self):
        return self.name

class Column(models.Model):
    name = models.TextField()
    list_name = models.ForeignKey(ListName, on_delete=models.CASCADE)
    def __str__(self):
        return self.name
class ListRow(models.Model):
    label = models.TextField()
    def __str__(self):
        return self.label
class Cell(models.Model):
    row = models.ForeignKey(ListRow,  on_delete=models.CASCADE)
    column = models.ForeignKey(Column,  on_delete=models.CASCADE)
    value = models.TextField()
    def __str__(self):
        return self.value

from django.contrib import admin 
admin.site.register(ListName)
admin.site.register(Column)
admin.site.register(ListRow)
admin.site.register(Cell)