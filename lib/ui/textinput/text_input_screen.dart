import 'package:flutter/material.dart';

class TextInputScreen extends StatelessWidget {
  const TextInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      "나의",
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
                      height: 80,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: ElevatedButton(
                        onPressed: () {
                          //이미지 피커 function to do
                          Navigator.pushNamed(context, '/ing');
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2062f3),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 120,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Container(
                                height: 50,
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "대화 붙여넣기",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 100,
                            )
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 80),
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
                                  builder: (context) => Dialog(
                                        child: PageView(
                                          children: <Widget>[
                                            Container(
                                              color: Colors.red,
                                            ),
                                            Container(
                                              color: Colors.amber,
                                            )
                                          ],
                                        ),
                                      ));
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
