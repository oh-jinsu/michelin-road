import 'package:codux/codux.dart';
import 'package:michelin_road/application/events/map_touched.dart';
import 'package:michelin_road/application/events/review_deleted.dart';
import 'package:michelin_road/application/events/review_selected.dart';
import 'package:michelin_road/application/models/displaying_review.dart';
import 'package:michelin_road/core/enum.dart';

class SelectedReviewStore extends Store<Option<DisplayingReviewModel>> {
  SelectedReviewStore() : super(initialState: const None()) {
    on<ReviewSelected>((current, event) {
      return Some(DisplayingReviewModel(show: true, model: event.model));
    });
    on<MapTouched>((current, event) {
      if (!current.hasState) {
        return const None();
      }

      final state = current.state;

      if (state is! Some<DisplayingReviewModel>) {
        return current.state;
      }

      return Some(DisplayingReviewModel(show: false, model: state.value.model));
    });
    on<ReviewDeleted>((current, event) {
      if (!current.hasState) {
        return const None();
      }

      final state = current.state;

      if (state is! Some<DisplayingReviewModel>) {
        return current.state;
      }

      return Some(DisplayingReviewModel(show: false, model: state.value.model));
    });
  }
}
