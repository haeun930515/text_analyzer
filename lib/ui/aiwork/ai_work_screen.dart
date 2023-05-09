import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_analyzer/provider/openai_provider.dart';

class AiWorkScreen extends StatelessWidget {
  const AiWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OpenAIProvider openAIProvider = Provider.of<OpenAIProvider>(context);
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
        Consumer<OpenAIProvider>(builder: (context, provider, child) {
          print(provider.finished.toString());
          return Text(
            provider.isFinished ? "완료" : "ing",
            style: const TextStyle(
                color: Color(0xFFfed756),
                fontSize: 40,
                fontWeight: FontWeight.bold),
          );
        }),
        const SizedBox(
          height: 300,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
              onPressed: () {
                Navigator.pushNamed(context, '/result');
              },
              child: const Center(
                child: Text(
                  "나의 능력치는?",
                  style: TextStyle(
                      color: Color(0xFF2062f3),
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              )),
        ),
      ]),
    );
  }
}
