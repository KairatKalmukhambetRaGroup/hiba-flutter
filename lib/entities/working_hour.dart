class WorkingHour{
  final int id;
  final String dayOfWeek;
  final bool isClosed;
  final String? openTime;
  final String? closeTime;

  WorkingHour({
    required this.id,
    required this.dayOfWeek,
    required this.isClosed,
    required this.openTime,
    required this.closeTime
  });

  factory WorkingHour.fromJson(Map<String, dynamic> json){
    WorkingHour workingHour = WorkingHour(
      id: json["id"], 
      dayOfWeek: json["dayOfWeek"], 
      isClosed: json["closed"],
      openTime: json["openTime"], 
      closeTime: json["closeTime"]
    );
    return workingHour;
  }

  static List<WorkingHour> workingHourListFromJson(List<dynamic> json){
    List<WorkingHour> whs = [];
    for (Map<String, dynamic> wh in json) {
      whs.add(WorkingHour.fromJson(wh));
    }  
    
    return whs;
  }
}