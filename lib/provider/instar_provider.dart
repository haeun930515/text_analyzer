import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:text_analyzer/model/capture_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class InstarShareProvider extends ChangeNotifier {
  static const MethodChannel _channel = MethodChannel('channel_name');

  Future<void> instarShare(String imagePath) async {
    try {
      if (Platform.isAndroid) {
        // 안드로이드
        final bool isAndInstalled = await _channel.invokeMethod(
            'checkInstalled', 'com.instagram.android');
        if (!isAndInstalled) {
          final Uri url = Uri.parse(
              'https://play.google.com/store/apps/details?id=com.instagram.android');
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          } else {
            throw '인스타그램 앱을 다운로드할 수 없습니다.';
          }
        }
        await _channel.invokeMethod('shareToInstagram', imagePath);
      } else if (Platform.isIOS) {
        // ios
        final bool isIosInstalled =
            await canLaunchUrl(Uri.parse('instagram://'));
        if (!isIosInstalled) {
          final Uri url = Uri.parse('https://apps.apple.com/kr/app/instagram/');
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          } else {
            throw '인스타그램 앱을 다운로드할 수 없습니다.';
          }
        }
        await _channel.invokeMethod('shareToInstagram', imagePath);
      } else {
        throw '지원하지 않는 플랫폼입니다.';
      }
    } on PlatformException catch (e) {
      throw '인스타그램 공유 실패: ${e.message}';
    }
  }
}

class InstarShareButton extends StatelessWidget {
  final String text;
  GlobalKey globalKey;

  InstarShareButton({
    super.key,
    required this.text,
    required this.globalKey,
  });

  @override
  Widget build(BuildContext context) {
    InstarShareProvider instarProvider =
        Provider.of<InstarShareProvider>(context, listen: false);
    Capture capture = Capture();
    return InkWell(
        onTap: () async {
          String imagePath = await capture.capture(globalKey);
          await instarProvider.instarShare(imagePath);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(
            "assets/images/utils/graphic_instagram.png",
            height: 70,
          ),
        ));
  }
}
