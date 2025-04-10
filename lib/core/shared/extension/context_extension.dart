import 'package:flutter/material.dart';
import 'package:todo_firebase/core/theme/color_pallete.dart';

extension ContextExtension on BuildContext {
  void showSnack(String msg, {Color color = ColorPalette.blackColor}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        // padding: const EdgeInsets.all(10),
        showCloseIcon: true,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
        content: Text(msg),
      ),
    );
  }

  // screen height and width
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;

  // keyboard height
  double get keyBoardHeightPadding => MediaQuery.of(this).viewInsets.bottom;

  //theme
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;

  TextStyle get bodyLarge => textTheme.bodyLarge!;
  TextStyle get bodyMedium => textTheme.bodyMedium!;
  TextStyle get bodySmall => textTheme.bodySmall!;
}
