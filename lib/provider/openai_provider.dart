import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// gpt와 연결될 provider
// 결과 공유 할 sns provider
class ChatAPIService with ChangeNotifier {
  Map<String, String> headers = {
    // "Authorization": dotenv.env['CHAT_API_KEY']!,
    "Content-Type": "application/json"
  };

  getText(String text) async {
    final textBody = jsonEncode(textSendModel(text).toJson());
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final response = await http.post(url, body: textBody, headers: headers);
    if (response.statusCode == 200) {
      Map ss = jsonDecode(response.body);
      String answer = {ss['choices'][0]['message']['content']}.toString();
      answer = answer.substring(1, answer.length - 1);
      return answer;
    } else {
      throw Error();
    }
  }
}

/// ChatAISendModel - AI 채팅 API 전달값
class textSendModel {
  final String prompt;
  final String model = "gpt-4";

  textSendModel(this.prompt);

  Map<String, dynamic> toJson() {
    return {
      'messages': [
        {
          "role": "user",
          "content": prompt,
          // 위 prompt에 채팅 결과를 항목별로 도출해 달라는 메시지를 같이 적어야 함!
        }
      ],
      'model': model,
      'max_tokens': 1000
    };
  }
}
