import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../model/text_model.dart';

class OpenAIProvider with ChangeNotifier {
  String? _answer;

  Future<void> getText(String text) async {
    final textBody = jsonEncode(TextSendModel(text).toJson());
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': dotenv.env['CHAT_API_KEY']!,
    };
    final response = await http.post(url, body: textBody, headers: headers);
    if (response.statusCode == 200) {
      final ss = jsonDecode(utf8.decode(response.bodyBytes));
      String answer = {ss['choices'][0]['message']['content']}.toString();
      _answer = answer;
      notifyListeners();
    } else {
      _answer = '응답을 불러오지 못했습니다. 다시 시도해주세요.';
      notifyListeners();
    }
  }

  String? get answer => _answer;
}
