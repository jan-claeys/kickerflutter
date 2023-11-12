import 'package:flutter/material.dart';

import '../models/Postition.dart';
import '../models/player.dart';
import '../network.dart';
import 'playerTile.dart';

// Base class for the ranking pages.
class RankingList extends StatefulWidget {
  const RankingList({
    super.key,
    required this.orderBy,
    });
  
  final Position? orderBy;

  @override
  State<RankingList> createState() => _RankingListState();
}

class _RankingListState extends State<RankingList> {

  final List<Player> _players = [];
  bool _isLoading = true;
  bool _hasMore = true;
  int pageNumber = 1;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _hasMore = true;
    _loadMorePlayers();
  }

  void _loadMorePlayers() {
    _isLoading = true;

    fetchRanking(widget.orderBy, pageNumber: pageNumber).then((players) {
      if (players.isEmpty) {
        setState(() {
          _hasMore = false;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          pageNumber++;
          _players.addAll(players);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _hasMore ? _players.length + 1 : _players.length,
      itemBuilder: (context, index) {

        if (index >= _players.length) {
          // Don't trigger if one async loading is already under way
          if (!_isLoading) {
            _loadMorePlayers();
          }

          return const Center(
            child: SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(),
            ),
          );
        }

        final Player player = _players[index];
        return PlayerTile(player: player, rankingType: widget.orderBy, index: index,);
      },
    );
  }
}