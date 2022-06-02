import 'package:codux/codux.dart';
import 'package:michelin_road/application/events/location_canceled.dart';
import 'package:michelin_road/application/events/location_found.dart';
import 'package:michelin_road/application/events/location_pending.dart';
import 'package:michelin_road/application/models/location_status.dart';

class LocationStatusStore extends Store<LocationStatusModel> {
  LocationStatusStore() : super() {
    on<LocationFound>((current, event) {
      return const LocationStatusModel(
        isPending: false,
      );
    });
    on<LocationPending>((current, event) {
      return const LocationStatusModel(isPending: true);
    });
    on<LocationCanceled>((current, event) {
      return const LocationStatusModel(
        isPending: false,
      );
    });
  }
}
