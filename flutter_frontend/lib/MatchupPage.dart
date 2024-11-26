import 'package:flutter/material.dart';
import 'dart:math';
import  'models/player.dart';

class MatchupPage extends StatelessWidget {
  final List<Player> players;

  MatchupPage({required this.players});

  @override
  Widget build(BuildContext context) {
    // Group players by teams
    Map<String, List<Player>> groupedTeams = {};
    for (var player in players) {
     // print("Player :" + player.name);
        //print("Team :" + player.name);
        //print("Score :" + player.score);
      if (!groupedTeams.containsKey(player.team)) {
        groupedTeams[player.team] = [];
        
      }
      groupedTeams[player.team]!.add(player);
    }

    // Generate random matchups
    List<Map<String, List<Player>>> matchups = [];
    List<String> teamNames = groupedTeams.keys.toList();
    


      
    List<Player>? team1 = groupedTeams[teamNames[0]];
    List<Player>? team2 = groupedTeams[teamNames[1]];

    print(team2?[0].name);
    print(team2?[1].name);
    print(team2?[2].name);
    print(team2?[3].name);

    for (int i = 0; i < teamNames.length; i += 2) {
      if (i + 1 < teamNames.length) {
        String team1Name = teamNames[i];
        String team2Name = teamNames[i + 1];
        List<Player> team1Players = groupedTeams[team1Name]!;
        List<Player> team2Players = groupedTeams[team2Name]!;
        team1Players.shuffle(Random());
        team2Players.shuffle(Random());

        matchups.add({
          "Team 1": team1Players.take(2).toList(), // Pick 2 players from team
          "Team 2": team2Players.take(2).toList(),
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Matchups"),
      ),
      body: matchups.isNotEmpty
          ? ListView.builder(
              itemCount: matchups.length,
              itemBuilder: (context, index) {
                Map<String, List<Player>> matchup = matchups[index];
                List<Player> team1 = matchup["Team 1"]!;
                List<Player> team2 = matchup["Team 2"]!;

                return Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Text(
                          "Matchup ${index + 1}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Team 1 Column
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: team1.map((player) {
                                  return Text(
                                    "${player.name} (Score: ${player.score})",
                                    style: TextStyle(fontSize: 16),
                                  );
                                }).toList(),
                              ),
                            ),
                            // VS Text
                            Text(
                              "VS",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            // Team 2 Column
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: team2.map((player) {
                                  return Text(
                                    "${player.name} (Score: ${player.score})",
                                    style: TextStyle(fontSize: 16),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                "Not enough players for matchups.",
                style: TextStyle(fontSize: 18),
              ),
            ),
    );
  }
}
