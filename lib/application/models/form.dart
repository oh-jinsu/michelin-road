import 'package:michelin_road/core/new.dart';

class FormModel {
  final String title;
  final int rating;
  final String description;
  final bool isSubmitEnabled;
  final bool isSubmitPending;

  const FormModel({
    required this.title,
    required this.rating,
    required this.description,
    required this.isSubmitEnabled,
    required this.isSubmitPending,
  });

  FormModel copy({
    New<String>? title,
    New<int>? rating,
    New<String>? description,
    New<bool>? isSubmitEnabled,
    New<bool>? isSubmitPending,
  }) {
    return FormModel(
      title: title != null ? title.value : this.title,
      rating: rating != null ? rating.value : this.rating,
      description: description != null ? description.value : this.description,
      isSubmitEnabled: isSubmitEnabled != null
          ? isSubmitEnabled.value
          : this.isSubmitEnabled,
      isSubmitPending: isSubmitPending != null
          ? isSubmitPending.value
          : this.isSubmitPending,
    );
  }
}
