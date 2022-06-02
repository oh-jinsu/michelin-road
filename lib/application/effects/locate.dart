import 'package:codux/codux.dart';
import 'package:location/location.dart';
import 'package:michelin_road/application/events/infrastructure_loaded.dart';
import 'package:michelin_road/application/events/location_found.dart';
import 'package:michelin_road/application/events/location_pending.dart';
import 'package:michelin_road/application/events/location_requested.dart';
import 'package:michelin_road/core/service_locator.dart';
import 'package:michelin_road/infrastructure/repositories/location.dart';

class LocateEffect extends Effect {
  LocateEffect() {
    on<InfrastructureLoaded>((event) async {
      final locationRepository = ServiceLocator.find<LocationRepository>();

      final recentOne = await locationRepository.findRecentOne();

      if (recentOne == null) {
        return dispatch(const LocationFound(null));
      }

      return dispatch(LocationFound(recentOne));
    });
    on<LocationRequested>((event) async {
      dispatch(const LocationPending());

      final LocationData location;

      try {
        location = await Location().getLocation();
      } catch (e) {
        return;
      }

      final latitude = location.latitude;

      final longitude = location.longitude;

      if (latitude == null || longitude == null) {
        return;
      }

      final locationRepository = ServiceLocator.find<LocationRepository>();

      final locationModel = await locationRepository.save(
        latitude: latitude,
        longitude: longitude,
      );

      dispatch(LocationFound(locationModel));
    });
  }
}
