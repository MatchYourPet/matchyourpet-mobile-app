enum Gender {
  MALE(germanValue: 'Männlich', stringValue: 'MALE'),
  FEMALE(germanValue: 'Weiblich', stringValue: 'FEMALE'),
  UNKNOWN(germanValue: 'Unbekannt', stringValue: 'UNKOWN');

  final String germanValue;

  final String stringValue;

  const Gender({required this.germanValue, required this.stringValue});

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