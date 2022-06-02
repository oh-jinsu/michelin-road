import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeMap extends StatefulWidget {
  final LatLng? target;

  const HomeMap({
    Key? key,
    required this.target,
  }) : super(key: key);

  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  static const _zoom = 17.0;

  final _controller = Completer<GoogleMapController>();

  Set<Marker> get markers {
    final target = widget.target;

    if (target == null) {
      return {};
    }

    final marker = Marker(
      draggable: true,
      markerId: const MarkerId("current_location"),
      position: LatLng(target.latitude, target.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      infoWindow: const InfoWindow(title: "현위치"),
    );

    return {marker};
  }

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

  void _animate() async {
    final target = widget.target;

    if (target == null) {
      return;
    }

    final controller = await _controller.future;

    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: _zoom),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: widget.target ?? const LatLng(37.583695, 127.001327),
        zoom: _zoom,
      ),
      myLocationButtonEnabled: false,
      onMapCreated: (controller) => _controller.complete(controller),
      markers: markers,
    );
  }
}
