import 'dart:math';

import 'package:flutter/material.dart';
import 'package:text_analyzer/utils/strings.dart';

class ScoreWidget extends StatelessWidget {
  int score = 0;

  ScoreWidget(this.score, {super.key});

  double widCalc(int score) {
    switch (score) {
      case 1:
        return 26.0;
      case 2:
        return 68.0;
      case 3:
        return 110.0;
      case 4:
        return 152.0;
      case 5:
        return 192.0;
      default:
        return 0.0;
    }
  }

  List<int> getRandomNumbers() {
    Random random = Random();
    List<int> numbers = [];

    while (numbers.length < 5) {
      int randomNumber = random.nextInt(12) + 1;
      if (!numbers.contains(randomNumber)) {
        numbers.add(randomNumber);
      }
    }

    return numbers;
  }

  String getIl(int num) {
    switch (num) {
      case 1:
        return Strings.picilBis;
      case 2:
        return Strings.picilbod;
      case 3:
        return Strings.picilche;
      case 4:
        return Strings.picilchi;
      case 5:
        return Strings.picildal;
      case 6:
        return Strings.picilhou;
      case 7:
        return Strings.picillit;
      case 8:
        return Strings.picilmal;
      case 9:
        return Strings.picilpod;
      case 10:
        return Strings.picilpom;
      case 11:
        return Strings.picilsha;
      case 12:
        return Strings.picilyor;
      default:
        return Strings.picilmal;
    }
  }

  int getRandomNum() {
    Random random = Random();
    int randomNum = random.nextInt(12) + 1;
    return randomNum;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      color: Colors.white,
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              Container(
                width: 30,
              ),
              Container(
                width: 40,
                height: 18,
                decoration: const BoxDecoration(
                    color: Color(0xFF2062f3),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12))),
              ),
              Container(
                width: 2,
              ),
              Container(
                height: 18,
                width: 40,
                color: score >= 2
                    ? const Color(0xFF2062f3)
                    : const Color(0xFFECECEC),
              ),
              Container(
                width: 2,
              ),
              Container(
                width: 40,
                height: 18,
                color: score >= 3
                    ? const Color(0xFF2062f3)
                    : const Color(0xFFECECEC),
              ),
              Container(
                width: 2,
              ),
              Container(
                width: 40,
                height: 18,
                color: score >= 4
                    ? const Color(0xFF2062f3)
                    : const Color(0xFFECECEC),
              ),
              Container(
                width: 2,
              ),
              Container(
                width: 40,
                height: 18,
                decoration: BoxDecoration(
                    color: score >= 5
                        ? const Color(0xFF2062f3)
                        : const Color(0xFFECECEC),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12))),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              width: 30,
            ),
            SizedBox(
              width: widCalc(score),
              height: 18,
            ),
            Image.asset(
              getIl(getRandomNum()),
              height: 30,
              filterQuality: FilterQuality.high,
            )
          ],
        ),
      ]),
    );
  }
}
