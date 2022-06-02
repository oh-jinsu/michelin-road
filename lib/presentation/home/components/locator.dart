import 'package:codux/codux.dart';
import 'package:flutter/material.dart';
import 'package:michelin_road/application/events/current_location_requested.dart';
import 'package:michelin_road/application/models/location_status.dart';
import 'package:michelin_road/application/stores/locator_status.dart';

class Locator extends Component {
  const Locator({Key? key}) : super(key: key);

  @override
  Widget render(BuildContext context) {
    return StreamBuilder(
      stream: find<LocatorStatusStore>().stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data as LocationStatusModel;

          if (!data.isPending) {
            return FloatingActionButton(
              heroTag: "fab_location_request",
              onPressed: () => dispatch(const CurrentLocationRequested()),
              elevation: 4.0,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.gps_fixed,
                color: Colors.grey[700],
              ),
            );
          }
        }

        return FloatingActionButton(
          heroTag: "fab_location_request",
          onPressed: () {},
          elevation: 4.0,
          backgroundColor: Colors.white,
          child: SizedBox(
            width: 20.0,
            height: 20.0,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                color: Colors.grey[700],
              ),
            ),
          ),
        );
      },
    );
  }
}
