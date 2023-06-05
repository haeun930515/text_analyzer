import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:text_analyzer/model/score_model.dart';
import '../model/result_model.dart';
import '../model/text_model.dart';

class OpenAIProvider with ChangeNotifier {
  String? _answer;
  bool finished = false;
  late ScoreModel scoreModel;

  bool get isFinished => finished;

  getText(String text) async {
    print("INPUT STRING : $text");
    final textBody = jsonEncode(TextSendModel(text).toJson());
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': dotenv.env['CHAT_API_KEY']!,
    };
    if (!finished) {
      final response = await http.post(url, body: textBody, headers: headers);

      if (response.statusCode == 200) {
        // final ss = jsonDecode(utf8.decode(response.bodyBytes));
        Map<String, dynamic> md = jsonDecode(utf8.decode(response.bodyBytes));
        // print(md['choices'][0]['message']['content']);
        ResultModel rm = ResultModel.fromJson(md);
        var rawData = rm.choices[0].message.content;

        print(rm.choices[0].message.content);

        var score = ScoreModel.fromJson(getScore(rawData));

        _answer = answer;
        scoreModel = score;
        finished = true;
        print(rm.usage.totalTokens);
        notifyListeners();
      } else {
        _answer = '응답을 불러오지 못했습니다. 다시 시도해주세요.';
        print("API CALL FAILED");
        print(response.body);
        var score = ScoreModel.fromJson(
            getScore(("기쁨: 2 \n호기심: 3 \n경계: 2\n분노: 1\n불안: 3")));
        scoreModel = score;
        finished = true;
        notifyListeners();
      }
    }
  }

  String? get answer => _answer;

  Map<String, int> getScore(String str) {
    Map<String, int> scores = {"기쁨": 2, "호기심": 3, "경계": 2, "분노": 3, "불안": 1};

    List<String> chunks = str.split('\n');

    try {
      for (String chunk in chunks) {
        List<String> parts = chunk.split(':');
        String key = parts[0].trim();
        int value = int.parse(parts[1].trim());
        scores[key] = value;
      }
      return scores;
    } catch (e) {
      return scores;
    }
  }
}
