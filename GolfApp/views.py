from django.http import JsonResponse
from .models import GolfPlayer
from .serializers import DrinkSerializer
from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import api_view
from django.shortcuts import redirect
import logging

logger = logging.getLogger(__name__)
@api_view(['GET','POST'])
def golfPlayer_list(request):
    if request.method == 'GET':
        golfPlayers = GolfPlayer.objects.all()
        print("DEBUG TEXT:")
        print(drinks)
        print("END DEBUG")
        serializer = DrinkSerializer(golfPlayers, many= True)
        return JsonResponse(serializer.data,safe=False)
    
    if request.method == 'POST':
        if isinstance(request.data, list):
            serializer = DrinkSerializer(data=request.data, many=True)
        else:
            serializer = DrinkSerializer(data=[request.data], many=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status = status.HTTP_201_CREATED)
        logger.error('Invalid data: %s', serializer.errors)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
@api_view(['GET','PUT','DELETE'])
def golfPlayer_detail(request,id):
    try:
        drink = GolfPlayer.objects.get(pk=id)
    except GolfPlayer.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)
    
    if request.method == "GET":
        serializer  = DrinkSerializer(drink)
        return Response(serializer.data)
    if request.method == "PUT":
        serializer = DrinkSerializer(drink, data = request.data)
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