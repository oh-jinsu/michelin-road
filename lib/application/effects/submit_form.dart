import 'package:codux/codux.dart';
import 'package:michelin_road/application/events/form_pending.dart';
import 'package:michelin_road/application/events/form_submitted.dart';
import 'package:michelin_road/application/events/review_added.dart';
import 'package:michelin_road/application/events/review_selected.dart';
import 'package:michelin_road/application/events/review_updated.dart';
import 'package:michelin_road/application/models/review.dart';
import 'package:michelin_road/core/service_locator.dart';
import 'package:michelin_road/infrastructure/repositories/review.dart';

class SubmitFormEffect extends Effect {
  SubmitFormEffect() {
    on<FormSubmitted>((event) async {
      dispatch(const FormPending());

      final repository = ServiceLocator.find<ReviewRepository>();

      late final ReviewModel model;

      if (event.id != null) {
        model = await repository.update(
          event.id!,
          restaurantName: event.restaurantName,
          rating: event.rating,
          description: event.description,
        );

        dispatch(ReviewUpdated(model));
      } else {
        model = await repository.save(
          restaurantName: event.restaurantName,
          latitude: event.latitude,
          longitude: event.longitude,
          rating: event.rating,
          description: event.description,
        );

        dispatch(ReviewAdded(model));
      }

      dispatch(ReviewSelected(model));
    });
  }
}
