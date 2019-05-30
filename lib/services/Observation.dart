import 'package:vigilo_mobile/models/Models.dart';

import 'package:http/http.dart' as http;

import 'dart:convert' as convert;


class ObservationService {
  final String baseURL;

  ObservationService(this.baseURL);

  Future<ObservationsList> getObservations() =>
      http.get(baseURL + "/get_issues.php?count=10&format=json")
          .then((response)=>ObservationsList.fromJson(convert.jsonDecode(response.body)));

}