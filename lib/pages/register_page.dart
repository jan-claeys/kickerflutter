import 'package:flutter/material.dart';
import 'package:kickerflutter/pages/login_page.dart';
import 'package:kickerflutter/utils/kicker_exception.dart';

import '../network.dart';
import '../session.dart';
import '../widgets/dialogs/error_dialog.dart';
import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              controller: nameController,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              controller: passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password confirmation',
              ),
              controller: passwordConfirmationController,
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (passwordController.text !=
                    passwordConfirmationController.text) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ErrorDialog(
                          exception: KickerException("Passwords do not match"));
                    },
                  );
                  return;
                }

                register(nameController.text, passwordController.text)
                    .then((value) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const LoginPage()));
                }).onError((KickerException exception, stackTrace) => showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            ErrorDialog(exception: exception)));
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
