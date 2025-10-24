import 'dart:convert';

class NotificationResModel {
  final Data? data;

  NotificationResModel({this.data});

  NotificationResModel copyWith({Data? data}) =>
      NotificationResModel(data: data ?? this.data);

  factory NotificationResModel.fromJson(String str) =>
      NotificationResModel.fromMap(json.decode(str));

  factory NotificationResModel.fromMap(Map<String, dynamic> json) =>
      NotificationResModel(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );
}

class Data {
  final List<NotificationModel>? data;

  Data({this.data});

  Data copyWith({List<NotificationModel>? data}) =>
      Data(data: data ?? this.data);

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    data: json["data"] == null
        ? []
        : List<NotificationModel>.from(
            json["data"]!.map((x) => NotificationModel.fromMap(x)),
          ),
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class NotificationModel {
  final String? comments;
  final String? title;
  final String? content;
  final String? priority;
  final String? createdAt;

  NotificationModel({
    this.comments,
    this.title,
    this.content,
    this.priority,
    this.createdAt,
  });

  NotificationModel copyWith({
    String? comments,
    String? title,
    String? content,
    String? priority,
    String? createdAt,
  }) => NotificationModel(
    comments: comments ?? this.comments,
    title: title ?? this.title,
    content: content ?? this.content,
    priority: priority ?? this.priority,
    createdAt: createdAt ?? this.createdAt,
  );

  factory NotificationModel.fromJson(String str) =>
      NotificationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromMap(Map<String, dynamic> json) =>
      NotificationModel(
        comments: json["id"],
        title: json["title"],
        content: json["content"],
        priority: json["image"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toMap() => {
    "id": comments,
    "title": title,
    "content": content,
    "image": priority,
    "created_at": createdAt,
  };
}
