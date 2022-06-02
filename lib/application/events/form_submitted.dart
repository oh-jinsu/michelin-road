class FormSubmitted {
  final double latitude;
  final double longitude;
  final String restaurantName;
  final String description;
  final int rating;

  const FormSubmitted({
    required this.latitude,
    required this.longitude,
    required this.restaurantName,
    required this.description,
    required this.rating,
  });
}
