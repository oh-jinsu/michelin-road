import 'package:codux/codux.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:michelin_road/application/effects/with_dialog.dart';
import 'package:michelin_road/application/events/current_location_canceled.dart';
import 'package:michelin_road/application/events/first_location_found.dart';
import 'package:michelin_road/application/events/infrastructure_loaded.dart';
import 'package:michelin_road/application/events/current_location_found.dart';
import 'package:michelin_road/application/events/current_location_pending.dart';
import 'package:michelin_road/application/events/current_location_requested.dart';
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

      final service = Location();

      final isServiceAvailable = await service.serviceEnabled();

      if (!isServiceAvailable) {
        final result = await service.requestService();

        if (!result) {
          dispatch(const CurrentLocationCanceled());

          // showAlertDialog(
          //   content: "위치 서비스가 꺼져 있습니다. 현위치를 표시하려면 기기 설정에서 위치 서비스를 켜 주세요.",
          // );

          return;
        }
      }

      final isPermissionGranted = await service.hasPermission();

      if (isPermissionGranted == PermissionStatus.denied) {
        final result = await service.requestPermission();

        if (result != PermissionStatus.granted) {
          dispatch(const CurrentLocationCanceled());

          showAlertDialog(
            content: "위치 서비스에 접근할 권한이 없습니다. 현위치를 표시하려면 기기 설정에서 접근을 허용해 주세요.",
          );

          return;
        }
      }

      final LocationData data;

      try {
        data = await service.getLocation();
      } catch (e) {
        return dispatch(const CurrentLocationCanceled());
      }

      final latitude = data.latitude;

      final longitude = data.longitude;

      if (latitude == null || longitude == null) {
        return dispatch(const CurrentLocationCanceled());
      }

      final locationRepository = ServiceLocator.find<LocationRepository>();

      final locationModel = await locationRepository.save(
        latitude: latitude,
        longitude: longitude,
      );

      dispatch(CurrentLocationFound(locationModel));
    });
  }
}
