import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:text_analyzer/provider/kakao_provider.dart';
import 'package:text_analyzer/provider/openai_provider.dart';
import 'package:text_analyzer/ui/textinput/text_input_screen.dart';
import 'package:text_analyzer/ui/aiwork/ai_work_screen.dart';
import 'package:text_analyzer/ui/result/result_screen.dart';
import 'package:text_analyzer/ui/start/start_screen.dart';
import 'package:text_analyzer/ui/textanalyzing/text_analyzing_screen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // 키 초기화
  await dotenv.load();
  FlutterNativeSplash.remove(); // 초기화가 끝나는 시점에 삽입
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<OpenAIProvider>(create: (_) => OpenAIProvider()),
    ChangeNotifierProvider<KakaoShareProvider>(
        create: (_) => KakaoShareProvider()),
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
        '/ing': (context) => const TextAnalyzingScreen(),
        '/ai': (context) => const AiWorkScreen(),
        '/result': (context) => const ResultScreen()
      },
      home: const StartScreen(),
    );
  }
}
