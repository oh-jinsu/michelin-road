import 'package:michelin_road/core/new.dart';

class LocationStatusModel {
  final bool isPending;

  const LocationStatusModel({
    required this.isPending,
  });

  LocationStatusModel copy({
    New<bool>? isPending,
  }) {
    return LocationStatusModel(
      isPending: isPending != null ? isPending.value : this.isPending,
    );
  }
}
