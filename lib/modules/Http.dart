import "package:dependencies/dependencies.dart";

import 'package:vigilo_mobile/services/Observation.dart';

class HttpModule implements Module {
  @override
  void configure(Binder binder) {
    binder
      ..bindSingleton("https://vigilo-beta.jesuisundesdeux.org", name: "api_root")
      ..bindLazySingleton<ObservationService>((i, p) => ObservationServiceImpl(i));
  }
}