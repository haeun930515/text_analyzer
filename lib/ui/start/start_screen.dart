import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF2062f3),
          elevation: 0,
        ),
        backgroundColor: const Color(0xFF2062f3),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 100,
              ),
              const Center(
                child: Text(
                  "티키",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 65,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Center(
                child: Text(
                  "타카",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 65,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  "나의 대화 능력치는?",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 300),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/input');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "시작하기",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2062f3),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
