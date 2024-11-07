/// An `User` object represents an user with specific details.
class User {
  /// The unique identifier of this user.
  final int id;

  /// The name of this user.
  final String name;

  /// The phone of this user.
  final String phone;

  /// A base64-encoded image representing this user's image.
  final String? avatar;

  /// Creates new `User` instance.
  /// All fields are required except for [avatar].
  const User({
    required this.phone,
    this.avatar,
    required this.id,
    required this.name,
  });

  /// Creates new instance of `User` from JSON object.
  /// [json] is expected to contain `phone`, `id`, and `name` keys, `avatar` can be null.
  factory User.fromJson(Map<String, dynamic> json) => User(
        phone: json["phone"],
        avatar: json["avatar"],
        id: json["id"],
        name: json["name"],
      );

  /// Returns the user's name as a string representation.
  @override
  String toString() {
    return name;
  }
}
