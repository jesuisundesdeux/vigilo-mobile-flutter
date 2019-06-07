import 'package:flutter/material.dart';

import 'tabs/counter.dart';
import 'tabs/myobs.dart';
import 'state.dart';

import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vigilo_mobile/modules/Http.dart';

import 'package:redux/redux.dart';

class VigiloApp extends StatelessWidget {
  VigiloApp(this.store);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = ThemeData(
      primarySwatch: Colors.yellow,
    );
    return StoreProvider(
        store: store,
        child: MaterialApp(
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
                            StoreConnector<AppState, Function>(
                              // Return a function to dispatch an increment action
                              converter: (store) => (String value) =>
                                  store.dispatch(CitySelected(value)),
                              builder: (_, sel) => DropdownButton(
                                    value: store.state.city,
                                    onChanged: (String newValue) {
                                      sel(newValue);
                                    },
                                    items: [
                                      for (var city in [
                                        "Montpellier",
                                        "Toulouse"
                                      ])
                                        DropdownMenuItem<String>(
                                            value: city, child: Text(city))
                                    ],
                                  ),
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
                            child: CounterPage(store),
                          )
                        ],
                      )),
                ))));
  }
}
