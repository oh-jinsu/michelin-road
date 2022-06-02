import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeMap extends StatefulWidget {
  final LatLng? initial;
  final LatLng? current;
  final Iterable<Marker> markers;
  final void Function(LatLng position)? onCurrentMoved;

  const HomeMap(
      {Key? key,
      required this.initial,
      required this.current,
      this.markers = const [],
      this.onCurrentMoved})
      : super(key: key);

  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  double _zoom = 16.0;

  final _controller = Completer<GoogleMapController>();

  Set<Marker> get markers {
    final target = widget.current;

    if (target == null) {
      return {...widget.markers};
    }

    final marker = Marker(
      draggable: true,
      markerId: const MarkerId("current_location"),
      position: LatLng(target.latitude, target.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      onDragEnd: widget.onCurrentMoved,
      zIndex: 99.9,
    );

    return {...widget.markers, marker};
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
    final target = widget.current;

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
        target: widget.initial ?? const LatLng(37.583695, 127.001327),
        zoom: _zoom,
      ),
      myLocationButtonEnabled: false,
      onMapCreated: (controller) => _controller.complete(controller),
      markers: markers,
      onCameraMove: (position) {
        _zoom = position.zoom;
      },
    );
  }
}
