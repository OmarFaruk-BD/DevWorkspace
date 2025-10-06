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
    data:
        json["data"] == null
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
  final String? id;
  final String? title;
  final String? content;
  final String? image;
  final String? createdAt;

  NotificationModel({
    this.id,
    this.title,
    this.content,
    this.image,
    this.createdAt,
  });

  NotificationModel copyWith({
    String? id,
    String? title,
    String? content,
    String? image,
    String? createdAt,
  }) => NotificationModel(
    id: id ?? this.id,
    title: title ?? this.title,
    content: content ?? this.content,
    image: image ?? this.image,
    createdAt: createdAt ?? this.createdAt,
  );

  factory NotificationModel.fromJson(String str) =>
      NotificationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromMap(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        image: json["image"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "content": content,
    "image": image,
    "created_at": createdAt,
  };
}
