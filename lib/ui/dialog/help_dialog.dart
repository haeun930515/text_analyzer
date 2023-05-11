import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

class HelpDialog extends StatefulWidget {
  const HelpDialog({super.key});

  @override
  State<HelpDialog> createState() => _HelpDialogState();
}

class _HelpDialogState extends State<HelpDialog> {
  late int selectedPage;
  late final PageController _pageController;

  @override
  void initState() {
    selectedPage = 0;
    _pageController = PageController(initialPage: selectedPage);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const pageCount = 4;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: 550,
        child: Column(
          children: [
            SizedBox(
              height: 480,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (page) {
                    setState(() {
                      selectedPage = page;
                    });
                  },
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          const Text(
                            "카카오톡 캡쳐 선택 후",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 100,
                              ),
                              Image.asset(
                                'assets/images/image_background.png',
                                width: 200,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Text(
                            "꼭 지켜주세요",
                            style: TextStyle(
                                color: Color(0xFF2062f3),
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "'기본배경'",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2062f3)),
                              ),
                              Text(
                                "만 가능합니다",
                                style: TextStyle(
                                    fontSize: 18, color: Color(0xFF2062f3)),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          const Text(
                            "대화 캡쳐하고",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Image.asset(
                            'assets/images/capture.png',
                            width: 200,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          const Text(
                            "사진 붙여넣기 하면",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Image.asset(
                            'assets/images/choose_photo.png',
                            width: 200,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Text(
                            "1개만 선택 가능합니다",
                            style: TextStyle(
                                color: Color(0xFF2062f3), fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          const Text(
                            "우리의 티키타캉력 획득",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Image.asset(
                            'assets/images/loading1.png',
                            width: 200,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Text(
                            "비숑프리제 vs 포메라니안",
                            style: TextStyle(
                                color: Color(0xFF2062f3),
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          const Text(
                            "서로를 향해 너무 달려들지만 마세요.",
                            style: TextStyle(
                                fontSize: 18, color: Color(0xFF2062f3)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            PageViewDotIndicator(
              currentItem: selectedPage,
              count: pageCount,
              unselectedColor: Colors.black26,
              selectedColor: Colors.blue,
              duration: const Duration(milliseconds: 200),
              boxShape: BoxShape.circle,
            ),
          ],
        ),
      ),
    );
  }
}
