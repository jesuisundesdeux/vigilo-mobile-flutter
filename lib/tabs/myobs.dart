import 'package:flutter/material.dart';

class ObservationWidget extends StatefulWidget {
  ObservationWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ObservationState createState() => new _ObservationState();
}

class _ObservationState extends State<ObservationWidget> {

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
      ));
}
