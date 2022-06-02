import 'package:codux/codux.dart';
import 'package:flutter/material.dart';
import 'package:michelin_road/application/events/first_location_found.dart';

class AppWaiterEffect extends Effect {
  AppWaiterEffect() {
    on<FirstLocationFound>((event) {
      Navigator.of(requireContext()).pushReplacementNamed("/home");
    });
  }
}
