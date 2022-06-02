import 'package:codux/codux.dart';
import 'package:michelin_road/application/events/form_pending.dart';
import 'package:michelin_road/application/events/form_submitted.dart';
import 'package:michelin_road/application/events/review_added.dart';
import 'package:michelin_road/core/service_locator.dart';
import 'package:michelin_road/infrastructure/repositories/review.dart';

class SubmitFormEffect extends Effect {
  SubmitFormEffect() {
    on<FormSubmitted>((event) async {
      dispatch(const FormPending());

      final repository = ServiceLocator.find<ReviewRepository>();

      final model = await repository.save(
        restaurantName: event.restaurantName,
        latitude: event.latitude,
        longitude: event.longitude,
        rating: event.rating,
        description: event.description,
      );

      dispatch(ReviewAdded(model));
    });
  }
}
