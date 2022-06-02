import 'package:codux/codux.dart';
import 'package:michelin_road/application/events/location_found.dart';
import 'package:michelin_road/application/models/location.dart';
import 'package:michelin_road/core/enum.dart';

class LocationStore extends Store<Option<LocationModel>> {
  LocationStore() : super() {
    on<LocationFound>((current, event) {
      final model = event.model;

      if (model == null) {
        return const None();
      }

      return Some(model);
    });
  }
}
