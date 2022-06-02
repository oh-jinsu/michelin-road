import 'package:codux/codux.dart';
import 'package:michelin_road/application/events/current_location_found.dart';
import 'package:michelin_road/application/events/location_adjusted.dart';
import 'package:michelin_road/application/models/location.dart';

class AdjustedLocationStore extends Store<LocationModel> {
  AdjustedLocationStore() {
    on<CurrentLocationFound>((current, event) {
      return event.model;
    });
    on<LocationAdjusted>((current, event) {
      return event.model;
    });
  }
}
