class Country {
  final int id;
  final String name;
  const Country({required this.id, required this.name});

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json['id'],
        name: json['name'],
      );

  @override
  String toString() => name;
}

class Region {
  final int id;
  final String name;
  final Country country;

  const Region({required this.id, required this.name, required this.country});

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        id: json['id'],
        name: json['name'],
        country: Country.fromJson(json['country']),
      );

  @override
  String toString() => name;
}

class City {
  final int id;
  final String name;
  final Region? region;
  final Country? country;

  const City({required this.id, required this.name, this.region, this.country});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      region: json['region'] != null ? Region.fromJson(json['region']) : null,
      country:
          json['country'] == null ? null : Country.fromJson(json['country']),
    );
  }

  @override
  String toString() => name;
}
