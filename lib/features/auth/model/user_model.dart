import 'dart:convert';

class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? position;
  final String? department;
  final String? birthDate;
  final String? avatar;
  final String? approved;
  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.position,
    this.department,
    this.birthDate,
    this.avatar,
    this.approved,
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? position,
    String? department,
    String? birthDate,
    String? avatar,
    String? approved,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      position: position ?? this.position,
      department: department ?? this.department,
      birthDate: birthDate ?? this.birthDate,
      avatar: avatar ?? this.avatar,
      approved: approved ?? this.approved,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'position': position,
      'department': department,
      'birthDate': birthDate,
      'avatar': avatar,
      'approved': approved,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      position: map['position'] != null ? map['position'] as String : null,
      department: map['department'] != null
          ? map['department'] as String
          : null,
      birthDate: map['birthDate'] != null ? map['birthDate'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      approved: map['approved'] != null ? map['approved'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, phone: $phone, position: $position, department: $department, birthDate: $birthDate, avatar: $avatar, approved: $approved)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.position == position &&
        other.department == department &&
        other.birthDate == birthDate &&
        other.avatar == avatar &&
        other.approved == approved;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        position.hashCode ^
        department.hashCode ^
        birthDate.hashCode ^
        avatar.hashCode ^
        approved.hashCode;
  }
}
