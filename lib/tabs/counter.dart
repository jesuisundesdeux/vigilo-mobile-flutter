import 'package:flutter/material.dart';


import 'package:vigilo_mobile/CounterWidget.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  CounterPage( {Key key}) : super(key: key);

  

  void _resetCounters() => {};

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
                  child: CounterWidget("Vélo")),
              BlocProvider<CounterBloc>(
                  builder: (context) => CounterBloc(),
                  child: CounterWidget("Trotinette")),
              BlocProvider<CounterBloc>(
                  builder: (context) => CounterBloc(),
                  child: CounterWidget("GCUM"))
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
