import 'package:flutter/material.dart';

class LeadingCircle extends StatelessWidget {
  const LeadingCircle({
    super.key,
    required this.number,
  });

  final int number;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text((number).toString()),
    );
  }
}