import 'position.dart';

class Player {
  final String id;
  final String name;
  final int rating;
  final int attackRating;
  final int defendRating;

  const Player({
    required this.id,
    required this.name,
    required this.rating,
    required this.attackRating,
    required this.defendRating,
  });

   String getRanking(Position? rankingType) {
    if (rankingType == null) {
      return rating.toString();
    } else if (rankingType == Position.Attacker) {
      return attackRating.toString();
    } else if (rankingType == Position.Defender) {
      return defendRating.toString();
    }
    return rating.toString();
  }

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      name: json['name'],
      rating: json['rating'],
      attackRating: json['attackRating'],
      defendRating: json['defendRating'],
    );
  }

  @override
  String toString() {
    return name;
  }
}