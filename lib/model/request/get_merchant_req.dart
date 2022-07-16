
class GetMerchantReq {
  String merchantId;

  GetMerchantReq({
    required this.merchantId,
  });

  Map<String, dynamic> toJson() => {
    'merchant_id': merchantId,
  };

  factory GetMerchantReq.fromJson(Map<String, dynamic> json) => GetMerchantReq(
    merchantId: json['merchant_id'], 
  );
}