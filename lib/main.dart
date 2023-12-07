import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kickerflutter/session.dart';

import 'pages/loading_page.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const seedColor = Color(0xFF1e1e85);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
        useMaterial3: true,
      ),
      home: FutureBuilder<String?>(
        future: Session().readToken(),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == "") {
              return const LoginPage();
            }
            return const HomePage();
          } else {
            return const LoadingPage();
          }
        },
      ),
    );
  }
}
