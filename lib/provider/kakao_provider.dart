import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:flutter/material.dart';

class KakaoShareProvider extends ChangeNotifier {
  kakaoShare(BuildContext context, String imagePath) async {
    print(imagePath);
    FeedTemplate feedTemplate = FeedTemplate(
      content: Content(
        title: '우리의 대화 분석 결과 공유',
        description: '우리의 대화 분석 결과가 나왔어요!',
        imageUrl: Uri.parse(imagePath),
        link: Link(
          androidExecutionParams: <String, String>{'key': 'value'},
          iosExecutionParams: <String, String>{'key': 'value'},
          mobileWebUrl: Uri.parse('https://example.com'),
          webUrl: Uri.parse('https://example.com'),
        ),
      ),
    );
    bool isKakaoTalkSharingAvailable =
        await ShareClient.instance.isKakaoTalkSharingAvailable();

    if (isKakaoTalkSharingAvailable) {
      try {
        Uri uri =
            await ShareClient.instance.shareDefault(template: feedTemplate);
        await ShareClient.instance.launchKakaoTalk(uri);
        print('카카오톡 공유 완료');
      } catch (error) {
        print('카카오톡 공유 실패 $error');
      }
    } else {
      try {
        Uri shareUrl = await WebSharerClient.instance
            .makeDefaultUrl(template: feedTemplate);
        await launchBrowserTab(shareUrl, popupOpen: true);
      } catch (error) {
        print('카카오톡 공유 실패 $error');
      }
    }
  }
}

class KakaoShareButton extends StatelessWidget {
  final String text;
  final String imageUrl;

  const KakaoShareButton({Key? key, required this.text, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Image.asset(
        "assets/images/utils/graphic_kakao.png",
        height: 40,
      ),
    ));
  }
}
