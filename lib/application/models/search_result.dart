import 'package:michelin_road/core/new.dart';
import 'package:proj4dart/proj4dart.dart';

class SearchResult {
  final String title;
  final String category;
  final String description;
  final String address;
  final double latitude;
  final double longitude;

  const SearchResult({
    required this.title,
    required this.category,
    required this.description,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    String address = json["roadAddress"];

    if (address.isEmpty) {
      address = json["address"];
    }

    final tuple = ProjectionTuple(
      fromProj: Projection.parse(
        '+proj=tmerc +lat_0=38 +lon_0=128 +k=0.9999 +x_0=400000 +y_0=600000 +ellps=bessel +units=m +no_defs +towgs84=-115.80,474.99,674.11,1.16,-2.31,-1.63,6.43',
      ),
      toProj: Projection.parse(
        '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs',
      ),
    );

    final latlng = tuple.forward(
      Point.fromArray([double.parse(json["mapx"]), double.parse(json["mapy"])]),
    );

    return SearchResult(
      title: json["title"].replaceAll("<b>", "").replaceAll("</b>", ""),
      category: json["category"],
      description: json["description"],
      address: address,
      latitude: latlng.y,
      longitude: latlng.x,
    );
  }

  SearchResult copy({
    New<String>? title,
    New<String>? category,
    New<String>? description,
    New<String>? address,
    New<double>? latitude,
    New<double>? longitude,
  }) {
    return SearchResult(
      title: title != null ? title.value : this.title,
      category: category != null ? category.value : this.category,
      description: description != null ? description.value : this.description,
      address: address != null ? address.value : this.address,
      latitude: latitude != null ? latitude.value : this.latitude,
      longitude: longitude != null ? longitude.value : this.longitude,
    );
  }
}
