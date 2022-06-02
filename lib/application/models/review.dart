class ReviewModel {
  final String id;
  final String restaurantName;
  final double latitude;
  final double longitude;
  final int rating;
  final String description;
  final DateTime updatedAt;
  final DateTime createdAt;

  const ReviewModel({
    required this.id,
    required this.rating,
    required this.restaurantName,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.updatedAt,
    required this.createdAt,
  });
}
