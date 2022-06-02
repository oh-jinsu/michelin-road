import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  final void Function(int)? onChanged;

  const StarRating({
    Key? key,
    this.onChanged,
  }) : super(key: key);

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  int _rating = 5;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < 5; i++)
          GestureDetector(
            onTap: () => _onTap(i),
            child: Icon(
              Icons.star_rounded,
              size: 36.0,
              color: i < _rating ? Colors.amber : Colors.grey[400],
            ),
          ),
      ],
    );
  }

  void _onTap(int index) {
    final rating = index + 1;

    setState(() {
      _rating = rating;
    });

    widget.onChanged?.call(rating);
  }
}
