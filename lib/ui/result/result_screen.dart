import 'package:flutter/material.dart';
import 'package:text_analyzer/provider/facebook_provider.dart';
import 'package:text_analyzer/provider/instar_provider.dart';
import 'package:text_analyzer/provider/kakao_provider.dart';
import 'package:text_analyzer/ui/widgets/score_widget.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

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
                child: Container(
                  height: 250,
                  decoration: const BoxDecoration(color: Colors.white),
                ),
              ),
              Container(
                child: const Text(
                  "비숑프리제",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  "분석결과분석결과분석결과분석결과 분석결과분석결과분석결과분석결과분석결과 분석결과분석결과분석결과분석결과분석결과 분석결과분석결과분석결과분석결과분석결과분석결과",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
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
                              ScoreWidget(5),
                              const SizedBox(
                                height: 20,
                              ),
                              ScoreWidget(2),
                              const SizedBox(
                                height: 20,
                              ),
                              ScoreWidget(4),
                              const SizedBox(
                                height: 20,
                              ),
                              ScoreWidget(1),
                              const SizedBox(
                                height: 20,
                              ),
                              ScoreWidget(1)
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: const [
                  //카카오 공유하기 버튼
                  KakaoShareButton(
                    text: '카카오로 공유하기',
                  ),
                  // 인스타 공유하기 버튼
                  InstarShareButton(
                    text: '인스타로 공유하기',
                  ),
                  // 페이스북 공유하기 버튼
                  FacebookShareButton(
                    text: '페이스북으로 공유하기',
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
