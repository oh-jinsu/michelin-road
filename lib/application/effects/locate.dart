import 'package:codux/codux.dart';
import 'package:geolocator/geolocator.dart';
import 'package:michelin_road/application/effects/with_dialog.dart';
import 'package:michelin_road/application/events/current_location_canceled.dart';
import 'package:michelin_road/application/events/first_location_found.dart';
import 'package:michelin_road/application/events/infrastructure_loaded.dart';
import 'package:michelin_road/application/events/current_location_found.dart';
import 'package:michelin_road/application/events/current_location_pending.dart';
import 'package:michelin_road/application/events/current_location_requested.dart';
import 'package:michelin_road/application/events/searched_location_found.dart';
import 'package:michelin_road/application/models/location.dart';
import 'package:michelin_road/core/service_locator.dart';
import 'package:michelin_road/infrastructure/repositories/location.dart';

class LocateEffect extends Effect with DialogEffectMixin {
  LocateEffect() {
    on<InfrastructureLoaded>((event) async {
      final locationRepository = ServiceLocator.find<LocationRepository>();

      final recentOne = await locationRepository.findRecentOne();

      if (recentOne == null) {
        return dispatch(const FirstLocationFound(null));
      }

      return dispatch(FirstLocationFound(recentOne));
    });
    on<CurrentLocationRequested>((event) async {
      dispatch(const CurrentLocationPending());

      final isServiceAvailable = await Geolocator.isLocationServiceEnabled();

      if (!isServiceAvailable) {
        dispatch(const CurrentLocationCanceled());

        showAlertDialog(
          content: "위치 서비스가 꺼져 있어요. 현위치를 표시하려면 기기 설정에서 위치 서비스를 켜 주세요.",
        );

        return;
      }

      LocationPermission isPermissionGranted =
          await Geolocator.checkPermission();

      if (isPermissionGranted == LocationPermission.denied) {
        isPermissionGranted = await Geolocator.requestPermission();

        if (isPermissionGranted == LocationPermission.denied) {
          dispatch(const CurrentLocationCanceled());

          return;
        }
      }

      if (isPermissionGranted == LocationPermission.deniedForever) {
        dispatch(const CurrentLocationCanceled());

        showAlertDialog(
          content: "위치 서비스에 대한 접근 권한이 거부되었어요. 현위치를 표시하려면 기기 설정에서 권한을 설정해 주세요.",
        );

        return;
      }

      final Position data;

      try {
        data = await Geolocator.getCurrentPosition();
      } catch (e) {
        return dispatch(const CurrentLocationCanceled());
      }

      final locationRepository = ServiceLocator.find<LocationRepository>();

      final locationModel = await locationRepository.save(
        latitude: data.latitude,
        longitude: data.longitude,
      );

      dispatch(CurrentLocationFound(locationModel));
    });
    on<SearchedLocationFound>((event) {
      final location = LocationModel(
        id: "${event.latitude}-${event.longitude}",
        title: event.title,
        latitude: event.latitude,
        longitude: event.longitude,
        createdAt: DateTime.now(),
      );

      dispatch(CurrentLocationFound(location));
    });
  }
}
