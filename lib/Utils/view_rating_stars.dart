import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ViewRatingStars extends StatelessWidget {
  final double rating;
  final double starSize;
  final Color ratingColor;
  final Color unratedColor;

  const ViewRatingStars({
    super.key,
    required this.rating,
    this.starSize = 20,
    this.ratingColor = Colors.amber,
    this.unratedColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBarIndicator(
          rating: rating,
          itemBuilder: (context, index) => Icon(
            Icons.star,
            color: ratingColor,
          ),
          itemCount: 5,
          itemSize: starSize,
          direction: Axis.horizontal,
        ),
      ],
    );
  }
}