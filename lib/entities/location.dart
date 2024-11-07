/// A `Country` object represents a country.
class Country {
  /// Unique identifier of this country.
  final int id;

  /// Name of this user.
  final String name;

  /// Creates new `Country` instance.
  const Country({required this.id, required this.name});

  /// Creates new instance of `Country` from JSON object.
  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json['id'],
        name: json['name'],
      );

  @override
  String toString() => name;
}

/// A `Region` object represents a region in [Country].
class Region {
  /// Unique identifier of this region.
  final int id;

  /// Name of this region.
  final String name;

  /// Country this region located at.
  final Country country;

  /// Creates new `Region` instance.
  const Region({required this.id, required this.name, required this.country});

  /// Creates new instance of `Region` from JSON object.
  factory Region.fromJson(Map<String, dynamic> json) => Region(
        id: json['id'],
        name: json['name'],
        country: Country.fromJson(json['country']),
      );

  @override
  String toString() => name;
}

/// A `City` object represents a city in [Region] or [Country].
class City {
  final int id;
  final String name;
  final Region? region;
  final Country? country;

  /// Creates new `City` instance.
  /// All fields are required except for [region] and [country].
  const City({required this.id, required this.name, this.region, this.country});

  /// Creates new instance of `City` from JSON object.
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
