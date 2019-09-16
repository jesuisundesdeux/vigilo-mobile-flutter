import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:vigilo_mobile/state.dart';
import 'package:bloc/bloc.dart';

class CounterWidget extends StatelessWidget {
  CounterWidget(this.title, this.store);

  final String title;

  final Store<AppState> store;

  _increment(CounterBloc counterBloc) => ()  {
    counterBloc.dispatch(CounterEvent.increment);
    store.dispatch(Count(this.title, CounterActions.Increment));
  };

  _decrement(CounterBloc counterBloc) => (){
    counterBloc.dispatch(CounterEvent.decrement);
    store.dispatch(Count(this.title, CounterActions.Decrement));
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

