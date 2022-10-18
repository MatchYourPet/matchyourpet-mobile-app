class Shelter {
  int id;

  String name;

  String userEmail;

  String street;

  String postalCode;

  String city;

  String houseNumber;

  String door;

  String stair;

  String telephone;

  String contactPersonName;

  Shelter({
    required this.id,
    required this.name,
    required this.userEmail,
    required this.street,
    required this.postalCode,
    required this.city,
    required this.houseNumber,
    required this.door,
    required this.stair,
    required this.telephone,
    required this.contactPersonName});

  factory Shelter.fromJson(Map<String, dynamic> json) {
    return Shelter(
        id: json['id'],
        name: json['name'],
        userEmail: json['userEmail'],
        street: json['street'],
        postalCode: json['postalCode'],
        door: '',
        stair: '',
        telephone: json['telephone'],
        contactPersonName: json['contactPersonName'],
        houseNumber: json['houseNumber'],
        city: json['city']
    );
  }
}