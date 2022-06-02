import 'package:codux/codux.dart';
import 'package:flutter/material.dart';
import 'package:michelin_road/application/events/location_requested.dart';
import 'package:michelin_road/application/models/location_status.dart';
import 'package:michelin_road/application/stores/location_status.dart';

class Locator extends Component {
  const Locator({Key? key}) : super(key: key);

  @override
  Widget render(BuildContext context) {
    return StreamBuilder(
      stream: find<LocationStatusStore>().stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data as LocationStatusModel;

          if (!data.isPending) {
            return FloatingActionButton(
              onPressed: () => dispatch(const LocationRequested()),
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
          onPressed: () {},
          elevation: 4.0,
          backgroundColor: Colors.white,
          child: SizedBox(
            width: 20.0,
            height: 20.0,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 4.0,
                color: Colors.grey[700],
              ),
            ),
          ),
        );
      },
    );
  }
}
