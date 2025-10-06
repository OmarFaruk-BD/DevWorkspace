import 'dart:convert';

class MyAreaModel {
  final int? id;
  final DateTime? date;
  final String? latitude;
  final String? longitude;
  final String? radius;

  MyAreaModel({this.id, this.date, this.latitude, this.longitude, this.radius});

  MyAreaModel copyWith({
    int? id,
    DateTime? date,
    String? latitude,
    String? longitude,
    String? radius,
  }) => MyAreaModel(
    id: id ?? this.id,
    date: date ?? this.date,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    radius: radius ?? this.radius,
  );

  factory MyAreaModel.fromJson(String str) =>
      MyAreaModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyAreaModel.fromMap(Map<String, dynamic> json) => MyAreaModel(
    id: json["id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    latitude: json["latitude"],
    longitude: json["longitude"],
    radius: json["radius"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "date":
        "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "latitude": latitude,
    "longitude": longitude,
    "radius": radius,
  };
}
