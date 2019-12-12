import 'package:flutter/material.dart';

import 'tabs/counter.dart';
import 'tabs/myobs.dart';


import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:dependencies/dependencies.dart';

import 'package:vigilo_mobile/modules/Http.dart';



class VigiloApp extends StatelessWidget {
  VigiloApp();


  @override
  Widget build(BuildContext context) {
    ThemeData theme = ThemeData(
      primarySwatch: Colors.yellow,
    );
    return MaterialApp(
            title: 'Vigilo',
            theme: theme,
            home: new InjectorWidget(
                injector: Injector.fromModule(module: HttpModule()),
                child: DefaultTabController(
                  length: 3,
                  child: Scaffold(
                      appBar: AppBar(
                        title: Row(
                          children: <Widget>[
                            Image.asset("assets/images/jeSuisUnDesDeux.png",
                                width: 32),
                            SizedBox(width: 16),
                             DropdownButton(
                                    value: "Montpellier",
                                    items: [
                                      for (var city in [
                                        "Montpellier",
                                        "Toulouse"
                                      ])
                                        DropdownMenuItem<String>(
                                            value: city, child: Text(city))
                                    ],
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
                            child: CounterPage(),
                          )
                        ],
                      )),
                )));
  }
}
