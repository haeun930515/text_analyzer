class ResultModel {
  final String id;
  final String object;
  final int created;
  final String model;
  final UsageModel usage;
  final List<ChoiceModel> choices;

  ResultModel({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.usage,
    required this.choices,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      id: json['id'],
      object: json['object'],
      created: json['created'],
      model: json['model'],
      usage: UsageModel.fromJson(json['usage']),
      choices: List<ChoiceModel>.from(
        json['choices'].map((choice) => ChoiceModel.fromJson(choice)),
      ),
    );
  }
}

class UsageModel {
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;

  UsageModel({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  factory UsageModel.fromJson(Map<String, dynamic> json) {
    return UsageModel(
      promptTokens: json['prompt_tokens'],
      completionTokens: json['completion_tokens'],
      totalTokens: json['total_tokens'],
    );
  }
}

class ChoiceModel {
  final MessageModel message;
  final String finishReason;
  final int index;

  ChoiceModel({
    required this.message,
    required this.finishReason,
    required this.index,
  });

  factory ChoiceModel.fromJson(Map<String, dynamic> json) {
    return ChoiceModel(
      message: MessageModel.fromJson(json['message']),
      finishReason: json['finish_reason'],
      index: json['index'],
    );
  }
}

class MessageModel {
  final String role;
  final String content;

  MessageModel({
    required this.role,
    required this.content,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      role: json['role'],
      content: json['content'],
    );
  }
}
