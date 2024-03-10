class Cuser {
  String uid;
  String name;
  String lastName;
  String email;
  String role;
  String countryId;
  String phoneNumber;

  Cuser({
    required this.uid,
    required this.name,
    required this.lastName,
    required this.email,
    required this.role,
    required this.countryId,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'lastName': lastName,
      'email': email,
      'role': role,
      'countryId': countryId,
      'phoneNumber': phoneNumber,
    };
  }

  factory Cuser.fromJson(Map<String, dynamic> json) {
    return Cuser(
      uid: json['uid'],
      name: json['name'],
      lastName: json['lastName'],
      email: json['email'],
      role: json['role'],
      countryId: json['countryId'],
      phoneNumber: json['phoneNumber'],
    );
  }
}
