

import 'package:flutter/widgets.dart';
import 'package:vigilo_mobile/models/Models.dart';

import 'package:http/http.dart' as http;

import 'dart:convert' as convert;


class ObservationService {
  final String baseURL;

  ObservationService(this.baseURL);


  _asJson(http.Response response) => convert.jsonDecode(response.body);

  Future<ObservationsList> getObservations() =>
      http.get(baseURL + "/get_issues.php?count=20&format=json")
          .then((response)=>ObservationsList.fromJson(convert.jsonDecode(response.body)));

  Image getImage(String token) =>
      Image.network(baseURL+"/generate_panel.php?token=$token");

  Future<CategoriesList> getCategories() =>
        http.get(baseURL + "/get_categories_list.php")
      .then((reponse)=>CategoriesList.fromJson(_asJson(reponse)));
}