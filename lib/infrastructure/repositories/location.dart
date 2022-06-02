import 'dart:async';

import 'package:michelin_road/application/models/location.dart';
import 'package:michelin_road/infrastructure/instances/database.dart';
import 'package:michelin_road/infrastructure/instances/uuid.dart';
import 'package:michelin_road/infrastructure/mapper/location.dart';

class LocationRepository {
  static const table = "location";

  Future<LocationModel?> findRecentOne() async {
    final result = await database.query(
      table,
      orderBy: "created_at DESC",
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return LocationMapper.toModel(result[0]);
  }

  Future<LocationModel> save({
    required double latitude,
    required double longitude,
  }) async {
    final id = uuid.v1();

    await database.insert(table, {
      "id": id,
      "latitude": latitude,
      "longitude": longitude,
      "created_at": DateTime.now().toIso8601String()
    });

    final result = await database.query(
      table,
      where: "id = ?",
      whereArgs: [id],
    );

    return LocationMapper.toModel(result[0]);
  }
}
