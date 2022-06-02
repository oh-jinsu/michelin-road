import 'package:michelin_road/application/models/review.dart';

class DisplayingReviewModel {
  final bool show;
  final ReviewModel model;

  const DisplayingReviewModel({
    required this.show,
    required this.model,
  });
}
