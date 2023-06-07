import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:text_analyzer/provider/facebook_provider.dart';
import 'package:text_analyzer/provider/insta_provider.dart';
import 'package:text_analyzer/provider/kakao_provider.dart';
import 'package:text_analyzer/provider/share_provider.dart';
import 'package:text_analyzer/provider/openai_provider.dart';
import 'package:text_analyzer/provider/result_provider.dart';
import 'package:text_analyzer/provider/text_from_image_provider.dart';
import 'package:text_analyzer/ui/textinput/text_input_screen.dart';
import 'package:text_analyzer/ui/start/start_screen.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'firebase_options.dart';

const Map<String, String> UNIT_ID = kReleaseMode
    ? {
        'ios': 'ca-app-pub-8738315695455286~8425268744',
        'android': 'ca-app-pub-8738315695455286~1128839442',
      }
    : {
        'ios': 'ca-app-pub-3940256099942544/2934735716',
        'android': 'ca-app-pub-3940256099942544/6300978111',
      };

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // 키 초기화
  await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: dotenv.env['KAKAO_NATIVE_APP_KEY']!,
    javaScriptAppKey: dotenv.env['KAKAO_JS_APP_KEY']!,
  );

  // 카카오 로그인 해시 키 받는 함수
  hasykey();

  MobileAds.instance.initialize();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<OpenAIProvider>(create: (_) => OpenAIProvider()),
    ChangeNotifierProvider<TextFromImageProvider>(
        create: (_) => TextFromImageProvider()),
    ChangeNotifierProvider<ImageShareProvider>(
        create: (_) => ImageShareProvider()),
    ChangeNotifierProvider<KakaoShareProvider>(
        create: (_) => KakaoShareProvider()),
    ChangeNotifierProvider<InstarShareProvider>(
        create: (_) => InstarShareProvider()),
    ChangeNotifierProvider<FacebookShareProvider>(
        create: (_) => FacebookShareProvider()),
    ChangeNotifierProvider<ImageShareProvider>(
        create: (_) => ImageShareProvider()),
    ChangeNotifierProvider<ResultProvider>(create: (_) => ResultProvider()),
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/start': (context) => const StartScreen(),
        '/input': (context) => const TextInputScreen(),
      },
      home: const StartScreen(),
    );
  }
}

void hasykey() async {
  var hasykey = await KakaoSdk.origin;
  print(hasykey);
}
