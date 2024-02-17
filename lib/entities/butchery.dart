class Butchery {
  final int id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;

  const Butchery({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory Butchery.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'latitude': double latitude,
        'longitude': double longitude,
        'address': String address
      } =>
        Butchery(
            id: id,
            name: name,
            address: address,
            latitude: latitude,
            longitude: longitude),
      _ => throw const FormatException('Failed to load Butchery'),
    };
  }

  @override
  String toString() {
    return '$name: $address';
  }
}
