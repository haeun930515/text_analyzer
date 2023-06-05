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
        Provider.of(context, listen: false);
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
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
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      const Row(
                        children: [
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              var str = await TextFromImageProvider()
                                  .getImageFromGallery();
                              if (str.isNotEmpty) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AiWorkScreen(
                                              input: str,
                                            )));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("발견된 채팅이 없어요!"),
                                ));

                                print("str is null");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shadowColor: Colors.black,
                                elevation: 20,
                                backgroundColor: const Color(0xFF2062f3),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16))),
                            child: const Column(
                              children: [
                                SizedBox(
                                  height: 90,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: Icon(
                                      Icons.add,
                                      size: 60,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 40),
                                Text(
                                  "대화붙여넣기",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 60,
                                )
                              ],
                            ),
                          ),
                        ],
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
      ),
    );
  }
}
