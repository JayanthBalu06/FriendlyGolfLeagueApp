import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/player.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000/golfPlayers/';

  Future<List<Player>> getPlayers() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      
      List<dynamic> body = json.decode(response.body);
      List<Player> players = body.map((dynamic player) => Player.fromJson(player)).toList();
      return players;
    } else {
     
      throw Exception('Failed to load items');
    }
  }

   Future<Player> createPlayers(String name, String score, String team) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'score': score,
        'team' : team
      }),
    );

    if (response.statusCode == 201) {
      return Player.fromJson(jsonDecode(response.body));
    } else {
      print('this is the status code' + (response.statusCode).toString());
      throw Exception('Failed to create item');
    }
  }
    Future<List<dynamic>> createMultiplePlayers(List<Player> players) async{
      final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(players.map((player) => player.toJson()).toList())
    );

    if (response.statusCode == 201) {
      List<dynamic> body = jsonDecode(response.body);
      List<Player> players = body.map((dynamic player) => Player.fromJson(player)).toList();
      return players;
    } else {
      print('this is the status code' + (response.statusCode).toString());
      throw Exception('Failed to create item');
    }
    }
}