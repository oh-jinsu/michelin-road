import 'package:codux/codux.dart';
import 'package:michelin_road/application/events/review_added.dart';
import 'package:michelin_road/application/events/review_deleted.dart';
import 'package:michelin_road/application/events/review_updated.dart';
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
    on<ReviewDeleted>((current, event) {
      return current.state.where((element) => element.id != event.id).toList();
    });
    on<ReviewUpdated>((current, event) {
      return current.state.map((e) {
        if (e.id != event.model.id) {
          return e;
        }

        return event.model;
      }).toList();
    });
  }
}
