class Player {
  final String name;
  final String score;
  final String team;
  Player({ required this.name, required this.score, required this.team});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      name: json['name'],
      score:  json['score'],
      team: json['team']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'score': score,
      'team': team,
    };
  }
}
