enum CounterActions { Increment, Decrement, Reset }

class Count {
  Count(this.name, this.action);

  final String name;
  final CounterActions action;
}

class CitySelected {
  CitySelected(this.city);

  String city;
}

class AppState {
  String city;

  Map<String, int> counters;

  AppState({this.counters, this.city});

  AppState copyWith({String city, Map<String, int> counters}) =>
      AppState(city: city ?? this.city, counters: counters ?? this.counters);

  static AppState fromJson(dynamic json) {
    if (json != null) {
      var co = json["counters"] as Map<String, dynamic>;
      if (co == null) co = Map();
      return AppState(
          city: json["city"] as String,
          counters: co.map((k, v) => MapEntry(k, v as int)));
    } else {
      return AppState(counters: Map());
    }
  }

  dynamic toJson() => {'city': city, 'counters': counters};
}
