enum Gender {
  MALE(germanValue: 'Männlich'),
  FEMALE(germanValue: 'Weiblich'),
  UNKNOWN(germanValue: 'Unbekannt');

  final String germanValue;

  const Gender({required this.germanValue});

  static getByString(String string) {
    if (string == "null") {
      return null;
    } else if (string == 'MALE' || string == 'Gender.MALE') {
      return Gender.MALE;
    } else if (string == 'FEMALE' || string == 'Gender.FEMALE') {
      return Gender.FEMALE;
    } else {
      return Gender.UNKNOWN;
    }
  }

  static List<Gender> getAll() {
    return [Gender.MALE, Gender.FEMALE, Gender.UNKNOWN];
  }

}