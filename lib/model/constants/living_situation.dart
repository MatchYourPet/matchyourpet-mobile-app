enum LivingSituation {
  FLAT(germanValue: 'Wohnung', stringValue: 'FLAT'),
  HOUSE(germanValue: 'Haus', stringValue: 'HOUSE'),
  BIG_HOUSE(germanValue: 'Großes Haus', stringValue: 'BIG_HOUSE');

  final String germanValue;

  final String stringValue;

  const LivingSituation({required this.germanValue, required this.stringValue});



  static getByString(String string) {
    if (string == 'FLAT') {
      return LivingSituation.FLAT;
    } else if (string == 'HOUSE') {
      return LivingSituation.HOUSE;
    } else {
      return LivingSituation.BIG_HOUSE;
    }
  }

  static List<LivingSituation> getAll() {
    return [FLAT, HOUSE, BIG_HOUSE];
  }
}