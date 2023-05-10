import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class FacebookShareProvider extends ChangeNotifier {
  static const MethodChannel _channel = MethodChannel('channel_name');

  Future<void> facebookShare(String imagePath) async {
    try {
      if (Platform.isAndroid) {
        // 안드로이드
        final bool isAndInstalled = await _channel.invokeMethod(
            'checkInstalled', 'com.facebook.android');
        if (!isAndInstalled) {
          final Uri url = Uri.parse(
              'https://play.google.com/store/apps/details?id=com.facebook.android');
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          } else {
            throw '페이스북 앱을 다운로드할 수 없습니다.';
          }
        }
        await _channel.invokeMethod('shareToFacebook', imagePath);
      } else if (Platform.isIOS) {
        // ios
        final bool isIosInstalled =
            await canLaunchUrl(Uri.parse('facebook://'));
        if (!isIosInstalled) {
          final Uri url = Uri.parse('https://apps.apple.com/kr/app/facebook/');
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          } else {
            throw '페이스북 앱을 다운로드할 수 없습니다.';
          }
        }
        await _channel.invokeMethod('shareToFacebook', imagePath);
      } else {
        throw '지원하지 않는 플랫폼입니다.';
      }
    } on PlatformException catch (e) {
      throw '페이스북 공유 실패: ${e.message}';
    }
  }
}

class FacebookShareButton extends StatelessWidget {
  final String text;

  const FacebookShareButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    FacebookShareProvider facebookProvider =
        Provider.of<FacebookShareProvider>(context, listen: false);
    return InkWell(
      onTap: () => facebookProvider.facebookShare(''),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue, // 버튼의 배경색 설정
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white, // 버튼의 텍스트 색상 설정
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
