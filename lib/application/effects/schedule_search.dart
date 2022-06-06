import 'dart:async';

import 'package:codux/codux.dart';
import 'package:michelin_road/application/events/keyword_changed.dart';
import 'package:michelin_road/application/events/search_requested.dart';

class ScheduleSearchEffect extends Effect {
  Timer? timer;

  ScheduleSearchEffect() {
    on<SearchRequested>((event) {
      timer?.cancel();

      timer = null;
    });
    on<SearchKeywordChanged>((event) {
      timer?.cancel();

      timer = null;

      if (event.value.isEmpty) {
        return;
      }

      timer = Timer(const Duration(milliseconds: 175), () {
        dispatch(SearchRequested(event.value));
      });
    });
  }
}
