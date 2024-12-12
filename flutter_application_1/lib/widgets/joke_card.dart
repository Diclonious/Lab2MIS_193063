import 'package:flutter/material.dart';
import '../models/joke_type.dart';

class JokeCard extends StatelessWidget {
  final JokeType type;
  final VoidCallback onTap;

  const JokeCard({required this.type, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(type.type, style: TextStyle(fontSize: 18)),
        onTap: onTap,
      ),
    );
  }
}
