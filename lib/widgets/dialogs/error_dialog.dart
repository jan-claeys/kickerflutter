import 'package:flutter/material.dart';

import '../../utils/kicker_exception.dart';

class ErrorDialog extends StatelessWidget{
  const ErrorDialog({
    super.key,
    required this.exception,
  });

  final KickerException exception;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Error"),
      content: Text(exception.message),
      actions: [
        TextButton(
          child: const Text("OK"),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}