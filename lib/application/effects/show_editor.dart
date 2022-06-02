import 'package:codux/codux.dart';
import 'package:flutter/material.dart';
import 'package:michelin_road/application/events/edit_review_requested.dart';
import 'package:michelin_road/presentation/editor/modal.dart';

class ShowEditor extends Effect {
  ShowEditor() {
    on<EditReviewRequested>((event) {
      showModalBottomSheet(
        isScrollControlled: true,
        context: requireContext(),
        builder: (context) {
          return EditorModal(
            id: event.id,
            restaurantName: event.restaurantName,
            rating: event.rating,
            description: event.description,
            latitude: event.latitude,
            longitude: event.longitude,
          );
        },
      );
    });
  }
}
