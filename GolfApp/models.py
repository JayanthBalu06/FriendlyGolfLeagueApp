from django.db import models

class GolfPlayer(models.Model):

    name = models.CharField(max_length = 200)
    score = models.CharField(max_length = 200)
    team = models.CharField(max_length= 200)
 