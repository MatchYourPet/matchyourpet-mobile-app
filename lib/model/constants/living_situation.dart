enum LivingSituation {
  FLAT,
  HOUSE,
  BIG_HOUSE;

  static getByString(String string) {
    if (string == 'FLAT') {
      return LivingSituation.FLAT;
    } else if (string == 'HOUSE') {
      return LivingSituation.HOUSE;
    } else {
      return LivingSituation.BIG_HOUSE;
    }
  }
}