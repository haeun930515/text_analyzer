import 'package:flutter/material.dart';

class ScoreWidget extends StatelessWidget {
  int score = 0;

  ScoreWidget(this.score, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Container(
            width: 30,
          ),
          Container(
            width: 40,
            height: 22,
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
            height: 22,
            width: 40,
            color:
                score >= 2 ? const Color(0xFF2062f3) : const Color(0xFFECECEC),
          ),
          Container(
            width: 2,
          ),
          Container(
            width: 40,
            height: 22,
            color:
                score >= 3 ? const Color(0xFF2062f3) : const Color(0xFFECECEC),
          ),
          Container(
            width: 2,
          ),
          Container(
            width: 40,
            height: 22,
            color:
                score >= 4 ? const Color(0xFF2062f3) : const Color(0xFFECECEC),
          ),
          Container(
            width: 2,
          ),
          Container(
            width: 40,
            height: 22,
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
    );
  }
}
