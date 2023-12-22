import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kickerflutter/models/position.dart';
import 'package:kickerflutter/models/newMatch.dart';
import 'package:kickerflutter/session.dart';
import 'package:kickerflutter/utils/kicker_exception.dart';

import 'models/player.dart';
import 'models/match.dart';

const String baseUrl = "http://localhost:5277";

Future register(String name, String email, String password) async {
  final response = await http.post(
    Uri.parse('$baseUrl/security/register'),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    },
    body: jsonEncode({
      'name': name,
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode != 200) {
    throw KickerException(title: "Failed to register", message: response.body);
  }
}

Future fetchToken(String email, String password) async {
  final response = await http.post(
    Uri.parse('$baseUrl/security/login'),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    },
    body: jsonEncode({
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode != 200) {
    throw KickerException(title: "Cannot authenticate", message: response.body);
  }

  final body = jsonDecode(response.body);
  return body['token'];
}

Future<List<Player>> fetchRanking(Position? orderBy,
    {int pageNumber = 1}) async {
  String url = '$baseUrl/Players/ranking?PageNumber=$pageNumber';

  if (orderBy != null) {
    url += '&OrderBy=${orderBy.name}';
  }

  final response = await http.get(
    Uri.parse(url),
    headers: {
      HttpHeaders.authorizationHeader: "Bearer ${await Session().readToken()}",
    },
  );

  if (response.statusCode != 200) {
    throw KickerException(
        title: 'Failed to load ranking', message: response.body);
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
      HttpHeaders.authorizationHeader: "Bearer ${await Session().readToken()}",
    },
  );

  if (response.statusCode != 200) {
    throw KickerException(
        title: 'Failed to load players', message: response.body);
  }
  final List body = jsonDecode(response.body);

  final List<Player> players =
      body.map((dynamic item) => Player.fromJson(item)).toList();

  return players;
}

Future<List<Match>> fetchHistory(Position position,
    {int pageNumber = 1}) async {
  final response = await http.get(
    Uri.parse(
        '$baseUrl/Matches?PlayerPosition=${position.name}&PageNumber=$pageNumber'),
    headers: {
      HttpHeaders.authorizationHeader: "Bearer ${await Session().readToken()}",
    },
  );

  if (response.statusCode != 200) {
    throw KickerException(
        title: 'Failed to load history', message: response.body);
  }

  final List body = jsonDecode(response.body);

  final List<Match> matches =
      body.map((dynamic item) => Match.fromJson(item)).toList();

  return matches;
}

Future<List<Match>> fetchToReview({int pageNumber = 1}) async {
  final response = await http.get(
    Uri.parse('$baseUrl/Matches/toreview?PageNumber=$pageNumber'),
    headers: {
      HttpHeaders.authorizationHeader: "Bearer ${await Session().readToken()}",
    },
  );

  if (response.statusCode != 200) {
    throw KickerException(
        title: 'Failed to load toreview', message: response.body);
  }

  final List body = jsonDecode(response.body);

  final List<Match> matches =
      body.map((dynamic item) => Match.fromJson(item)).toList();

  return matches;
}

Future<List<Match>> fetchUnderReview({int pageNumber = 1}) async {
  final response = await http.get(
    Uri.parse('$baseUrl/Matches/underreview?PageNumber=$pageNumber'),
    headers: {
      HttpHeaders.authorizationHeader: "Bearer ${await Session().readToken()}",
    },
  );

  if (response.statusCode != 200) {
    throw KickerException(
        title: 'Failed to load underreview', message: response.body);
  }

  final List body = jsonDecode(response.body);

  final List<Match> matches =
      body.map((dynamic item) => Match.fromJson(item)).toList();

  return matches;
}

Future<int> fetchToReviewCount() async {
  final response = await http.get(
    Uri.parse('$baseUrl/Matches/toreviewcount'),
    headers: {
      HttpHeaders.authorizationHeader: "Bearer ${await Session().readToken()}",
    },
  );

  if (response.statusCode != 200) {
    throw KickerException(
        title: 'Failed to load toreview count', message: response.body);
  }

  return int.parse(response.body);
}

Future<http.Response> createMatch(NewMatch match) async {
  final response = await http.post(
    Uri.parse('$baseUrl/Matches'),
    headers: {
      HttpHeaders.authorizationHeader: "Bearer ${await Session().readToken()}",
      HttpHeaders.contentTypeHeader: "application/json",
    },
    body: jsonEncode(match.toJson()),
  );

  if (response.statusCode != 200) {
    throw KickerException(
        title: 'Failed to create match', message: response.body);
  }

  return response;
}

Future<http.Response> confirmTeam(int teamId) async {
  final response = await http.put(
    Uri.parse('$baseUrl/teams/$teamId/confirm'),
    headers: {
      HttpHeaders.authorizationHeader: "Bearer ${await Session().readToken()}",
      HttpHeaders.contentTypeHeader: "application/json"
    },
  );

  if (response.statusCode != 200) {
    throw KickerException(
        title: "Failed to confirm team", message: response.body);
  }

  return response;
}

Future<http.Response> denyTeam(int teamId) async {
  final response = await http.delete(
    Uri.parse('$baseUrl/teams/$teamId/deny'),
    headers: {
      HttpHeaders.authorizationHeader: "Bearer ${await Session().readToken()}",
      HttpHeaders.contentTypeHeader: "application/json"
    },
  );

  if (response.statusCode != 200) {
    throw KickerException(title: "Failed to deny team", message: response.body);
  }

  return response;
}

Future<Player> fetchCurrentPlayer() async {
  final response = await http.get(
    Uri.parse('$baseUrl/Players/current'),
    headers: {
      HttpHeaders.authorizationHeader: "Bearer ${await Session().readToken()}",
    },
  );

  if (response.statusCode != 200) {
    throw KickerException(
        title: 'Failed to load player', message: response.body);
  }

  final body = jsonDecode(response.body);

  return Player.fromJson(body);
}
