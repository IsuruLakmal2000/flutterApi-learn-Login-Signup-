// ignore_for_file: file_names

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkHandler {
  String baseUrl = "https://murmuring-river-93706.herokuapp.com/";

  var log = Logger();

  Future<dynamic> get(String url) async {
    url = formatter(url);

    var response = await http
        .get(Uri.parse("https://murmuring-river-93706.herokuapp.com/"));
    //print("sda");
    log.i(response.body);
    log.i(response.statusCode);
  }

  Future<dynamic> post(String url, Map<String, String> body) async {
    url = formatter(url);

    var response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);
      return response;
    }
    log.d(response.body);
    log.d(response.statusCode);
  }

  String formatter(String url) {
    return baseUrl + url;
  }
}
