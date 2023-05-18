import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_analyzer/provider/openai_provider.dart';
import 'package:text_analyzer/ui/result/result_screen.dart';

class AiWorkScreen extends StatefulWidget {
  const AiWorkScreen({super.key, required this.input});

  final String input;

  @override
  State<AiWorkScreen> createState() => _AiWorkScreenState();
}

class _AiWorkScreenState extends State<AiWorkScreen> {
  late OpenAIProvider openAIProvider;
  @override
  void didChangeDependencies() {
    openAIProvider = Provider.of<OpenAIProvider>(context);
    openAIProvider.getText(widget.input);
  }

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
        Consumer<OpenAIProvider>(builder: (context, provider, child) {
          return Text(
            provider.isFinished ? "완료" : "ing",
            style: const TextStyle(
                color: Color(0xFFfed756),
                fontSize: 40,
                fontWeight: FontWeight.bold),
          );
        }),
        const SizedBox(height: 70),
        Image.asset(
          'assets/images/load_complete1.png',
          height: 300,
        ),
        const SizedBox(
          height: 40,
        ),
        Consumer<OpenAIProvider>(
          builder: (context, provider, child) {
            return provider.isFinished
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            )),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResultScreen(
                                        sm: provider.scoreModel,
                                      )));
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
                  )
                : const SizedBox(
                    height: 0,
                  );
          },
        ),
      ]),
    );
  }
}
