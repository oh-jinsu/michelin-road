import 'package:codux/codux.dart';
import 'package:michelin_road/application/events/review_added.dart';
import 'package:michelin_road/application/events/reviews_found.dart';
import 'package:michelin_road/application/models/review.dart';

class MapStore extends Store<List<ReviewModel>> {
  MapStore() {
    on<ReviewsFound>((current, event) {
      return event.models;
    });
    on<ReviewAdded>((current, event) {
      if (current.hasState) {
        return [...current.state, event.model];
      }

      return [event.model];
    });
  }
}
