enum Area {
  LANDSLIDE(germanValue: 'ländlicher Raum', stringValue: 'LANDSLIDE'),
  CITY(germanValue: 'Stadt', stringValue: 'CITY');

  final String germanValue;

  final String stringValue;

  const Area({required this.germanValue, required this.stringValue});



  static getByString(String string) {
    if (string == 'LANDSLIDE') {
      return Area.LANDSLIDE;
    } else {
      return Area.CITY;
    }
  }

  static List<Area> getAll() {
    return [CITY, LANDSLIDE];
  }
}