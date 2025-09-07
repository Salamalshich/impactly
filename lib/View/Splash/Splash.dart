// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Constant/text_styles.dart';
import 'package:impactlyflutter/View/Splash/Controller/SplashController.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SplashController>(
      builder:
          (context, value, child) => Scaffold(
            extendBodyBehindAppBar: true,

            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.basic, AppColors.basic],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: SafeArea(
                child: Align(
                  alignment: AlignmentDirectional.center,
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/PNG/Logo.png", width: 170.w),
                        Gap(10.h),
                        ShaderMask(
                          shaderCallback: (bounds) {
                            return LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [AppColors.primary, AppColors.secondery],
                            ).createShader(
                              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                            );
                          },
                          blendMode: BlendMode.srcIn,
                          child: Text(
                            "Impactly",
                            style: TextStyles.header.copyWith(
                              fontSize: 30.sp,
                              color: AppColors.basic,
                            ),
                          ),
                        ),
                        Gap(20.h),
                        LoadingAnimationWidget.discreteCircle(
                          color: AppColors.primary,
                          secondRingColor: AppColors.primary,
                          thirdRingColor: AppColors.primary,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
