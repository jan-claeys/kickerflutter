import 'dart:io';
import 'dart:convert';

import 'player.dart';
import 'package:http/http.dart' as http;

Future<List<Player>> fetchOveralRanking() async {
  const String token =
      "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImI5NWZiZjNmLTMwNDAtNDUzOC05MjYxLTk4Y2M4ZDhjN2ZjOCIsImV4cCI6MTczMDM4MDI3NSwiaXNzIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NzE1Ni8iLCJhdWQiOiJodHRwczovL2xvY2FsaG9zdDo3MTU2LyJ9.B-vYDvHA35iQLYNmTkzdSviXOvXx6IHT2ryKhCWRT9Y";
  final response = await http.get(
    Uri.parse('https://localhost:7023/Players/ranking'),
    headers: {
      HttpHeaders.authorizationHeader: token,
    },
  );

  if (response.statusCode == 200) {
    final List body = jsonDecode(response.body);

    final List<Player> players =
        body.map((dynamic item) => Player.fromJson(item)).toList();

    return players;
  } else {
    throw Exception('Failed to load player');
  }
}
