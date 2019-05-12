import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:vigilo_mobile/state.dart';

class CounterWidget extends StatelessWidget {
  CounterWidget(this.title, this.store);

  final String title;

  final Store<AppState> store;

  _increment() => store.dispatch(Count(this.title, CounterActions.Increment));

  _decrement() => store.dispatch(Count(this.title, CounterActions.Decrement));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RaisedButton(onPressed: _increment, child: Icon(Icons.arrow_upward)),
        new StoreConnector<AppState, int>(
          converter: (store) {
            if (store.state.counters.containsKey(title))
              return store.state.counters[title];
            else
              return 0;
          },
          builder: (context, count) => Text("$title: ${count ?? 0}"),
        ),
        RaisedButton(onPressed: _decrement, child: Icon(Icons.arrow_downward))
      ],
    );
  }
}
