import 'package:shared_preferences/shared_preferences.dart';

import 'network.dart';

class Session {

  String? _token;

  static final Session _instance = Session._internal();

  factory Session() {
    return _instance;
  }

  Session._internal();

  Future<void> login(String email, String password) async {
    var token = await fetchToken(email, password);
    _token = token;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> logout() async {
    _token = null;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<String> readToken() async {
    if (_token != null) {
      return _token!;
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    return _token ?? "";
  }
}
