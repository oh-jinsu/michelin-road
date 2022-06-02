import 'package:codux/codux.dart';
import 'package:flutter/material.dart';
import 'package:michelin_road/application/effects/form_waiter.dart';
import 'package:michelin_road/application/effects/submit_form.dart';
import 'package:michelin_road/application/events/form_description_changed.dart';
import 'package:michelin_road/application/events/form_rating_changed.dart';
import 'package:michelin_road/application/events/form_submitted.dart';
import 'package:michelin_road/application/events/form_title_changed.dart';
import 'package:michelin_road/application/models/form.dart';
import 'package:michelin_road/application/stores/form.dart';
import 'package:michelin_road/application/stores/form_location.dart';
import 'package:michelin_road/presentation/editor/widgets/star_rating.dart';

class EditorModal extends Component {
  final double latitude;
  final double longitude;

  const EditorModal({
    Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  void onCreated(BuildContext context) {
    useStore(() => FormStore());

    useEffect(() => SubmitFormEffect());
    useEffect(() => FormWaiterEffect());

    super.onCreated(context);
  }

  @override
  Widget render(BuildContext context) {
    return StreamBuilder(
      stream: find<FormStore>().stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data as FormModel;

          return SingleChildScrollView(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: SafeArea(
                top: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 12.0,
                        left: 12.0,
                        right: 8.0,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.add_location_alt,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    "새로운 맛집별점",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 4.0,
                                  top: 6.0,
                                ),
                                child: Text(
                                  "파란색 마커가 찍힌 곳에 새로운 리뷰를 추가합니다.\n정확한 위치가 아니라면 드래그해서 옮겨 주세요!",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12.0,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(
                              Icons.close,
                              color: Colors.grey[500],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 6.0),
                      child: TextField(
                        enabled: !data.isSubmitPending,
                        autofocus: true,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 2.0),
                          hintText: "맛집 이름",
                          hintStyle: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8.0),
                            gapPadding: 0.0,
                          ),
                        ),
                        onChanged: (v) => dispatch(FormTitleChanged(v)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: StarRating(
                        enabled: !data.isSubmitPending,
                        onChanged: (v) => dispatch(FormRatingChanged(v)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 16.0,
                      ),
                      child: TextField(
                        enabled: !data.isSubmitPending,
                        minLines: 5,
                        maxLines: 5,
                        decoration: InputDecoration(
                          fillColor: Colors.grey[150],
                          filled: true,
                          hintText: "인상 깊은 점이 있었다면 간단하게 기록해 보세요.",
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 16.0,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (v) => dispatch(FormDescriptionChanged(v)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 12.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (data.isSubmitPending) {
                            return;
                          }

                          if (!data.isSubmitEnabled) {
                            return;
                          }

                          final location =
                              find<AdjustedLocationStore>().stream.value;

                          dispatch(
                            FormSubmitted(
                              latitude: location.latitude,
                              longitude: location.longitude,
                              restaurantName: data.title,
                              description: data.description,
                              rating: data.rating,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary:
                              data.isSubmitEnabled ? null : Colors.grey[400],
                          minimumSize: const Size.fromHeight(40.0),
                        ),
                        child: data.isSubmitPending
                            ? const SizedBox(
                                width: 16.0,
                                height: 16.0,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : const Text("추가하기"),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              ),
            ),
          );
        }

        return Container();
      },
    );
  }
}
