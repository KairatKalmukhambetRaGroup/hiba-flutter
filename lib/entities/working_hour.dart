/// lib/entities/entities_library.dart
part of 'entities_library.dart';

/// A `WorkingHour` object represents a working hour of a [Butchery].
class WorkingHour {
  /// Unique identifier of this object.
  final int id;

  /// Day of week of this object.
  final String dayOfWeek;

  /// Whether [Butchery] is closed or not at [dayOfWeek] of this object.
  final bool isClosed;

  /// Time of opening of this object.
  final String? openTime;

  /// Time of closing of this object.
  final String? closeTime;

  /// Creates new instance of `WorkingHour`.
  WorkingHour(
      {required this.id,
      required this.dayOfWeek,
      required this.isClosed,
      required this.openTime,
      required this.closeTime});

  /// Creates new instance of `WorkingHour` from JSON object.
  factory WorkingHour.fromJson(Map<String, dynamic> json) {
    WorkingHour workingHour = WorkingHour(
        id: json["id"],
        dayOfWeek: json["dayOfWeek"],
        isClosed: json["closed"],
        openTime: json["openTime"],
        closeTime: json["closeTime"]);
    return workingHour;
  }

  /// Creates list of new instances of `WorkingHour` from JSON object.
  static List<WorkingHour> workingHourListFromJson(List<dynamic> json) {
    List<WorkingHour> whs = [];
    for (Map<String, dynamic> wh in json) {
      whs.add(WorkingHour.fromJson(wh));
    }

    return whs;
  }
}
