import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';

import '../gen/assets.gen.dart';
import 'app_text_style.dart';

class ShowRatings extends StatelessWidget {
  const ShowRatings({super.key, required this.ratings, this.numberOfRatings});
  final double ratings;
  final int? numberOfRatings;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          Assets.icons.starIcon,
        ),
        5.width,
        AppTextStyle(
          text: ratings.toString(),
          fontWeight: FontWeight.w500,
        ),
        5.width,
        ratings == 0.0 || ratings == 0
            ? 0.width
            : AppTextStyle(
                text: "($numberOfRatings+)",
                color: Colors.grey,
              )
      ],
    );
  }
}
