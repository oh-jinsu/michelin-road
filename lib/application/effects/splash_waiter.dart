import 'package:codux/codux.dart';
import 'package:flutter/material.dart';
import 'package:michelin_road/application/events/location_found.dart';

class SplashWaiterEffect extends Effect {
  SplashWaiterEffect() {
    on<LocationFound>((event) {
      Navigator.of(requireContext()).pushReplacementNamed("/home");
    });
  }
}
