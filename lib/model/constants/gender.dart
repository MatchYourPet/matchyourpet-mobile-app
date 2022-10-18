enum Gender {
  MALE,
  FEMALE,
  UNKNOWN;

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