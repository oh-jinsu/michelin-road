class EditReviewRequested {
  final String id;
  final String restaurantName;
  final int rating;
  final String description;
  final double latitude;
  final double longitude;

  const EditReviewRequested({
    required this.id,
    required this.restaurantName,
    required this.rating,
    required this.description,
    required this.latitude,
    required this.longitude,
  });
}
