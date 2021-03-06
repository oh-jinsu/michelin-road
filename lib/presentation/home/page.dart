import 'package:codux/codux.dart';
import 'package:flutter/material.dart';
import 'package:michelin_road/application/effects/delete_review.dart';
import 'package:michelin_road/application/effects/schedule_search.dart';
import 'package:michelin_road/application/effects/search.dart';
import 'package:michelin_road/application/effects/show_editor.dart';
import 'package:michelin_road/application/events/delete_review_requested.dart';
import 'package:michelin_road/application/events/edit_review_requested.dart';
import 'package:michelin_road/application/events/map_touched.dart';
import 'package:michelin_road/application/events/search_requested.dart';
import 'package:michelin_road/application/models/displaying_review.dart';
import 'package:michelin_road/application/models/location.dart';
import 'package:michelin_road/application/stores/current_location.dart';
import 'package:michelin_road/application/stores/form_location.dart';
import 'package:michelin_road/application/stores/search.dart';
import 'package:michelin_road/application/stores/selected_review.dart';
import 'package:michelin_road/core/enum.dart';
import 'package:michelin_road/presentation/editor/modal.dart';
import 'package:michelin_road/presentation/home/components/locator.dart';
import 'package:michelin_road/presentation/home/components/search_bar.dart';
import 'package:michelin_road/presentation/home/components/viewer.dart';

class HomePage extends Component {
  final _searchBarTextEditingController = TextEditingController();
  final _searchBarFocusNode = FocusNode();

  HomePage({Key? key}) : super(key: key);

  @override
  void onCreated(BuildContext context) {
    useStore(() => SelectedReviewStore());
    useStore(() => SearchStore());

    useEffect(() => ShowEditor());
    useEffect(() => DeleteReviewEffect());
    useEffect(() => ScheduleSearchEffect());
    useEffect(() => SearchEffect());

    super.onCreated(context);
  }

  @override
  void onStarted(BuildContext context) {
    _searchBarFocusNode.addListener(() {
      if (_searchBarFocusNode.hasFocus) {
        if (_searchBarTextEditingController.text.isNotEmpty) {
          dispatch(SearchRequested(_searchBarTextEditingController.text));
        }
      }
    });

    super.onStarted(context);
  }

  @override
  void onDestroyed(BuildContext context) {
    _searchBarFocusNode.dispose();
    _searchBarTextEditingController.dispose();

    super.onDestroyed(context);
  }

  @override
  Widget render(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Viewer(
            onTap: () {
              _searchBarFocusNode.unfocus();
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0),
            child: SafeArea(
              child: StreamBuilder(
                stream: find<CurrentLocationStore>().stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data as Option<LocationModel>;

                    if (data is! Some<LocationModel>) {
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const Positioned(
                            top: 64.0,
                            right: 0.0,
                            child: Locator(),
                          ),
                          SearchBar(
                            controller: _searchBarTextEditingController,
                            focusNode: _searchBarFocusNode,
                          ),
                        ],
                      );
                    }

                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: 64.0,
                          right: 0.0,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Locator(),
                              const SizedBox(height: 16.0),
                              FloatingActionButton(
                                onPressed: () {
                                  dispatch(const MapTouched());

                                  final location = find<AdjustedLocationStore>()
                                      .stream
                                      .value;

                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return EditorModal(
                                        restaurantName: location.title,
                                        latitude: location.latitude,
                                        longitude: location.longitude,
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
                          ),
                        ),
                        SearchBar(
                          controller: _searchBarTextEditingController,
                          focusNode: _searchBarFocusNode,
                        ),
                      ],
                    );
                  }

                  return const SizedBox(width: 0.0, height: 0.0);
                },
              ),
            ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Wrap(
                                        children: [
                                          for (int i = 0;
                                              i <
                                                  data.value.model
                                                      .restaurantName.length;
                                              i++)
                                            Text(
                                              data.value.model
                                                  .restaurantName[i],
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
                                      onTap: () {
                                        dispatch(EditReviewRequested(
                                          id: data.value.model.id,
                                          restaurantName:
                                              data.value.model.restaurantName,
                                          rating: data.value.model.rating,
                                          description:
                                              data.value.model.description,
                                          latitude: data.value.model.latitude,
                                          longitude: data.value.model.longitude,
                                        ));
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.edit,
                                            color: Colors.grey[600],
                                          ),
                                          const SizedBox(width: 4.0),
                                          Text(
                                            "??????",
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
                                            "??????",
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
      ),
    );
  }
}
