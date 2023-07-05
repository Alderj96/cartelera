import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  static String movieDBKey = dotenv.env['APIKEY'] ?? '';
  static String movieDBBaseUrl = dotenv.env['BASEURL'] ?? '';
  static String movieDBLanguage = dotenv.env['LANGUAGE'] ?? '';
}