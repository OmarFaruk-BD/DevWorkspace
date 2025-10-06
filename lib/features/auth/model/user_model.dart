import 'dart:convert';

class UserModel {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? email;
  final String? phone;
  final dynamic position;
  final dynamic department;
  final dynamic birthDate;
  final dynamic companyEmail;
  final dynamic workingYears;
  final dynamic avatar;
  final String? approved;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.phone,
    this.position,
    this.department,
    this.birthDate,
    this.companyEmail,
    this.workingYears,
    this.avatar,
    this.approved,
  });

  UserModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? phone,
    dynamic position,
    dynamic department,
    dynamic birthDate,
    dynamic companyEmail,
    dynamic workingYears,
    dynamic avatar,
    String? approved,
  }) => UserModel(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    username: username ?? this.username,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    position: position ?? this.position,
    department: department ?? this.department,
    birthDate: birthDate ?? this.birthDate,
    companyEmail: companyEmail ?? this.companyEmail,
    workingYears: workingYears ?? this.workingYears,
    avatar: avatar ?? this.avatar,
    approved: approved ?? this.approved,
  );

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    username: json["username"],
    email: json["email"],
    phone: json["phone"],
    position: json["position"],
    department: json["department"],
    birthDate: json["birth_date"],
    companyEmail: json["company_email"],
    workingYears: json["working_years"],
    avatar: json["avatar"],
    approved: json["approved"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "username": username,
    "email": email,
    "phone": phone,
    "position": position,
    "department": department,
    "birth_date": birthDate,
    "company_email": companyEmail,
    "working_years": workingYears,
    "avatar": avatar,
    "approved": approved,
  };
}
