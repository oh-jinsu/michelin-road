import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  final bool enabled;
  final void Function(int)? onChanged;
  final double size;
  final int? initial;

  const StarRating({
    Key? key,
    this.enabled = true,
    this.onChanged,
    this.size = 36.0,
    this.initial,
  }) : super(key: key);

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  late int _rating = widget.initial ?? 5;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < 5; i++)
          GestureDetector(
            onTap: () => _onTap(i),
            child: Icon(
              Icons.star_rounded,
              size: widget.size,
              color: i < _rating ? Colors.amber : Colors.grey[400],
            ),
          ),
      ],
    );
  }

  void _onTap(int index) {
    if (!widget.enabled) {
      return;
    }

    final rating = index + 1;

    setState(() {
      _rating = rating;
    });

    widget.onChanged?.call(rating);
  }
}
