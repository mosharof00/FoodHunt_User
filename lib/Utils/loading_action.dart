import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../gen/colors.gen.dart';

Widget loadingAction() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: CupertinoActivityIndicator(
        radius: 20,
        color: ColorName.primaryColor,
      ),
    ),
  );
}

Widget loadingActionWithText(String text) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CupertinoActivityIndicator(),
        SizedBox(height: 10),
        Text(text),
      ],
    ),
  );
}
Widget loadingActionWithTextAndColor(String text, Color color) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CupertinoActivityIndicator(),
        SizedBox(height: 10),
        Text(text, style: TextStyle(color: color)),
      ],
    ),
  );
}

Widget loadingActionWithCircularProgressIndicator() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(ColorName.primaryColor),
        strokeWidth: 2,
      ),
    ),
  );
}