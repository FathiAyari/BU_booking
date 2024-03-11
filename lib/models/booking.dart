class Booking {
  DateTime startDate;
  DateTime endDate;
  List<String> equipementsIds;
  String umbrellaId;
  double totalPrice;

  Booking({
    required this.startDate,
    required this.endDate,
    required this.equipementsIds,
    required this.umbrellaId,
    required this.totalPrice,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      equipementsIds: List<String>.from(json['equipementsIds'] ?? []),
      umbrellaId: json['umbrellaId'],
      totalPrice: json['totalPrice'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate,
      'endDate': endDate,
      'equipementsIds': equipementsIds,
      'umbrellaId': umbrellaId,
      'totalPrice': totalPrice,
    };
  }
}
