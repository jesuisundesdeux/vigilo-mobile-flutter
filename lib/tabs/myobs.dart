import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'newobs.dart';

import 'package:vigilo_mobile/models/Models.dart';
import 'package:vigilo_mobile/services/Observation.dart';

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

  final ObservationService _observationService =
      new ObservationService("https://vigilo-beta.jesuisundesdeux.org");

  ObservationsList observations = ObservationsList.empty();


  void initState() {
    super.initState();

    _observationService.getCategories()
      .asStream().forEach((cl)=>"");

  }

  refresh() => _observationService
      .getObservations()
      .asStream()
      .forEach((observations) => setState(() {
            this.observations = observations;
          }));

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
          itemCount: observations.observations.length,
          itemBuilder: (context, index) {
            Observation obs = observations.observations[index];
            return ListTile(leading: _observationService.getImage(obs.token),
                title: Text(obs.token),
                subtitle: Text(new DateFormat().format(new DateTime.fromMillisecondsSinceEpoch(1000*obs.time))));
          },
        ),
        floatingActionButton: new FloatingActionButton(
            child: Icon(Icons.add_a_photo),
            onPressed: () async {
              _addObs(context, theme);
            }),
      );
}
