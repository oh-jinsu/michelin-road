import 'package:codux/codux.dart';
import 'package:michelin_road/application/events/camera_moved.dart';
import 'package:michelin_road/application/events/location_adjusted.dart';
import 'package:michelin_road/application/models/location.dart';
import 'package:michelin_road/infrastructure/instances/uuid.dart';

class AdjustLocationEffect extends Effect {
  AdjustLocationEffect() {
    on<CameraMoved>((event) {
      final model = LocationModel(
        id: uuid.v1(),
        title: null,
        latitude: event.latitude,
        longitude: event.longitude,
        createdAt: DateTime.now(),
      );

      dispatch(LocationAdjusted(model));
    });
  }
}
