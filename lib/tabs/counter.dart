import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:vigilo_mobile/CounterWidget.dart';

class CounterPage extends StatefulWidget {
  CounterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CounterPageState createState() => _CounterPageState();
}

Map<String, int> counterReducer(Map<String, int> state, dynamic o) {

  switch (o.action) {
    case Actions.Increment:
      state.update(o.name, (v) => v + 1, ifAbsent: () => 1);
      break;
    case Actions.Decrement:
      state.update(o.name, (v) => max(0,v - 1), ifAbsent: () => 0);
      break;
    case Actions.Reset:
      if(o.name == ""){
        state.updateAll((k,v) => 0);
      }else
      state.update(o.name, (v) => 0, ifAbsent: () => 0);
      break;
  }
  return state;
}

class _CounterPageState extends State<CounterPage> {
  Store<Map<String, int>> store =
      new Store<Map<String, int>>(counterReducer, initialState: Map());

  void _resetCounters() => store.dispatch(Count("", Actions.Reset));

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<Map<String, int>>(
        // Pass the store to the StoreProvider. Any ancestor `StoreConnector`
        // Widgets will find and use this value as the `Store`.
        store: store,
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(children: <Widget>[
                  CounterWidget("Vélo", store),
                  CounterWidget("Trotinette", store),
                  CounterWidget("GCUM", store)
                ]),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _resetCounters,
            tooltip: 'Reset',
            child: Icon(Icons.refresh),
          ),
        ));
  }
}
