import 'dart:convert';

import 'package:codux/codux.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:michelin_road/application/events/list_of_search_result_found.dart';
import 'package:michelin_road/application/events/search_requested.dart';
import 'package:michelin_road/application/models/search_result.dart';

class SearchEffect extends Effect {
  SearchEffect() {
    on<SearchRequested>((event) async {
      if (event.keyword.isEmpty) {
        return;
      }

      final uri = Uri.parse(
        "https://openapi.naver.com/v1/search/local.json?query=${event.keyword}&display=5",
      );

      final id = dotenv.get("NAVER_SEARCH_CLIENT_ID");

      final secret = dotenv.get("NAVER_SEARCH_CLIENT_SECRET");

      final response = await get(uri, headers: {
        "X-Naver-Client-Id": id,
        "X-naver-Client-Secret": secret,
      });

      final items = jsonDecode(response.body)["items"] as List;

      final models = items.map((json) => SearchResult.fromJson(json)).toList();

      dispatch(ListOfSearchResultFound(models));
    });
  }
}
