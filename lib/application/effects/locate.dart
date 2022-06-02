import 'package:codux/codux.dart';
import 'package:location/location.dart';
import 'package:michelin_road/application/events/app_started.dart';
import 'package:michelin_road/application/events/location_found.dart';
import 'package:michelin_road/application/events/location_pending.dart';
import 'package:michelin_road/application/events/location_requested.dart';

class LocateEffect extends Effect {
  LocateEffect() {
    on<AppStarted>((event) => _execute());
    on<LocationRequested>((event) => _execute());
  }

  void _execute() async {
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

    dispatch(LocationFound(latitude: latitude, longitude: longitude));
  }
}
