class Observation {
  String token;
  double coordinates_lat;
  double coordinates_lon;
  String address;
  String comment;
  String explanation;
  int time;
  int status;
  int group;
  int categorie;
  int approved;

  Observation(
      {this.token,
      this.coordinates_lat,
      this.coordinates_lon,
      this.address,
      this.comment,
      this.explanation,
      this.time,
      this.status,
      this.group,
      this.categorie,
      this.approved});


  factory Observation.fromJson(Map<String, dynamic> json){
    return new Observation(
        token:json["token"],
        coordinates_lat : double.parse(json["coordinates_lat"]),
        coordinates_lon: double.parse(json["coordinates_lon"]),
        address: json["address"],
        comment: json["comment"],
        explanation: json["explanation"],
        time: int.parse(json["time"]),
        status: int.parse(json["status"]),
        group: json["group"],
        categorie: int.parse(json["categorie"]),
        approved: int.parse(json["approved"])
    );
  }

}


class ObservationsList {
  final List<Observation> observations;

  ObservationsList({
    this.observations,
  });

  factory ObservationsList.empty() {
    return new ObservationsList(
      observations: new List<Observation>(),
    );
  }


    factory ObservationsList.fromJson(List<dynamic> parsedJson) {

    List<Observation> observations = parsedJson.map((i)=>Observation.fromJson(i)).toList();

    return new ObservationsList(
      observations: observations,
    );
  }
}
