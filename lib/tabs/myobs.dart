import 'package:flutter/material.dart';

import 'newobs.dart';

class ObservationWidget extends StatefulWidget {

  ObservationWidget(this.theme, {Key key}) : super(key: key);

  
  final ThemeData theme;

  @override
  _ObservationState createState() => new _ObservationState(theme);
}

Future<int> _addObs(BuildContext context, ThemeData theme) async {
    return await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return NewObservation(theme);
        });
  }

class _ObservationState extends State<ObservationWidget> {

 _ObservationState(this.theme);

   final ThemeData theme;

  int count = 1;

  refresh() => setState((){
    count++;
  });

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: refresh,
          )
        ],
      ),
      body: ListView.builder(
        itemCount: count,
        itemBuilder: (context, index) {
          return ListTile(title: Text("item $index"));
        },
      )
      ,
            floatingActionButton: new FloatingActionButton(
                child: Icon(Icons.add_a_photo),
                onPressed: () async {
                  _addObs(context, theme);
                }),);
}
