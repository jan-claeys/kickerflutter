import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kickerflutter/models/Postition.dart';
import 'package:kickerflutter/models/newMatch.dart';

import 'models/player.dart';
import 'models/match.dart';

const String token =
    "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImI5NWZiZjNmLTMwNDAtNDUzOC05MjYxLTk4Y2M4ZDhjN2ZjOCIsImV4cCI6MTczMDM4MDI3NSwiaXNzIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NzE1Ni8iLCJhdWQiOiJodHRwczovL2xvY2FsaG9zdDo3MTU2LyJ9.B-vYDvHA35iQLYNmTkzdSviXOvXx6IHT2ryKhCWRT9Y";
const String baseUrl = "http://localhost:5277";

Future<List<Player>> fetchRanking(Position? orderBy, {int pageNumber = 1}) async {
  String url = '$baseUrl/Players/ranking?PageNumber=$pageNumber';

  if (orderBy != null) {
    url += '&OrderBy=${orderBy.name}';
  }

  final response = await http.get(
    Uri.parse(
        '$url'),
    headers: {
      HttpHeaders.authorizationHeader: token,
    },
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to load ranking');
  }

  final List body = jsonDecode(response.body);

  final List<Player> players =
      body.map((dynamic item) => Player.fromJson(item)).toList();

  return players;
}

Future<List<Player>> fetchPlayers(String search, {int pageNumber = 1}) async {
  final response = await http.get(
    Uri.parse(
        '$baseUrl/Players?Search=$search&PageNumber=$pageNumber&PageSize=6'),
    headers: {
      HttpHeaders.authorizationHeader: token,
    },
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to load players');
  }
  final List body = jsonDecode(response.body);

  final List<Player> players =
      body.map((dynamic item) => Player.fromJson(item)).toList();

  return players;
}

Future<List<Match>> fetchHistory(Position position, {int pageNumber = 1}) async {
  final response = await http.get(
    Uri.parse(
        '$baseUrl/Matches?PlayerPosition=${position.name}&PageNumber=$pageNumber'),
    headers: {
      HttpHeaders.authorizationHeader: token,
    },
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to load history');
  }

  final List body = jsonDecode(response.body);

  final List<Match> matches =
      body.map((dynamic item) => Match.fromJson(item)).toList();

  return matches;
}

Future<List<Match>> fetchToReview({int pageNumber = 1}) async {
  final response = await http.get(
    Uri.parse(
        '$baseUrl/Matches/toreview?PageNumber=$pageNumber'),
    headers: {
      HttpHeaders.authorizationHeader: token,
    },
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to load toreview');
  }

  final List body = jsonDecode(response.body);

  final List<Match> matches =
      body.map((dynamic item) => Match.fromJson(item)).toList();

  return matches;
}

Future<http.Response> createMatch(NewMatch match) async {
  final response = await http.post(
    Uri.parse('$baseUrl/Matches'),
    headers: {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.contentTypeHeader: "application/json",
    },
    body: jsonEncode(match.toJson()),
  );

  if (response.statusCode != 200) {
    throw Exception(response.body);
  }

  return response;
}
