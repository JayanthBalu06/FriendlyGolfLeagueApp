from django.db import models

class Drink(models.Model):

    name = models.CharField(max_length = 200)
    score = models.CharField(max_length = 200)
    team = models.CharField(max_length=200, default= "No Team")
    
   
 