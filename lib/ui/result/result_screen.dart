import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_analyzer/model/score_model.dart';
import 'package:text_analyzer/provider/facebook_provider.dart';
import 'package:text_analyzer/provider/instar_provider.dart';
import 'package:text_analyzer/provider/kakao_provider.dart';
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
            RepaintBoundary(
              key: globalKey,
              child: Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: Consumer<ResultProvider>(
                          builder: (context, value, child) {
                        return Column(
                          children: [
                            //사진
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                            //ㅇㅇ vs ㅇㅇ
                            Container(
                              child: Text(
                                value.title,
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            //설명
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
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
                  ),
                  const SizedBox(height: 40),
                  Container(
                    height: 280,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          //점수 파트
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Text(
                                    "기쁨",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "호기심",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "경계",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "분노",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "불안",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19),
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //공유 부분
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    child: const Text(
                      "우리의 티키타캉 공유하기",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //카카오 공유하기 버튼
                      TextButton(
                        onPressed: () async {
                          var imagePath = await _capture();
                          KakaoShareProvider kakaoShareProvider =
                              Provider.of<KakaoShareProvider>(context,
                                  listen: false);
                          kakaoShareProvider.kakaoShare(context, imagePath);
                        },
                        child: const Text("카카오"),
                      ),
                      // 인스타 공유하기 버튼
                      InstarShareButton(
                        text: '인스타',
                        globalKey: globalKey,
                      ),
                      // 페이스북 공유하기 버튼
                      FacebookShareButton(
                        text: '페이스북',
                        globalKey: globalKey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
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
