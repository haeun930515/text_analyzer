import 'package:flutter/material.dart';
import 'package:text_analyzer/ui/aiwork/ai_work_screen.dart';
import 'package:text_analyzer/ui/result/result_screen.dart';
import 'package:text_analyzer/ui/start/start_screen.dart';
import 'package:text_analyzer/ui/textanalyzing/text_analyzing_screen.dart';
import 'package:text_analyzer/ui/textinput/text_input_screen.dart';

void main() {
  runApp(const MainApp());
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
