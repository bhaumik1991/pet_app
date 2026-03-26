import 'dart:io';

class Config {
  static String get baseUrl {
    if (Platform.isAndroid) {
      return "http://10.0.2.2:3000";
    } else if (Platform.isIOS) {
      return "http://localhost:3000";
    } else {
      return "http://localhost:3000";
    }
  }
}