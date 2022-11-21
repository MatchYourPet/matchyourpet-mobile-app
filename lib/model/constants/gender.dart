enum Gender {
  MALE(germanValue: 'Männlich'),
  FEMALE(germanValue: 'Weiblich'),
  UNKNOWN(germanValue: 'Geschlecht unbekannt');

  final String germanValue;

  const Gender({required this.germanValue});

  static getByString(String string) {
    if (string == 'MALE') {
      return Gender.MALE;
    } else if (string == 'FEMALE') {
      return Gender.FEMALE;
    } else {
      return Gender.UNKNOWN;
    }
  }

}