import 'package:codux/codux.dart';
import 'package:michelin_road/application/events/keyword_changed.dart';
import 'package:michelin_road/application/events/list_of_search_result_found.dart';
import 'package:michelin_road/application/events/map_touched.dart';
import 'package:michelin_road/application/events/searched_location_found.dart';
import 'package:michelin_road/application/models/search_result.dart';
import 'package:michelin_road/core/enum.dart';

class SearchStore extends Store<Option<List<SearchResult>>> {
  SearchStore() : super(initialState: const None()) {
    on<ListOfSearchResultFound>((current, event) {
      return Some(event.models);
    });
    on<MapTouched>((current, event) {
      return const None();
    });
    on<SearchedLocationFound>((current, event) {
      return const None();
    });
    on<SearchKeywordChanged>((current, event) {
      if (event.value.isEmpty) {
        return const None();
      }

      return current.state;
    });
  }
}
