import 'dart:async';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:text_analyzer/model/score_model.dart';
import 'package:text_analyzer/provider/kakao_provider.dart';
import 'package:text_analyzer/provider/result_provider.dart';
import 'package:text_analyzer/provider/share_provider.dart';
import 'package:text_analyzer/ui/widgets/score_widget.dart';

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:text_analyzer/utils/loading_indicator.dart';
import 'package:text_analyzer/utils/strings.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.sm});

  final ScoreModel sm;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late ResultProvider resultProvider;

  var globalKey = GlobalKey();
  var imageUrl = "";
  var imagePath = "";

  bool _isLoading = false;

  String generateRandomString(int length) {
    final random = Random();
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    String result = '';

    for (int i = 0; i < length; i++) {
      result += chars[random.nextInt(chars.length)];
    }

    return result;
  }

  _onBackPressed() {
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
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                              onPressed: () {
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
  }

  Future<String> capture(GlobalKey globalKey) async {
    print("START CAPTURE");
    _isLoading = true;
    LoadingIndicator(context);
    Completer<String> completer = Completer<String>();
    try {
      var renderObject = globalKey.currentContext?.findRenderObject();
      if (renderObject is RenderRepaintBoundary) {
        var boundary = renderObject;
        ui.Image image = await boundary.toImage(pixelRatio: 2.0);
        final directory = await getTemporaryDirectory();
        String randomName = generateRandomString(10);
        imagePath = '${directory.path}/$randomName.png';
        File imgFile = File(imagePath);
        Uint8List? pngBytes = await image
            .toByteData(format: ui.ImageByteFormat.png)
            .then((byteData) => byteData?.buffer.asUint8List());
        await imgFile.writeAsBytes(pngBytes!);

        FirebaseStorage firebaseStorage = FirebaseStorage.instance;
        Reference ref = firebaseStorage.ref("images").child('$randomName.jpg');
        await ref.putFile(imgFile);

        print("FINISH CAPTURE $imagePath");
        print(ref.getDownloadURL());
        completer.complete(imagePath);
        _isLoading = false;

        return ref.getDownloadURL();
      } else {
        completer.completeError("Could not capture the image.");
        _isLoading = false;
        return "";
      }
    } catch (error) {
      completer.completeError("Error capturing the image: $error");
      _isLoading = false;
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    resultProvider = Provider.of<ResultProvider>(context, listen: false);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => resultProvider.getResult(widget.sm));
  }

  final GlobalKey genKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    ImageShareProvider imageShareProvider =
        Provider.of<ImageShareProvider>(context, listen: false);

    var body = SingleChildScrollView(
      //파란색 배경
      child: Container(
        decoration: const BoxDecoration(color: Color(0xFF2062f3)),
        child: Column(children: [
          RepaintBoundary(
            key: globalKey,
            child: Column(
              children: [
                Container(
                  color: const Color(0xFF2062f3),
                  child: Consumer<ResultProvider>(
                      builder: (context, value, child) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        //설명
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 55.0),
                          child: Text(
                            value.sub,
                            style: const TextStyle(
                                fontSize: 26,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        //사진
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                    height: 130,
                                    child: Image.asset(
                                      value.photo1,
                                      height: 300,
                                    )),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: Text(
                                    value.title1,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                    height: 130,
                                    child: Image.asset(
                                      value.photo2,
                                      height: 300,
                                    )),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: Text(
                                    value.title2,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Consumer<ResultProvider>(
                          builder: (context, value, child) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 55.0),
                              child: Text(value.main,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            );
                          },
                        ),

                        const SizedBox(height: 10),
                      ],
                    );
                  }),
                ),
                //점수
                //상세설명
                const SizedBox(
                  height: 10,
                ),
                //점수 하얀 부분
                Container(
                  height: 270,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                    children: [
                      const SizedBox(height: 26),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  "기쁨",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                ),
                                SizedBox(
                                  height: 17,
                                ),
                                Text(
                                  "호기심",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                ),
                                SizedBox(
                                  height: 17,
                                ),
                                Text(
                                  "경계",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                ),
                                SizedBox(
                                  height: 17,
                                ),
                                Text(
                                  "분노",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                ),
                                SizedBox(
                                  height: 17,
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
                                  height: 10,
                                ),
                                ScoreWidget(widget.sm.curiosity),
                                const SizedBox(
                                  height: 10,
                                ),
                                ScoreWidget(widget.sm.vigilance),
                                const SizedBox(
                                  height: 10,
                                ),
                                ScoreWidget(widget.sm.anger),
                                const SizedBox(
                                  height: 10,
                                ),
                                ScoreWidget(widget.sm.anxiety)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //공유하기 버튼
                    Column(
                      children: [
                        Container(
                          child: const Text(
                            "공유하기",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                imageUrl = await capture(globalKey);
                                Navigator.of(context).pop();
                                KakaoShareProvider()
                                    .kakaoShare(context, imageUrl);
                              },
                              child: KakaoShareButton(
                                text: "카카오톡공유",
                                imageUrl: imageUrl,
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                imageUrl = await capture(globalKey);

                                Navigator.of(context).pop();
                                imageShareProvider.imageShare(imagePath);
                              },
                              child: ImageShareButton(
                                globalKey: globalKey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          child: const Text(
                            "홈으로",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
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
                                              "처음 화면으로 돌아갈까요?",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
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
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 18.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  MaterialButton(
                                                    onPressed: () {
                                                      Navigator.popUntil(
                                                          context,
                                                          ModalRoute.withName(
                                                              '/'));
                                                    },
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4)),
                                                    color:
                                                        const Color(0xFF2062f3),
                                                    child: const Text(
                                                      "돌아가기",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  MaterialButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4)),
                                                    color: Colors.grey[400],
                                                    child: const Text(
                                                      "취소",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                  );
                                });
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(
                              Icons.home,
                              size: 40,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: 50,
          ),
          //공유
        ]),
      ),
    );

    return WillPopScope(
      onWillPop: _onBackPressed(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: body,
      ),
    );
  }
}
