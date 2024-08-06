from rest_framework import serializers
from .models import GolfPlayer

class DrinkSerializer(serializers.ModelSerializer):
    class Meta:
        model = GolfPlayer
        fields = ['id','name', 'score','team']