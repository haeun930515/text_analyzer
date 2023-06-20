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
import 'firebase_options.dart';

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
      initialRoute: '/start',
      routes: {
        '/start': (context) => const StartScreen(),
        '/input': (context) => const TextInputScreen(),
      },
      home: const StartScreen(),
    );
  }
}
