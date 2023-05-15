import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:text_analyzer/provider/facebook_provider.dart';
import 'package:text_analyzer/provider/instar_provider.dart';
import 'package:text_analyzer/provider/kakao_provider.dart';
import 'package:text_analyzer/provider/openai_provider.dart';
import 'package:text_analyzer/provider/text_from_image_provider.dart';
import 'package:text_analyzer/ui/textinput/text_input_screen.dart';
import 'package:text_analyzer/ui/start/start_screen.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // 키 초기화
  await dotenv.load();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: dotenv.env['KAKAO_NATIVE_APP_KEY']!,
    javaScriptAppKey: dotenv.env['KAKAO_JS_APP_KEY']!,
  );

  // 카카오 로그인 해시 키 받는 함수
  hasykey();

  FlutterNativeSplash.remove(); // 초기화가 끝나는 시점에 삽입
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<OpenAIProvider>(create: (_) => OpenAIProvider()),
    ChangeNotifierProvider<TextFromImageProvider>(
        create: (_) => TextFromImageProvider()),
    ChangeNotifierProvider<KakaoShareProvider>(
        create: (_) => KakaoShareProvider()),
    ChangeNotifierProvider<InstarShareProvider>(
        create: (_) => InstarShareProvider()),
    ChangeNotifierProvider<FacebookShareProvider>(
        create: (_) => FacebookShareProvider()),
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
