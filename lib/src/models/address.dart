class Address {
  String? address, label, floor_unit, notes='';
  double lat, long;
  Address({
    required this.address,
    required this.label,
    required this.floor_unit,
    this.notes,
    required this.lat,
    required this.long,
  });
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        label: json["label"] ?? "",
        address: json["address"] ?? "",
        floor_unit: json["floor_unit"] ?? "",
        notes: json["notes"] ?? "",
        lat: json["lat"] ?? 24.860966,
        long: json["long"] ?? 66.990501,
      );
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> map;
    map = {
        'label': label?.trim(),
        'address': address?.trim(),
        'floor_unit': floor_unit?.trim(),
        'notes': notes?.trim(),
        'lat': lat,
        'long': long,
      };
    return map;
  }
}
