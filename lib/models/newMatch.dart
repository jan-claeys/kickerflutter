import 'player.dart';

enum Position { Attacker, Defender }

class NewMatch{
  final Position playerPosition;
  final Player ally;
  final Player opponentAttacker;
  final Player opponentDefender;
  final int playerScore;
  final int opponentScore;

  NewMatch({
    required this.playerPosition,
    required this.ally,
    required this.opponentAttacker,
    required this.opponentDefender,
    required this.playerScore,
    required this.opponentScore,
  });

  Map<String, dynamic> toJson() {
    return {
      'playerPosition': playerPosition.name,
      'allyId': ally.id,
      'opponentAttackerId': opponentAttacker.id,
      'opponentDefenderId': opponentDefender.id,
      'playerScore': playerScore,
      'opponentScore': opponentScore,
    };
  }
}