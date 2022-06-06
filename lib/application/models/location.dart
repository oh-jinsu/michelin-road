import 'package:michelin_road/core/new.dart';

class LocationModel {
  final String id;
  final String? title;
  final double latitude;
  final double longitude;
  final DateTime createdAt;

  const LocationModel({
    required this.id,
    required this.title,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
  });

  LocationModel copy({
    New<String?>? title,
    New<double>? latitude,
    New<double>? longitude,
    New<DateTime>? createdAt,
  }) {
    return LocationModel(
      id: id,
      title: title != null ? title.value : this.title,
      latitude: latitude != null ? latitude.value : this.latitude,
      longitude: longitude != null ? longitude.value : this.longitude,
      createdAt: createdAt != null ? createdAt.value : this.createdAt,
    );
  }
}
