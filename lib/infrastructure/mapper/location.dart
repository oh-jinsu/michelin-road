import 'package:michelin_road/application/models/location.dart';

class LocationMapper {
  static LocationModel toModel(Map<String, dynamic> entity) {
    return LocationModel(
      id: entity["id"],
      title: null,
      latitude: entity["latitude"],
      longitude: entity["longitude"],
      createdAt: DateTime.parse(entity["created_at"]),
    );
  }
}
