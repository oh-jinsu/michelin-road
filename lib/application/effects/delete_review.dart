import 'package:codux/codux.dart';
import 'package:michelin_road/application/events/delete_review_requested.dart';
import 'package:michelin_road/application/events/review_deleted.dart';
import 'package:michelin_road/core/service_locator.dart';
import 'package:michelin_road/infrastructure/repositories/review.dart';

class DeleteReviewEffect extends Effect {
  DeleteReviewEffect() {
    on<DeleteReviewRequested>((event) async {
      final repository = ServiceLocator.find<ReviewRepository>();

      await repository.delete(event.id);

      dispatch(ReviewDeleted(event.id));
    });
  }
}
