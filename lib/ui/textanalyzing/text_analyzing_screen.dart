import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_analyzer/provider/openai_provider.dart';

import '../dialog/help_dialog.dart';

class TextAnalyzingScreen extends StatelessWidget {
  const TextAnalyzingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OpenAIProvider openAIProvider =
        Provider.of<OpenAIProvider>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 170,
            ),
            Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "우리의",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: const [
                        Text(
                          "티키타캉은?",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "😚",
                          style: TextStyle(fontSize: 40),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        maxLines: 8,
                        maxLength: 500,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 80),
                        Container(),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2062f3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                )),
                            onPressed: () {
                              openAIProvider.getText("안녕하세용");
                              Navigator.pushNamed(context, '/ai');
                            },
                            child: const Center(
                              child: Text(
                                "다 입력 했어요",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                    width: 1.2, color: Color(0xFF2062f3)),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                )),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => const HelpDialog());
                            },
                            child: const Center(
                              child: Text(
                                "도움이 필요해요👉",
                                style: TextStyle(
                                    color: Color(0xFF2062f3),
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ],
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
