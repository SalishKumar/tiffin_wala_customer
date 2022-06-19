class Voucher {
  String? code;
  double? min_amount, percentage;
  int? id;
  DateTime? expiry;
  Voucher({
    this.code,
    this.id,
    this.min_amount,
    this.percentage,
    this.expiry,
  });
  factory Voucher.fromJson(Map<String, dynamic> json) {
    String ex = json["expiry_date"];
    return Voucher(
        id: json["coupon_id"],
        code: json["coupon_code"] ?? "",
        min_amount: json["minimum_order_amount"] ?? 0.0,
        percentage: json["percentage"] ?? 0.0,
        expiry: DateTime.parse(ex)
      );
  }
}
