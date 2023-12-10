import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget{
  const ErrorDialog({
    super.key,
    required this.exeption
  });

  final Exception exeption;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Error"),
      content: Text(exeption.toString().replaceFirst("Exception:", "")),
      actions: [
        TextButton(
          child: const Text("OK"),
          //FIXME: gives error when pressing ok button in error dialog on login page if password is wrong
          onPressed: () => Navigator.of(context).pop(true),
        )
      ],
    );
  }
}