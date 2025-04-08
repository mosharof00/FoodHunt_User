import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogHelper {
  static void showDialog({
    required BuildContext context,
    required String title,
    required String description,
    DialogType dialogType = DialogType.info,
    VoidCallback? onOkPress,
    VoidCallback? onCancelPress,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: dialogType,
      animType: AnimType.scale,
      title: title,
      desc: description,
      titleTextStyle: GoogleFonts.outfit(),
      descTextStyle: GoogleFonts.outfit(),
      btnOkOnPress: onOkPress ?? () {},
      btnCancelOnPress: onCancelPress ?? () {},
      btnOkColor: Colors.blue,
      btnCancelColor: Colors.red.shade800,
      btnCancelText: "Cancel",
    ).show();
  }
}
