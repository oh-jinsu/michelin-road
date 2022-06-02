import 'package:codux/codux.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:michelin_road/application/events/app_started.dart';
import 'package:michelin_road/application/events/environment_loaded.dart';

class EnvironmentEffect extends Effect {
  EnvironmentEffect() {
    on<AppStarted>((event) async {
      await dotenv.load();

      dispatch(const EnvironmentLoaded());
    });
  }
}
