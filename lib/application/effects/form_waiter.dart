import 'package:codux/codux.dart';
import 'package:flutter/material.dart';
import 'package:michelin_road/application/events/review_added.dart';

class FormWaiterEffect extends Effect {
  FormWaiterEffect() {
    on<ReviewAdded>((event) {
      Navigator.of(requireContext()).pop();
    });
  }
}
