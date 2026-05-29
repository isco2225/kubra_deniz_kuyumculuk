/// Kübra Deniz Kuyumculuk iletişim bilgileri.
class ShopContact {
  ShopContact._();

  static const String shopName = 'Kübra Deniz Kuyumculuk';

  static const String phoneDisplay = '0554 535 94 41';
  static const String phoneRaw = '905545359441';

  static const String address =
      'Kavacık, Fatih Sultan Mehmet Cd. 2 A, 34810 Beykoz/İstanbul';

  static const String workingHours = '08:30 – 19:30 (Pazar kapalı)';

  static const String instagramUrl =
      'https://www.instagram.com/kubradenizkuyumculuk/';

  static const String mapsUrl =
      'https://www.google.com/maps/search/?api=1&query='
      'Kavac%C4%B1k%2C+Fatih+Sultan+Mehmet+Cd.+2+A%2C+34810+Beykoz%2F%C4%B0stanbul';

  static String whatsAppUrl({String? message}) {
    final text = message != null ? '?text=${Uri.encodeComponent(message)}' : '';
    return 'https://wa.me/$phoneRaw$text';
  }

  static Uri get phoneUri => Uri.parse('tel:+905545359441');
}
