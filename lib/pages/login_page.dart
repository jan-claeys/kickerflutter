import 'package:flutter/material.dart';
import 'package:kickerflutter/pages/home_page.dart';
import 'package:kickerflutter/pages/register_page.dart';
import 'package:kickerflutter/session.dart';
import 'package:email_validator/email_validator.dart';

import '../utils/kicker_exception.dart';
import '../widgets/dialogs/error_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Kicker',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Add padding to the body
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      throw KickerException(message: 'Please enter email');
                    }
                    if (!EmailValidator.validate(value)) {
                      throw KickerException(
                          message: 'Please enter a valid email');
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      throw KickerException(message: 'Please enter password');
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    try {
                      //validate the form
                      !_formKey.currentState!.validate();

                      Session()
                          .login(emailController.text, passwordController.text)
                          .then((value) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const HomePage()));
                      }).onError((KickerException exception, stackTrace) =>
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      ErrorDialog(exception: exception)));
                    } on KickerException catch (exception) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              ErrorDialog(exception: exception));
                    }
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
