import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeMap extends StatefulWidget {
  final CameraPosition cameraPosition;

  const HomeMap({
    Key? key,
    required this.cameraPosition,
  }) : super(key: key);

  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  final _controller = Completer<GoogleMapController>();

  @override
  void dispose() async {
    final controller = await _controller.future;

    controller.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant HomeMap oldWidget) {
    _animate();

    super.didUpdateWidget(oldWidget);
  }

  _animate() async {
    final controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(
      widget.cameraPosition,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: widget.cameraPosition,
      myLocationButtonEnabled: false,
      onMapCreated: (controller) => _controller.complete(controller),
    );
  }
}
