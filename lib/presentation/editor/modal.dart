import 'package:codux/codux.dart';
import 'package:flutter/material.dart';
import 'package:michelin_road/presentation/editor/widgets/star_rating.dart';

class EditorModal extends Component {
  const EditorModal({Key? key}) : super(key: key);

  @override
  Widget render(BuildContext context) {
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
                  top: 8.0,
                  left: 12.0,
                  right: 8.0,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.add_location_alt,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      "새로운 맛집별점",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
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
                padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                child: TextField(
                  autofocus: true,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 2.0),
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
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: StarRating(),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 16.0,
                ),
                child: TextField(
                  minLines: 5,
                  maxLines: 5,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[150],
                    filled: true,
                    hintText: "기억에 남는 것이 있다면 간단하게 기록해 보세요.",
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
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40.0),
                  ),
                  child: const Text("추가하기"),
                ),
              ),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}
