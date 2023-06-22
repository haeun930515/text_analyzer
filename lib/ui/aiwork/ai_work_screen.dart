import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ironsource_mediation/ironsource_mediation.dart';
import 'package:provider/provider.dart';
import 'package:text_analyzer/provider/openai_provider.dart';
import 'package:text_analyzer/utils/strings.dart';
import '../result/result_screen.dart';

class AiWorkScreen extends StatefulWidget {
  const AiWorkScreen({super.key, required this.input});

  final String input;

  @override
  State<AiWorkScreen> createState() => _AiWorkScreenState();
}

class _AiWorkScreenState extends State<AiWorkScreen> {
  late OpenAIProvider openAIProvider;

  @override
  void initState() {
    super.initState();
    IronSource.loadBanner(
        size: IronSourceBannerSize.RECTANGLE,
        position: IronSourceBannerPosition.Top,
        verticalOffset: 1000);
    IronSource.displayBanner();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(const Duration(seconds: 3), () {
      openAIProvider = Provider.of<OpenAIProvider>(context, listen: false);
      openAIProvider.getText(widget.input);
    });
  }

  @override
  void dispose() {
    openAIProvider.finished = false;
    super.dispose();
    IronSource.destroyBanner();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Platform.isAndroid) {
          IronSource.hideBanner();
          showDialog(
              context: context,
              builder: (context) => Dialog(
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "앱을 종료할까요?",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Image.asset(
                              Strings.picAIWork,
                              height: 50,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MaterialButton(
                                    onPressed: () {
                                      IronSource.destroyBanner();
                                      SystemNavigator.pop();
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    color: const Color(0xFF2062f3),
                                    child: const Text(
                                      "종료하기",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      IronSource.displayBanner();
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    color: Colors.grey[400],
                                    child: const Text(
                                      "취소",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
          return false;
        } else {
          return false;
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFF2062f3),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "티키",
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  "타카",
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
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
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Strings.picAIWork,
                      height: 80,
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 230,
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    )),
                                onPressed: () {
                                  IronSource.destroyBanner();
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
        ),
      ),
    );
  }
}
