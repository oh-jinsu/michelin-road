import 'package:michelin_road/application/models/review.dart';

class ReviewMapper {
  static ReviewModel toModel(Map<String, dynamic> entity) {
    return ReviewModel(
      id: entity["id"],
      restaurantName: entity["restaurant_name"],
      latitude: entity["latitude"],
      longitude: entity["longitude"],
      rating: entity["rating"],
      description: entity["description"],
      updatedAt: DateTime.parse(entity["updated_at"]),
      createdAt: DateTime.parse(entity["created_at"]),
    );
  }
}
