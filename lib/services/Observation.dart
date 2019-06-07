

import 'package:flutter/widgets.dart';
import 'package:vigilo_mobile/models/Models.dart';

import 'package:http/http.dart' as http;

import 'package:dependencies/dependencies.dart';

import 'dart:convert' as convert;



abstract class ObservationService {

  Future<ObservationsList> getObservations();

  Image getImage(String token);

  Future<CategoriesList> getCategories();

}

class ObservationServiceImpl extends ObservationService {


  final Injector _injector;


  String get _root => _injector.get<String>(name: "api_root");

  ObservationServiceImpl(this._injector);


  _asJson(http.Response response) => convert.jsonDecode(response.body);

  Future<ObservationsList> getObservations() =>
      http.get(_root + "/get_issues.php?count=20&format=json")
          .then((response)=>ObservationsList.fromJson(convert.jsonDecode(response.body)));

  Image getImage(String token) =>
      Image.network(_root+"/generate_panel.php?token=$token");

  Future<CategoriesList> getCategories() =>
        http.get(_root + "/get_categories_list.php")
      .then((reponse)=>CategoriesList.fromJson(_asJson(reponse)));
}