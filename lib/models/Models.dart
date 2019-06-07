class Positon{
  final double lat;
  final double lon;

  Positon(this.lat, this.lon);

}

class Observation {
  String token;
  Positon positon;
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
      this.positon,
      this.address,
      this.comment,
      this.explanation,
      this.time,
      this.status,
      this.group,
      this.categorie,
      this.approved});

  factory Observation.fromJson(Map<String, dynamic> json) {
    return new Observation(
        token: json["token"],
        positon: Positon(double.parse(json["coordinates_lat"]),double.parse(json["coordinates_lon"])),
        address: json["address"],
        comment: json["comment"],
        explanation: json["explanation"],
        time: int.parse(json["time"]),
        status: int.parse(json["status"]),
        group: json["group"],
        categorie: int.parse(json["categorie"]),
        approved: int.parse(json["approved"]));
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
    List<Observation> observations =
        parsedJson.map((i) => Observation.fromJson(i)).toList();

    return new ObservationsList(
      observations: observations,
    );
  }
}

class Category {
  final int id;
  final String name;

  Category(this.id, this.name);

  factory Category.fromJson(Map<String, dynamic> parsedJson){
    return Category(
      parsedJson["catid"],
      parsedJson["catname"]
    );
  }

}

class CategoriesList {
  final Map<int,String> categories;

  CategoriesList(this.categories);

  factory CategoriesList.fromJson(List<dynamic> parsedJson) {

     List<Category> categories = parsedJson.map((c)=>Category.fromJson(c)).toList();
     Map<int, String> names = new Map();


     categories.forEach((c)=> names[c.id] = c.name);


     return new CategoriesList(names);
  }

}
