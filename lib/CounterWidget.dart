import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

enum Actions { Increment, Decrement, Reset }


class Count{
  Count(this.name, this.action);
  final String name;
  final Actions action;
}


class CounterWidget extends StatefulWidget {
  CounterWidget(this.title, this.store);

  final String title;

  final Store<Map<String, int>> store;

  void reset() => _CounterState;

  @override
  _CounterState createState() => new _CounterState(title, store);
}

class _CounterState extends State<CounterWidget> {
  _CounterState(this.title, this.store){
    store.state.putIfAbsent(title, ()=>0);
  }

  final String title;

  final Store<Map<String, int>> store;

    
  
  _increment() => setState(() => store.dispatch(Count(this.title, Actions.Increment)));

  _decrement() => setState(() => store.dispatch(Count(this.title, Actions.Decrement)));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

            RaisedButton(onPressed: _increment, child: Icon(Icons.arrow_upward)),
            new StoreConnector<Map<String,int>, String>(
              converter: (store) => store.state[title].toString(),
              builder: (context, count) =>Text("$title: ${count}"),
            )
            ,
            
            RaisedButton(onPressed: _decrement, child: Icon(Icons.arrow_downward))
          ],
    );
  }
}
