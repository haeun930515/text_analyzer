import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
    KakaoShareProvider kakaoProvider =
        Provider.of<KakaoShareProvider>(context, listen: false);
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: Consumer<ResultProvider>(
                        builder: (context, value, child) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 140,
                          ),
                          //사진
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            height: 20,
                          ),
                          // ㅇㅇ vs ㅇㅇ
                          Container(
                            child: Text(
                              value.title,
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          //설명
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Text(
                              value.sub,
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                //점수
              ],
            ),
          ),
          Consumer<ResultProvider>(
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(value.main,
                    style: const TextStyle(fontSize: 16, color: Colors.white)),
              );
            },
          ),

          const SizedBox(height: 30),
          Container(
            height: 280,
            decoration: const BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  //점수
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
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
                ],
              ),
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
                            "우리의 티키타캉 공유하기",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
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
                    Column(
                      children: [
                        Container(
                          child: const Text(
                            "홈으로 돌아가기",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.popUntil(
                                context, ModalRoute.withName('/'));
                          },
                          child: const Icon(
                            Icons.home,
                            size: 30,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          )
          //공유
        ]),
      ),
    );

    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: body,
      ),
    );
  }
}
