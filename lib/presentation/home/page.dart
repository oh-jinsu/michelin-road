import 'package:codux/codux.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:michelin_road/application/models/location.dart';
import 'package:michelin_road/application/stores/location.dart';
import 'package:michelin_road/core/enum.dart';
import 'package:michelin_road/presentation/home/components/locator.dart';
import 'package:michelin_road/presentation/home/widgets/map.dart';

class HomePage extends Component {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget render(BuildContext context) {
    return Scaffold(
      floatingActionButton: StreamBuilder(
        stream: find<LocationStore>().stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data as Option<LocationModel>;

            if (data is! Some<LocationModel>) {
              return const Locator();
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Locator(),
                const SizedBox(height: 16.0),
                FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.add_location_alt),
                ),
              ],
            );
          }

          return const SizedBox(width: 0.0, height: 0.0);
        },
      ),
      body: StreamBuilder(
        stream: find<LocationStore>().stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data as Option<LocationModel>;

            final target = data is Some<LocationModel>
                ? LatLng(data.value.latitude, data.value.longitude)
                : null;

            return HomeMap(target: target);
          }

          return Container();
        },
      ),
    );
  }
}
