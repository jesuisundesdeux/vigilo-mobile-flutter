import 'package:flutter/widgets.dart';
import 'package:vigilo_mobile/models/Models.dart';

import 'package:http/http.dart' as http;

import 'package:dependencies/dependencies.dart';

import 'dart:convert' as convert;

class ObservationToCreate {
  final Positon positon;
  final String address;
  final String comment;
  final String explanation;
  final int time;
  final int group;
  final int categorie;

  ObservationToCreate(
      {this.positon,
      this.address,
      this.comment,
      this.explanation,
      this.time,
      this.group,
      this.categorie});
}

class ObservationCreated {
  final String token;
  final String secretid;
  final int status;

  ObservationCreated(this.status, this.token, this.secretid);

  factory ObservationCreated.fromJson(Map<String, dynamic> parsedJson) =>
      new ObservationCreated(int.parse(parsedJson["status"]),
          parsedJson["token"], parsedJson["secretid"]);
}

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

  Future<ObservationsList> getObservations() => http
      .get(_root + "/get_issues.php?count=20&format=json")
      .then((response) =>
          ObservationsList.fromJson(convert.jsonDecode(response.body)));

  Image getImage(String token) =>
      Image.network(_root + "/generate_panel.php?token=$token");

  Future<CategoriesList> getCategories() => http
      .get(_root + "/get_categories_list.php")
      .then((reponse) => CategoriesList.fromJson(_asJson(reponse)));

  Future<bool> newObservation(ObservationToCreate obs) => http
      .post(_root + "/create_issue.php", body: {
        "coordinates_lat": obs.positon.lat,
        "coordinates_lon": obs.positon.lon,
        "address": obs.address,
        "comment": obs.comment,
        "explanation": obs.explanation,
        "categorie": obs.categorie,
        "time": obs.time
      })
      .then((response) => ObservationCreated.fromJson(_asJson(response)))
      .then((obs) => http
          .post(_root +
              "/add_image.php?token=${obs.token}&secredid=${obs.secretid}")
          .then((b) => true));
}
