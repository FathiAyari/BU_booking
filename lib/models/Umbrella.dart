class Umbrella {
  String idUmbrella;
  double price;
  int? status;

  Umbrella({required this.idUmbrella, required this.status, required this.price});

  Map<String, dynamic> toJson() {
    return {
      'idUmbrella': idUmbrella,
      'status': status,
      'price': price,
    };
  }

  factory Umbrella.fromJson(Map<String, dynamic> json) {
    return Umbrella(price: json['price'], idUmbrella: json['idUmbrella'], status: json['status']);
  }
}
