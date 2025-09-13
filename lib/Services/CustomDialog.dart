import 'package:flutter/material.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Constant/text_styles.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CustomDialog {
  static DialogSuccess(BuildContext context, {String? title}) {
    showTopSnackBar(
      curve: Curves.fastLinearToSlowEaseIn,
      Overlay.of(context),

      CustomSnackBar.success(
        textStyle: TextStyles.title.copyWith(color: AppColors.basic),
        message: title!,
      ),
    );
  }

  static DialogError(BuildContext context, {String? title}) {
    showTopSnackBar(
      curve: Curves.fastLinearToSlowEaseIn,
      Overlay.of(context),
      CustomSnackBar.error(
        textStyle: TextStyles.title.copyWith(color: AppColors.basic),
        message: title!,
      ),
    );
  }

  static DialogWarning(BuildContext context, {String? title}) {
    showTopSnackBar(
      curve: Curves.fastLinearToSlowEaseIn,
      Overlay.of(context),
      CustomSnackBar.info(
        textStyle: TextStyles.title,
        backgroundColor: Colors.orange,
        message: title!,
      ),
    );
  }
}
