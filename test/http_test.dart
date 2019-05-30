import 'package:http/http.dart' as http;

import 'dart:convert' as convert;

import 'package:vigilo_mobile/models/Models.dart';

main() async {
  // This example uses the Google Books API to search for books about http.
  // https://developers.google.com/books/docs/overview
  var url = "https://vigilo-beta.jesuisundesdeux.org/get_issues.php?format=json";

  // Await the http get response, then decode the json-formatted responce.
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    ObservationsList.fromJson(jsonResponse);
  } else {
    print("Request failed with status: ${response.statusCode}.");
  }
}