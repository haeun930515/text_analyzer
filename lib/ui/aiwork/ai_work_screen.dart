import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_analyzer/provider/openai_provider.dart';
import 'package:text_analyzer/ui/result/result_screen.dart';

import '../../model/score_model.dart';

class AiWorkScreen extends StatefulWidget {
  const AiWorkScreen({super.key, required this.input});

  final String input;

  @override
  State<AiWorkScreen> createState() => _AiWorkScreenState();
}

//ScoreModel score = await openAIProvider
// .getText(textEditingController.text);
class _AiWorkScreenState extends State<AiWorkScreen> {
  late ScoreModel score;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    score = await OpenAIProvider().getText(widget.input);
  }

  @override
  Widget build(BuildContext context) {
    OpenAIProvider openAIProvider =
        Provider.of<OpenAIProvider>(context, listen: true);
    openAIProvider.getText(widget.input);
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
                                        sm: score,
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
