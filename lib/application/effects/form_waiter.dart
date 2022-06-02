import 'package:codux/codux.dart';
import 'package:flutter/material.dart';
import 'package:michelin_road/application/events/form_committed.dart';

class FormWaiterEffect extends Effect {
  FormWaiterEffect() {
    on<FormCommitted>((event) {
      Navigator.of(requireContext()).pop();
    });
  }
}
