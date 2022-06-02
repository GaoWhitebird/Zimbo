class PaymentHistoryItemModel {
  String? time;
  String? amount;
  String? status;

  PaymentHistoryItemModel({
    this.time,
    this.amount,
    this.status,
  });

  Map<String, dynamic> toJson() => {
    'payment_time': this.time,
    'amount': this.amount,
    'status': this.status,
  };

  factory PaymentHistoryItemModel.fromJson(Map<String, dynamic> json) => PaymentHistoryItemModel(
    time: json['payment_time'], 
    amount: json['amount'], 
    status: json['status'],
  );
}