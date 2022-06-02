import 'package:codux/codux.dart';
import 'package:flutter/material.dart';
import 'package:michelin_road/application/events/location_found.dart';

class AppWaiterEffect extends Effect {
  AppWaiterEffect() {
    on<LocationFound>((event) {
      Navigator.of(requireContext()).pushReplacementNamed("/home");
    });
  }
}
