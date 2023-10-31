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