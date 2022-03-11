class ShoppingDayReq {
  bool specificDay;
  String dayInfo;

  ShoppingDayReq({
    required this.specificDay,
    required this.dayInfo,
  });

  Map<String, dynamic> toJson() => {
    'specific_day': specificDay,
    'day_info': dayInfo,
  };

  factory ShoppingDayReq.fromJson(Map<String, dynamic> json) => ShoppingDayReq(
    specificDay: json['specific_day'], 
    dayInfo: json['day_info'],
  );
}