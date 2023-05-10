import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KakaoShareProvider extends ChangeNotifier {
  final FeedTemplate defaultFeed = FeedTemplate(
    content: Content(
      title: '우리의 대화 분석 결과 공유',
      description: '우리의 대화 분석 결과가 나왔어요!',
      imageUrl: Uri.parse('https://example.com/image.jpg'),
      link: Link(
        androidExecutionParams: <String, String>{'key': 'value'},
        iosExecutionParams: <String, String>{'key': 'value'},
        mobileWebUrl: Uri.parse('https://example.com'),
        webUrl: Uri.parse('https://example.com'),
      ),
    ),
    buttons: [
      Button(
        title: '웹으로 보기',
        link: Link(
          androidExecutionParams: <String, String>{'key': 'value'},
          iosExecutionParams: <String, String>{'key': 'value'},
          mobileWebUrl: Uri.parse('https://example.com'),
          webUrl: Uri.parse('https://example.com'),
        ),
      ),
      Button(
        title: '앱으로 보기',
        link: Link(
          androidExecutionParams: <String, String>{'key': 'value'},
          iosExecutionParams: <String, String>{'key': 'value'},
          mobileWebUrl: Uri.parse('https://example.com'),
          webUrl: Uri.parse('https://example.com'),
        ),
      ),
    ],
  );

  kakaoShare(BuildContext context) async {
    bool isKakaoTalkSharingAvailable =
        await ShareClient.instance.isKakaoTalkSharingAvailable();

    if (isKakaoTalkSharingAvailable) {
      try {
        Uri uri =
            await ShareClient.instance.shareDefault(template: defaultFeed);
        await ShareClient.instance.launchKakaoTalk(uri);
        print('카카오톡 공유 완료');
      } catch (error) {
        print('카카오톡 공유 실패 $error');
      }
    } else {
      try {
        Uri shareUrl = await WebSharerClient.instance
            .makeDefaultUrl(template: defaultFeed);
        await launchBrowserTab(shareUrl, popupOpen: true);
      } catch (error) {
        print('카카오톡 공유 실패 $error');
      }
    }
  }
}

class KakaoShareButton extends StatelessWidget {
  final String text;

  const KakaoShareButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    KakaoShareProvider kakaoProvider =
        Provider.of<KakaoShareProvider>(context, listen: false);
    return InkWell(
      onTap: () => kakaoProvider.kakaoShare(context),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.yellow, // 버튼의 배경색 설정
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black, // 버튼의 텍스트 색상 설정
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
