import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Constant/text_styles.dart';
import 'package:impactlyflutter/Services/Routes.dart';
import 'package:impactlyflutter/View/Auth/Login/Controller/LoginPageController.dart';
import 'package:impactlyflutter/View/Auth/Signup/Controller/SignupController.dart';
import 'package:impactlyflutter/View/Auth/Signup/Signup.dart';
import 'package:impactlyflutter/Widgets/Button/ButtonCustom.dart';
import 'package:impactlyflutter/Widgets/TextInput/TextInputCustom.dart';
import 'package:provider/provider.dart';

class Loginpage extends StatelessWidget {
  const Loginpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Loginpagecontroller>(
      builder:
          (context, controller, child) => Scaffold(
            backgroundColor: AppColors.basic,
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.secondery,
                    AppColors.basic,
                    AppColors.basic,
                    AppColors.basic,
                    AppColors.basic,
                    AppColors.basic,
                    AppColors.basic,
                    AppColors.basic,
                    AppColors.primary,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
              child: Form(
                key: controller.keyform,
                child: ListView(
                  padding: EdgeInsets.all(8),
                  children: [
                    Gap(150),
                    Row(
                      children: [
                        Text(
                          "Login",
                          style: TextStyles.header.copyWith(
                            fontSize: 35.sp,
                            color: AppColors.secondery,
                          ),
                        ),
                        Gap(30),
                        Image.asset(
                          "assets/PNG/Logo.png",
                          width: 40,
                          fit: BoxFit.fitWidth,
                        ),
                      ],
                    ),

                    Gap(60),
                    Text("Email", style: TextStyles.title),
                    Gap(10),
                    TextInputCustom(
                      controller: controller.email,
                      hint: "Email",
                      isrequierd: true,
                    ),
                    Gap(19),
                    Text("Password", style: TextStyles.title),
                    Gap(10),
                    TextInputCustom(
                      controller: controller.password,
                      hint: "Password",
                      ispassword: true,
                      isrequierd: true,
                    ),
                    Gap(85),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 27),
                      child: ButtonCustom(
                        onTap: () async {
                          if (controller.keyform.currentState!.validate()) {
                            EasyLoading.show();
                            try {
                              final res = await controller.Login(context);
                              res.fold(
                                (l) {
                                  EasyLoading.showError(l.message);
                                  EasyLoading.dismiss();
                                },
                                (r) {
                                  EasyLoading.dismiss();
                                },
                              );
                            } catch (e) {
                              EasyLoading.dismiss();
                            }
                          }
                        },
                        title: "Sign in",
                        color: AppColors.thirdy,
                      ),
                    ),
                    Gap(20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyles.smallpra.copyWith(
                            fontSize: 12.sp,
                            color: AppColors.primary,
                          ),
                        ),
                        Gap(5),
                        GestureDetector(
                          onTap:
                              () => CustomRoute.RouteReplacementTo(
                                context,
                                ChangeNotifierProvider(
                                  create:
                                      (context) =>
                                          SignupController()
                                            ..getGovernorates(context),
                                  builder: (context, child) => Signup(),
                                ),
                              ),
                          child: Text(
                            "Sign up",
                            style: TextStyles.smallpra.copyWith(
                              fontSize: 12.sp,
                              color: AppColors.secondery,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
