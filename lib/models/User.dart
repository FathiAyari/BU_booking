class Cuser {
  String uid;
  String name;
  String lastName;
  String email;
  String role;
  String country;
  String phoneNumber;
  int status;

  Cuser({
    required this.uid,
    required this.name,
    required this.status,
    required this.lastName,
    required this.email,
    required this.role,
    required this.country,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'status': status,
      'lastName': lastName,
      'email': email,
      'role': role,
      'country': country,
      'phoneNumber': phoneNumber,
    };
  }

  factory Cuser.fromJson(Map<String, dynamic> json) {
    return Cuser(
      uid: json['uid'],
      status: json['status'],
      name: json['name'],
      lastName: json['lastName'],
      email: json['email'],
      role: json['role'],
      country: json['country'],
      phoneNumber: json['phoneNumber'],
    );
  }
}
