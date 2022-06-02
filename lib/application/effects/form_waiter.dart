import 'package:codux/codux.dart';
import 'package:flutter/material.dart';
import 'package:michelin_road/application/events/review_added.dart';
import 'package:michelin_road/application/events/review_updated.dart';

class FormWaiterEffect extends Effect {
  FormWaiterEffect() {
    on<ReviewUpdated>((event) {
      Navigator.of(requireContext()).pop();
    });
    on<ReviewAdded>((event) {
      Navigator.of(requireContext()).pop();
    });
  }
}
