import 'dart:convert';

List<EmotionModel> emotionModelFromJson(String str) =>
    List<EmotionModel>.from(json.decode(str).map((x) => EmotionModel.fromJson(x)));

String emotionModelToJson(List<EmotionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmotionModel{
  EmotionModel({
     message, status, emotion,
  });

  String message = "msg";
  String emotion = "neutral";
  bool status = false;


  factory EmotionModel.fromJson(Map<String, dynamic> json) => EmotionModel(
    status: json["status"],
    emotion: json['emotion']
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };


}
