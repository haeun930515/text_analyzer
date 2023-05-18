import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_analyzer/model/score_model.dart';
import 'package:text_analyzer/provider/facebook_provider.dart';
import 'package:text_analyzer/provider/instar_provider.dart';
import 'package:text_analyzer/provider/kakao_provider.dart';
import 'package:text_analyzer/provider/result_provider.dart';
import 'package:text_analyzer/ui/widgets/score_widget.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.sm});

  final ScoreModel sm;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late ResultProvider resultProvider;
  @override
  void didChangeDependencies() {
    resultProvider = Provider.of<ResultProvider>(context);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => {resultProvider.getResult(widget.sm)});
  }

  @override
  Widget build(BuildContext context) {
    var globalKey = GlobalKey();
    return RepaintBoundary(
      key: globalKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(color: Color(0xFF2062f3)),
            child: Column(children: [
              const SizedBox(
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child:
                    Consumer<ResultProvider>(builder: (context, value, child) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              height: 150,
                              child: Image.asset(
                                value.photo1,
                                height: 300,
                              )),
                          SizedBox(
                              height: 150,
                              child: Image.asset(
                                value.photo2,
                                height: 300,
                              )),
                        ],
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
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  //카카오 공유하기 버튼
                  KakaoShareButton(
                    text: '카카오로 공유하기',
                    globalKey: globalKey,
                  ),
                  // 인스타 공유하기 버튼
                  InstarShareButton(
                    text: '인스타로 공유하기',
                    globalKey: globalKey,
                  ),
                  // 페이스북 공유하기 버튼
                  FacebookShareButton(
                    text: '페이스북으로 공유하기',
                    globalKey: globalKey,
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
