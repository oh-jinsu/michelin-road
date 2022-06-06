import 'package:codux/codux.dart';
import 'package:flutter/material.dart';
import 'package:michelin_road/application/events/keyword_changed.dart';
import 'package:michelin_road/application/events/search_requested.dart';
import 'package:michelin_road/application/events/searched_location_found.dart';
import 'package:michelin_road/application/models/search_result.dart';
import 'package:michelin_road/application/stores/search.dart';
import 'package:michelin_road/core/enum.dart';

class SearchBar extends Component {
  final TextEditingController controller;

  final FocusNode focusNode;

  const SearchBar({
    Key? key,
    required this.focusNode,
    required this.controller,
  }) : super(key: key);

  @override
  Widget render(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.5),
              offset: const Offset(0.0, 2.0),
              blurRadius: 4.0,
            )
          ]),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            onSubmitted: (value) {
              dispatch(SearchRequested(value));
            },
            onChanged: (value) {
              dispatch(SearchKeywordChanged(value));
            },
            style: const TextStyle(height: 1.3),
            decoration: const InputDecoration(
              hintText: "장소를 검색해 보세요!",
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              prefixIcon: Icon(Icons.search),
              contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        StreamBuilder(
          stream: find<SearchStore>().stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;

              if (data is Some<List<SearchResult>>) {
                if (data.value.isEmpty) {
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.5),
                          offset: const Offset(0.0, 2.0),
                          blurRadius: 4.0,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.warning,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          "결과를 찾지 못했어요.",
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.5),
                        offset: const Offset(0.0, 2.0),
                        blurRadius: 4.0,
                      )
                    ],
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (int i = 0; i < data.value.length * 2 - 1; i++)
                        if (i % 2 == 1)
                          const Divider(
                            height: 0.0,
                          )
                        else
                          GestureDetector(
                            onTap: () {
                              focusNode.unfocus();

                              controller.text = data.value[i ~/ 2].title;

                              dispatch(
                                SearchedLocationFound(
                                  title: data.value[i ~/ 2].title,
                                  latitude: data.value[i ~/ 2].latitude,
                                  longitude: data.value[i ~/ 2].longitude,
                                ),
                              );
                            },
                            child: Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 12.0,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.place,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  const SizedBox(width: 12.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.value[i ~/ 2].title,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        Text(
                                          data.value[i ~/ 2].address,
                                          style: TextStyle(
                                              color: Colors.grey[500]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    ],
                  ),
                );
              }
            }
            return const SizedBox();
          },
        )
      ],
    );
  }
}
