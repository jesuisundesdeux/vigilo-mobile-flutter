import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

class CounterWidget extends StatelessWidget {
  CounterWidget(this.title);

  final String title;


  _increment(CounterBloc counterBloc) => ()  {
    counterBloc.dispatch(CounterEvent.increment);

  };

  _decrement(CounterBloc counterBloc) => (){
    counterBloc.dispatch(CounterEvent.decrement);
  };

  @override
  Widget build(BuildContext context) {

  final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);

    return Column(
      children: <Widget>[
        RaisedButton(onPressed: _increment(counterBloc), child: Icon(Icons.arrow_upward)),
        BlocBuilder<CounterBloc, int>(
          builder: (context, count) => Text("$title: ${count ?? 0}"),
        ),
        RaisedButton(onPressed: _decrement(counterBloc), child: Icon(Icons.arrow_downward))
      ],
    );
  }
}

enum CounterEvent {   increment, decrement }

class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.decrement:
        yield currentState - 1;
        break;
      case CounterEvent.increment:
        yield currentState + 1;
        break;
    }
  }
}

