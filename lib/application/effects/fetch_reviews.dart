import 'package:codux/codux.dart';
import 'package:michelin_road/application/events/infrastructure_loaded.dart';
import 'package:michelin_road/application/events/reviews_found.dart';
import 'package:michelin_road/core/service_locator.dart';
import 'package:michelin_road/infrastructure/repositories/review.dart';

class FetchReviewsEffect extends Effect {
  FetchReviewsEffect() {
    on<InfrastructureLoaded>((event) async {
      final repository = ServiceLocator.find<ReviewRepository>();

      final models = await repository.find();

      dispatch(ReviewsFound(models));
    });
  }
}
