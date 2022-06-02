import 'package:codux/codux.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:michelin_road/application/models/location.dart';
import 'package:michelin_road/application/models/review.dart';
import 'package:michelin_road/application/stores/first_location.dart';
import 'package:michelin_road/application/stores/current_location.dart';
import 'package:michelin_road/application/stores/map.dart';
import 'package:michelin_road/core/enum.dart';
import 'package:michelin_road/presentation/home/widgets/map.dart';

class Viewer extends Component {
  const Viewer({Key? key}) : super(key: key);

  @override
  Widget render(BuildContext context) {
    return StreamBuilder(
      stream: find<CurrentLocationStore>().stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final initialData = find<FirstLocationStore>().stream.value;

          final initial = initialData is Some<LocationModel>
              ? LatLng(initialData.value.latitude, initialData.value.longitude)
              : null;

          final currentData = snapshot.data as Option<LocationModel>;

          final current = currentData is Some<LocationModel>
              ? LatLng(currentData.value.latitude, currentData.value.longitude)
              : null;

          return StreamBuilder(
            stream: find<MapStore>().stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final reviews = snapshot.data as List<ReviewModel>;

                final markers = reviews.map(
                  (e) => Marker(
                    markerId: MarkerId(e.id),
                    position: LatLng(e.latitude, e.longitude),
                  ),
                );

                return HomeMap(
                  initial: initial,
                  current: current,
                  markers: markers,
                );
              }
              return Container();
            },
          );
        }

        return Container();
      },
    );
  }
}
