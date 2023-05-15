class ScoreModel {
  final int happiness;
  final int curiosity;
  final int vigilance;
  final int anger;
  final int anxiety;

  ScoreModel({
    required this.happiness,
    required this.curiosity,
    required this.vigilance,
    required this.anger,
    required this.anxiety,
  });

  factory ScoreModel.fromJson(Map<String, dynamic> json) {
    return ScoreModel(
      happiness: json['기쁨'],
      curiosity: json['호기심'],
      vigilance: json['경계'],
      anger: json['분노'],
      anxiety: json['불안'],
    );
  }
}
