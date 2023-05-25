/// ChatAISendModel - AI 채팅 API 전달값
class TextSendModel {
  final String text;
  final String model = "gpt-3.5-turbo";

  TextSendModel(this.text);

  Map<String, dynamic> toJson() {
    return {
      "messages": [
        {"role": "user", "content": text},
        {
          "role": "user",
          "content": "위 대화를 기쁨, 호기심, 경계, 분노, 불안 다섯가지 기준으로 1부터 5까지 점수만줘"
        }
      ],
      'model': model,
      'max_tokens': 1000
    };
  }
}
