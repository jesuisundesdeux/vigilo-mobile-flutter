import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'package:vigilo_mobile/CounterWidget.dart';
import 'package:vigilo_mobile/state.dart';

class CounterPage extends StatelessWidget {
  CounterPage(this.store, {Key key}) : super(key: key);

  final Store<AppState> store;

  void _resetCounters() => store.dispatch(Count("", CounterActions.Reset));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        );
  }
}
