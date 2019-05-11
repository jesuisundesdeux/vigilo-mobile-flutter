import 'package:flutter/material.dart';

import 'dart:math';

import 'splashscreen.dart';
import 'state.dart';

import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

import 'VigiloApp.dart';

void main() async {
  final persistor = Persistor<AppState>(
    storage: FlutterStorage(),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
  );

  // Load initial state
  final initialState = await persistor.load();

  final store = Store<AppState>(
    reducer,
    initialState: initialState ?? AppState(),
    middleware: [persistor.createMiddleware()],
  );

  runApp(new MaterialApp(
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/homeScreen': (BuildContext) => new VigiloApp(store)
    },
  ));
}

AppState reducer(AppState state, Object o) {
  if (o is CitySelected) return state.copyWith(city: o.city);

  if (o is Count) {
    Map<String, int> counters = Map.from(state.counters);
    switch (o.action) {
      case CounterActions.Increment:
        counters.update(o.name, (v) => v + 1, ifAbsent: () => 1);
        break;
      case CounterActions.Decrement:
        counters.update(o.name, (v) => max(0, v - 1), ifAbsent: () => 0);
        break;
      case CounterActions.Reset:
        if (o.name == "") {
          counters.updateAll((k, v) => 0);
        } else
          counters.update(o.name, (v) => 0, ifAbsent: () => 0);
        break;
    }
    return state.copyWith(counters: counters);
  }
  return state;
}
