import 'package:codux/codux.dart';
import 'package:flutter/material.dart';
import 'package:michelin_road/application/effects/delete_review.dart';
import 'package:michelin_road/application/events/delete_review_requested.dart';
import 'package:michelin_road/application/events/review_unselected.dart';
import 'package:michelin_road/application/models/displaying_review.dart';
import 'package:michelin_road/application/models/location.dart';
import 'package:michelin_road/application/stores/current_location.dart';
import 'package:michelin_road/application/stores/selected_review.dart';
import 'package:michelin_road/core/enum.dart';
import 'package:michelin_road/presentation/editor/modal.dart';
import 'package:michelin_road/presentation/home/components/locator.dart';
import 'package:michelin_road/presentation/home/components/viewer.dart';

class HomePage extends Component {
  const HomePage({Key? key}) : super(key: key);

  @override
  void onCreated(BuildContext context) {
    useStore(() => SelectedReviewStore());

    useEffect(() => DeleteReviewEffect());

    super.onCreated(context);
  }

  @override
  Widget render(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          floatingActionButton: StreamBuilder(
            stream: find<CurrentLocationStore>().stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data as Option<LocationModel>;

                if (data is! Some<LocationModel>) {
                  return const Locator();
                }

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Locator(),
                    const SizedBox(height: 16.0),
                    FloatingActionButton(
                      onPressed: () {
                        dispatch(const ReviewUnselected());

                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return EditorModal(
                              latitude: data.value.latitude,
                              longitude: data.value.longitude,
                            );
                          },
                        );
                      },
                      child: const Icon(
                        Icons.add_location_alt,
                        color: Color(0xff00366d),
                      ),
                    ),
                  ],
                );
              }

              return const SizedBox(width: 0.0, height: 0.0);
            },
          ),
          body: const Viewer(),
        ),
        StreamBuilder(
          stream: find<SelectedReviewStore>().stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data as Option<DisplayingReviewModel>;

              if (data is Some<DisplayingReviewModel>) {
                return AnimatedPositioned(
                  width: MediaQuery.of(context).size.width,
                  bottom: data.value.show ? 48.0 : -256.0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Container(
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: const Offset(0.0, 2.0),
                            blurRadius: 4.0,
                          )
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 16.0,
                                  bottom: 16.0,
                                  left: 16.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      children: [
                                        for (int i = 0;
                                            i <
                                                data.value.model.restaurantName
                                                    .length;
                                            i++)
                                          Text(
                                            data.value.model.restaurantName[i],
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              height: 1.23,
                                            ),
                                          ),
                                        const SizedBox(width: 4.0),
                                        for (int i = 0; i < 5; i++)
                                          Icon(
                                            Icons.star_rounded,
                                            size: 20.0,
                                            color: i < data.value.model.rating
                                                ? Colors.amber
                                                : Colors.grey[400],
                                          ),
                                      ],
                                    ),
                                    if (data.value.model.description
                                        .isNotEmpty) ...[
                                      const SizedBox(height: 8.0),
                                      Text(
                                        data.value.model.description,
                                      ),
                                    ]
                                  ],
                                ),
                              ),
                            ),
                            PopupMenuButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              icon: Icon(
                                Icons.more_vert,
                                color: Colors.grey[400],
                              ),
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          color: Colors.grey[600],
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          "수정",
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    onTap: () {
                                      dispatch(
                                        DeleteReviewRequested(
                                          data.value.model.id,
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          color: Colors.grey[600],
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          "삭제",
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ];
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }

              return AnimatedPositioned(
                width: MediaQuery.of(context).size.width,
                bottom: -256.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: const Offset(0.0, 2.0),
                          blurRadius: 4.0,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }

            return Container();
          },
        ),
      ],
    );
  }
}
