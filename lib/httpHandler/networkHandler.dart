// ignore_for_file: file_names

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkHandler {
  String baseUrl = "http:// 192.168.11.167:5000/";

  var log = Logger();

  Future<dynamic> get(String url) async {
    url = formatter(url);

    var response = await http.get(Uri.parse(url));
    print("sda");
    log.i(response.body);
    log.i(response.statusCode);
  }

  String formatter(String url) {
    return baseUrl + url;
  }
}
