import 'package:codux/codux.dart';
import 'package:michelin_road/application/events/current_location_found.dart';
import 'package:michelin_road/application/models/location.dart';
import 'package:michelin_road/core/enum.dart';

class CurrentLocationStore extends Store<Option<LocationModel>> {
  CurrentLocationStore() : super(initialState: const None()) {
    on<CurrentLocationFound>((current, event) {
      final model = event.model;

      if (model == null) {
        return const None();
      }

      return Some(model);
    });
  }
}
