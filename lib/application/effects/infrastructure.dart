import 'package:codux/codux.dart';
import 'package:michelin_road/application/events/environment_loaded.dart';
import 'package:michelin_road/application/events/infrastructure_loaded.dart';
import 'package:michelin_road/core/service_locator.dart';
import 'package:michelin_road/infrastructure/instances/database.dart';
import 'package:michelin_road/infrastructure/repositories/location.dart';
import 'package:michelin_road/infrastructure/repositories/review.dart';

class InfrastructureEffect extends Effect {
  InfrastructureEffect() {
    on<EnvironmentLoaded>((event) async {
      await initializeDatabase();

      ServiceLocator.single<LocationRepository>(LocationRepository());
      ServiceLocator.single<ReviewRepository>(ReviewRepository());

      dispatch(const InfrastructureLoaded());
    });
  }
}
