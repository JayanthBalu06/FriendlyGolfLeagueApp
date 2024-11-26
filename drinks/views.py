from django.http import JsonResponse
from .models import Drink
from .serializers import PlayerSerializer
from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import api_view
from django.shortcuts import redirect
import logging

logger = logging.getLogger(__name__)
@api_view(['GET','POST'])
def golfPlayer_list(request):
    if request.method == 'GET':
        golfPlayers = Drink.objects.all()
        print("DEBUG TEXT:")
        print("END DEBUG")
        serializer = PlayerSerializer(golfPlayers, many= True)
        return JsonResponse(serializer.data,safe=False)
    
    if request.method == 'POST':
        if isinstance(request.data, list):
            serializer = PlayerSerializer(data=request.data, many=True)
        else:
            serializer = PlayerSerializer(data=[request.data], many=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status = status.HTTP_201_CREATED)
        logger.error('Invalid data: %s', serializer.errors)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
@api_view(['GET','PUT','DELETE'])
def golfPlayer_detail(request,id):
    try:
        drink = Drink.objects.get(pk=id)
    except Drink.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)
    
    if request.method == "GET":
        serializer  = PlayerSerializer(drink)
        return Response(serializer.data)
    if request.method == "PUT":
        serializer = PlayerSerializer(drink, data = request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status =status.HTTP_400_BAD_REQUEST)
    if request.method == "DELETE":
        drink.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
    
def redirect_view(request):
    response = redirect('/golfPlayers')
    return response