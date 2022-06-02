import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  const StarRating({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < 5; i++)
          const Icon(
            Icons.star_rounded,
            size: 36.0,
            color: Colors.amber,
          ),
      ],
    );
  }
}
