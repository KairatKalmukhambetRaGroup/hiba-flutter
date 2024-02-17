class User {
  final int id;
  final String username;
  final String phone;
  final String avatar;

  const User({
    required this.phone,
    required this.avatar,
    required this.id,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'username': String username,
        'avatar': String avatar,
        'phone': String phone
      } =>
        User(phone: phone, avatar: avatar, id: id, username: username),
      _ => throw const FormatException('Failed to load User'),
    };
  }

  @override
  String toString() {
    return username;
  }
}
