import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_hunt_user/Utils/shimmer_loading.dart';
import '../../../../gen/assets.gen.dart';

Widget imageWidget({
  required String imgurl,
  double? shimmerHeight,
  double? shimmerWidth,
  double? imgHeight,
  double? imgWidth,
  double? radius,
  BoxFit? fit,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(radius ?? 15.r),
    child: CachedNetworkImage(
      imageUrl: imgurl,
      fit: fit ?? BoxFit.fill,
      height: imgHeight ?? 100.h,
      width: imgWidth ?? 90.w,
      placeholder: (context, url) => shimmerLoadingWidget(
          height: imgHeight ?? shimmerHeight, width: imgWidth ?? shimmerWidth),
      errorWidget: (context, url, error) => Image.asset(
        Assets.images.placeholderImage.path,
        height: shimmerHeight ?? imgHeight,
        width: shimmerWidth ?? imgWidth,
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget cachedImageWidget(
    {required String imgUrl,
    double? height,
    double? width,
    BoxFit? fit,
    Color? shimmerColor,
    double? borderRadius,
    BorderRadiusGeometry? specificBorderRadius}) {
  return ClipRRect(
    borderRadius:
        specificBorderRadius ?? BorderRadius.circular(borderRadius ?? 0),
    child: CachedNetworkImage(
      imageUrl: imgUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit ?? BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => shimmerLoadingWidget(
          borderRadius: borderRadius ?? 0, height: height, width: width),
      errorWidget: (context, url, error) => Image.asset(
        Assets.images.placeholderImage.path,
        height: height,
        width: width,
        fit: BoxFit.cover,
      ),
    ),
  );
}
