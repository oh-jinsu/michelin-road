import 'package:codux/codux.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:michelin_road/application/models/location.dart';
import 'package:michelin_road/application/stores/location.dart';
import 'package:michelin_road/presentation/home/components/locator.dart';
import 'package:michelin_road/presentation/home/widgets/map.dart';

class HomePage extends Component {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget render(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Locator(),
          const SizedBox(height: 16.0),
          FloatingActionButton(
            child: const Icon(Icons.add_location_alt),
            onPressed: () {},
          ),
        ],
      ),
      body: StreamBuilder(
        stream: find<LocationStore>().stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data as LocationModel;

            return HomeMap(
              cameraPosition: CameraPosition(
                target: LatLng(data.latitude, data.longitude),
                zoom: 17.0,
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
