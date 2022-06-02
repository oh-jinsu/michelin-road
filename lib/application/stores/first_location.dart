import 'package:codux/codux.dart';
import 'package:michelin_road/application/events/first_location_found.dart';
import 'package:michelin_road/application/models/location.dart';
import 'package:michelin_road/core/enum.dart';

class FirstLocationStore extends Store<Option<LocationModel>> {
  FirstLocationStore() : super() {
    on<FirstLocationFound>((current, event) {
      final model = event.model;

      if (model == null) {
        return const None();
      }

      return Some(model);
    });
  }
}
