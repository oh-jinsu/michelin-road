import 'package:codux/codux.dart';
import 'package:michelin_road/application/events/location_found.dart';
import 'package:michelin_road/application/models/location.dart';

class LocationStore extends Store<LocationModel> {
  LocationStore() : super() {
    on<LocationFound>((current, event) {
      return LocationModel(
        latitude: event.latitude,
        longitude: event.longitude,
      );
    });
  }
}
