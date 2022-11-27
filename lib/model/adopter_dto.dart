import 'package:intl/intl.dart';
import 'package:matchyourpet_mobile_app/model/constants/living_situation.dart';
import 'package:matchyourpet_mobile_app/model/constants/area.dart';

class AdopterDto {

  int id;
  String firstname;
  String surname;
  String password;
  String telephone;
  String userEmail;
  String description;
  DateTime birthday;
  LivingSituation livingSituation;
  Area area;
  bool garden;
  int householdSize;
  bool existingPets;
  List<String> messages = [];


  AdopterDto(this.id, this.firstname, this.surname, this.password, this.telephone,
      this.userEmail, this.description, this.birthday, this.livingSituation,
      this.area, this.garden, this.householdSize, this.existingPets);

  factory AdopterDto.fromJson(Map<String, dynamic> json) {
    return AdopterDto(
      json['id'],
      json['firstname'],
      json['surname'],
      json['password'],
      json['telephone'],
      json['userEmail'],
      json['description'],
      DateTime.parse(json['birthday']),
      LivingSituation.getByString(json['livingSituation']),
      Area.getByString(json['area']),
      json['garden'],
      json['householdSize'],
      json['existingPets']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'surname': surname,
      'password': password,
      'telephone': telephone,
      'userEmail': userEmail,
      'description': description,
      'birthday': DateFormat('yyyy-MM-dd').format(birthday),
      'livingSituation': livingSituation.stringValue,
      'area': area.stringValue,
      'garden': garden,
      'householdSize': householdSize,
      'existingPets': existingPets,
    };
  }

  @override
  String toString() {
    return 'Adopter{id: $id, firstname: $firstname, surname: $surname, password: $password, telephone: $telephone, userEmail: $userEmail, description: $description, birthday: $birthday, livingSituation: $livingSituation, area: $area, garden: $garden, householdSize: $householdSize, existingPets: $existingPets, messages: $messages}';
  }
}