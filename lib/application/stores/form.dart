import 'package:codux/codux.dart';
import 'package:michelin_road/application/events/form_description_changed.dart';
import 'package:michelin_road/application/events/form_pending.dart';
import 'package:michelin_road/application/events/form_rating_changed.dart';
import 'package:michelin_road/application/events/form_title_changed.dart';
import 'package:michelin_road/application/models/form.dart';
import 'package:michelin_road/core/new.dart';

const initialState = FormModel(
  title: "",
  rating: 5,
  description: "",
  isSubmitEnabled: false,
  isSubmitPending: false,
);

class FormStore extends Store<FormModel> {
  FormStore() : super(initialState: initialState) {
    on<FormTitleChanged>((current, event) {
      if (event.value.isEmpty) {
        return current.state.copy(
          title: New(event.value),
          isSubmitEnabled: const New(false),
        );
      }

      return current.state.copy(
        title: New(event.value),
        isSubmitEnabled: const New(true),
      );
    });
    on<FormRatingChanged>((current, event) {
      return current.state.copy(rating: New(event.value));
    });
    on<FormDescriptionChanged>((current, event) {
      return current.state.copy(description: New(event.value));
    });
    on<FormPending>((current, event) {
      return current.state.copy(isSubmitPending: const New(true));
    });
  }
}
