import 'dart:async';

import 'package:michelin_road/application/models/review.dart';
import 'package:michelin_road/infrastructure/instances/database.dart';
import 'package:michelin_road/infrastructure/instances/uuid.dart';
import 'package:michelin_road/infrastructure/mapper/review.dart';

class ReviewRepository {
  static const table = "review";

  Future<List<ReviewModel>> find() async {
    final result = await database.query(table);

    return result.map((e) => ReviewMapper.toModel(e)).toList();
  }

  Future<ReviewModel?> findOne(String id) async {
    final result = await database.query(
      table,
      where: "id =  ?",
      whereArgs: [id],
    );

    if (result.isEmpty) {
      return null;
    }

    return ReviewMapper.toModel(result[0]);
  }

  Future<ReviewModel> save({
    required String restaurantName,
    required double latitude,
    required double longitude,
    required int rating,
    required String description,
  }) async {
    final id = uuid.v1();

    await database.insert(table, {
      "id": id,
      "restaurant_name": restaurantName,
      "latitude": latitude,
      "longitude": longitude,
      "rating": rating,
      "description": description,
      "updated_at": DateTime.now().toIso8601String(),
      "created_at": DateTime.now().toIso8601String()
    });

    final result = await findOne(id);

    return result!;
  }

  Future<ReviewModel> update(
    String id, {
    String? restaurantName,
    int? rating,
    String? description,
  }) async {
    final value = <String, dynamic>{
      "updated_at": DateTime.now().toIso8601String(),
    };

    if (restaurantName != null) {
      value["restaurant_name"] = restaurantName;
    }

    if (rating != null) {
      value["rating"] = rating;
    }

    if (description != null) {
      value["description"] = description;
    }

    await database.update(
      table,
      value,
      where: "id = ?",
      whereArgs: [id],
    );

    final result = await findOne(id);

    return result!;
  }

  Future<void> delete(String id) async {
    await database.delete(
      table,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
