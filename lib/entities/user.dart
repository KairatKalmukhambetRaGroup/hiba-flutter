import 'dart:typed_data';

class User {
  final int id;
  final String name;
  final String phone;
  final String? avatar;

  const User({
    required this.phone,
    required this.avatar,
    required this.id,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        phone: json["phone"],
        avatar: json["avatar"],
        id: json["id"],
        name: json["name"],
      );

  @override
  String toString() {
    return name;
  }
}
