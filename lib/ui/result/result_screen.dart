import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_analyzer/model/score_model.dart';
import 'package:text_analyzer/provider/share_provider.dart';
import 'package:text_analyzer/provider/result_provider.dart';
import 'package:text_analyzer/ui/widgets/score_widget.dart';

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.sm});

  final ScoreModel sm;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late ResultProvider resultProvider;

  var globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    resultProvider = Provider.of<ResultProvider>(context, listen: false);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => {resultProvider.getResult(widget.sm)});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        //파란색 배경
        child: Container(
            decoration: const BoxDecoration(color: Color(0xFF2062f3)),
            child: Column(children: [
              const SizedBox(
                height: 120,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child:
                    Consumer<ResultProvider>(builder: (context, value, child) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                height: 130,
                                child: Image.asset(
                                  value.photo1,
                                  height: 300,
                                )),
                            SizedBox(
                                height: 130,
                                child: Image.asset(
                                  value.photo2,
                                  height: 300,
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        child: Text(
                          value.title,
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          value.sub,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              const SizedBox(height: 40),
              Container(
                height: 400,
                decoration: const BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                "기쁨",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 19),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "호기심",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 19),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "경계",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 19),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "분노",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 19),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "불안",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 19),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ScoreWidget(widget.sm.happiness),
                              const SizedBox(
                                height: 20,
                              ),
                              ScoreWidget(widget.sm.curiosity),
                              const SizedBox(
                                height: 20,
                              ),
                              ScoreWidget(widget.sm.anger),
                              const SizedBox(
                                height: 20,
                              ),
                              ScoreWidget(widget.sm.anxiety),
                              const SizedBox(
                                height: 20,
                              ),
                              ScoreWidget(widget.sm.vigilance)
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        child: const Text(
                          "우리의 티키타캉 공유하기",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //공유하기 버튼
                          ImageShareButton(
                            globalKey: globalKey,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    )
  }

  _capture() async {
    print("START CAPTURE");
    var path = "";
    var renderObject =
        globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    final image = await renderObject.toImage();
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final imageBytes = byteData?.buffer.asUint8List();

    if (imageBytes != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath =
          await File('${directory.path}/container_image.png').create();
      await imagePath.writeAsBytes(imageBytes);
      path = imagePath.path;
    }
    return path;
  }
}
