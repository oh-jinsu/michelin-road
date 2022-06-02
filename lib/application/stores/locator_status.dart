import 'package:codux/codux.dart';
import 'package:michelin_road/application/events/current_location_canceled.dart';
import 'package:michelin_road/application/events/current_location_found.dart';
import 'package:michelin_road/application/events/current_location_pending.dart';
import 'package:michelin_road/application/models/location_status.dart';

const initialState = LocationStatusModel(isPending: false);

class LocatorStatusStore extends Store<LocationStatusModel> {
  LocatorStatusStore() : super(initialState: initialState) {
    on<CurrentLocationFound>((current, event) {
      return const LocationStatusModel(
        isPending: false,
      );
    });
    on<CurrentLocationPending>((current, event) {
      return const LocationStatusModel(isPending: true);
    });
    on<CurrentLocationCanceled>((current, event) {
      return const LocationStatusModel(isPending: false);
    });
  }
}
