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

   String getRanking(rankingType) {
    if (rankingType == "") {
      return rating.toString();
    } else if (rankingType == "AttackRating") {
      return attackRating.toString();
    } else if (rankingType == "DefendRating") {
      return defendRating.toString();
    } else {
      throw Exception("Invalid ranking type");
    }
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
}