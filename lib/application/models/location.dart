import 'package:michelin_road/core/new.dart';

class LocationModel {
  final double latitude;
  final double longitude;

  const LocationModel({
    required this.latitude,
    required this.longitude,
  });

  LocationModel copy({
    New<double>? latitude,
    New<double>? longitude,
  }) {
    return LocationModel(
      latitude: latitude != null ? latitude.value : this.latitude,
      longitude: longitude != null ? longitude.value : this.longitude,
    );
  }
}
