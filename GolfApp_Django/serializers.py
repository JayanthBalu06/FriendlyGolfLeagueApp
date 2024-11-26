from rest_framework import serializers
from .models import Drink

class PlayerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Drink
        fields = ['id','name', 'score', 'team']