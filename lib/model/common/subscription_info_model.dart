class SubscriptionInfoModel {
  String period;
  String startTime;
  String endTime;
  String price;
  String paidAmount;
  String status;
  String planName;

  SubscriptionInfoModel({
    required this.period,
    required this.startTime,
    required this.endTime,
    required this.price,
    required this.paidAmount,
    required this.status,
    required this.planName,
  });

  Map<String, dynamic> toJson() => {
    'period': period,
    'start_time': startTime,
    'end_time': endTime,
    'price': price,
    'paid_amount': paidAmount,
    'status': status,
    'plan_name': planName,
  };

  factory SubscriptionInfoModel.fromJson(Map<String, dynamic> json) => SubscriptionInfoModel(
    period: json['period'], 
    startTime: json['start_time'],
    endTime: json['end_time'],
    price: json['price'],
    paidAmount: json['paid_amount'],
    status: json['status'],
    planName: json['plan_name'],
  );
}