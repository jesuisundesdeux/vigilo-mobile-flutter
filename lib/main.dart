import 'package:flutter/material.dart';

import 'splashscreen.dart';
import 'tabs/counter.dart';
import 'tabs/myobs.dart';


void main() => runApp(new MaterialApp(
      home: new SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/homeScreen': (BuildContext) => new VigiloApp()
      },
    ));

class VigiloApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    ThemeData theme = ThemeData(
      primarySwatch: Colors.yellow,
    );
    return MaterialApp(
        title: 'Vigilo',
        theme: theme,
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Row(
                children: <Widget>[
                  Image.asset("assets/images/jeSuisUnDesDeux.png", width: 32),
                  SizedBox(width: 16),
                  Text(
                    "Montpellier",
                  ),
                ],
              ),
              bottom: TabBar(isScrollable: true, tabs: <Widget>[
                Tab(
                  text: "Bicycle",
                  icon: Icon(Icons.directions_bike),
                ),
                Tab(
                  text: "Observation",
                  icon: Icon(Icons.local_see),
                ),
                Tab(
                  text: "Counter",
                  icon: Icon(Icons.plus_one),
                )
              ]),
            ),
            body: TabBarView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Bike"),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: ObservationWidget(theme),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: CounterPage(title: "Montpellier"),
                )
              ],
            )
          ),
        ));
  }
}
