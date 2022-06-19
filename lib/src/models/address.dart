class Address {
  String? address, label, notes='';
  double lat, long;
  int? id;
  Address({
    required this.address,
    required this.label,
    this.notes,
    this.id,
    required this.lat,
    required this.long,
  });
  factory Address.fromJson(Map<String, dynamic> json) {
    print(json["address_id"]);
    var l;
    if(json["label"]=="home"){
      l="Home";
    }else if(json["label"]=="work")
    {
      l="Work";
    }
    return Address(
        label: l ?? "",
        id: json["address_id"],
        address: json["address"] ?? "",
        notes: json["notes"] ?? "",
        lat: json["lat"] ?? 24.860966,
        long: json["long"] ?? 66.990501,
      );
  }

  Map<String, dynamic> toJSON() {
    print(notes);
    Map<String, dynamic> map;
    map = {
      'address_id': id,
        'label': label?.trim(),
        'address': address?.trim(),
        'notes': notes?.trim(),
        'lat': lat,
        'long': long,
      };
    return map;
  }
}
