import 'package:flutter/material.dart';

class AiWorkScreen extends StatelessWidget {
  const AiWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2062f3),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(height: 180),
        const Text(
          "티키",
          style: TextStyle(
              fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const Text(
          "타카",
          style: TextStyle(
              fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ]),
    );
  }
}
