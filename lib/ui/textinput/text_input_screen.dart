import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_analyzer/provider/text_from_image_provider.dart';
import 'package:text_analyzer/ui/aiwork/ai_work_screen.dart';
import 'package:text_analyzer/ui/dialog/help_dialog.dart';

class TextInputScreen extends StatelessWidget {
  const TextInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextFromImageProvider textFromImageProvider =
        Provider.of<TextFromImageProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 140,
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
                          "티키타카력은?",
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
                      height: 70,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: ElevatedButton(
                        onPressed: () async {
                          //이미지 피커 function to do
                          var str = await TextFromImageProvider()
                              .getImageFromGallery();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AiWorkScreen(
                                        input: str,
                                      )));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2062f3),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                        child: Column(
                          children: const [
                            SizedBox(
                              height: 90,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: SizedBox(
                                height: 50,
                                width: 100,
                                child: Icon(
                                  Icons.textsms,
                                  size: 50,
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            Text(
                              "대화 붙여넣기",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 100,
                            )
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 70),
                        Container(),
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
