import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/openai_provider.dart';

class TextInputScreen extends StatelessWidget {
  const TextInputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OpenAIProvider(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('채팅을 입력하세요:'),
          TextField(
            onSubmitted: (text) async {
              final chatAPIService =
                  Provider.of<OpenAIProvider>(context, listen: false);
              await chatAPIService.getText(text);
              final answer = chatAPIService.answer ?? '대답이 없습니다.';
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text((answer))),
              );
            },
          ),
        ],
      ),
    );
  }
}
