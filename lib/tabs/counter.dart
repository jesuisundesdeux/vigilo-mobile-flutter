import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'package:vigilo_mobile/CounterWidget.dart';
import 'package:vigilo_mobile/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              BlocProvider<CounterBloc>(
                  builder: (context) => CounterBloc(),
                  child: CounterWidget("Vélo", store)),
              BlocProvider<CounterBloc>(
                  builder: (context) => CounterBloc(),
                  child: CounterWidget("Trotinette", store)),
              BlocProvider<CounterBloc>(
                  builder: (context) => CounterBloc(),
                  child: CounterWidget("GCUM", store))
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
