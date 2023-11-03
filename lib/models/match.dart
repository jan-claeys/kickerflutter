
class Match {
  final int id;
  final DateTime date;
  final Team playerTeam;
  final Team opponentTeam;
  final bool isCalculatedInRating;

  Match(
      {required this.id,
      required this.date,
      required this.playerTeam,
      required this.opponentTeam,
      required this.isCalculatedInRating});

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'],
      date: DateTime.parse(json['date']),
      isCalculatedInRating: json['isCalculatedInRating'],
      playerTeam: Team(
        id: json['playerTeam']['id'],
        score: json['playerTeam']['score'],
        attacker: PlayerSmall(
          id: json['playerTeam']['attacker']['id'],
          name: json['playerTeam']['attacker']['name'],
          ),
        defender: PlayerSmall(
          id: json['playerTeam']['defender']['id'],
          name: json['playerTeam']['defender']['name'],
          )
      ),
      opponentTeam: Team(
        id: json['opponentTeam']['id'],
        score: json['opponentTeam']['score'],
        attacker: PlayerSmall(
          id: json['opponentTeam']['attacker']['id'],
          name: json['opponentTeam']['attacker']['name'],
          ),
        defender: PlayerSmall(
          id: json['opponentTeam']['defender']['id'],
          name: json['opponentTeam']['defender']['name'],
          ),
      ),
    );
  }
}

class Team {
  final int id;
  final PlayerSmall attacker;
  final PlayerSmall defender;
  final int score;

  Team({required this.id, required this.attacker, required this.defender, required this.score});
}

class PlayerSmall {
  final String id;
  final String name;

  PlayerSmall({required this.id, required this.name});
}
