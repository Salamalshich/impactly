import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:impactlyflutter/Model/Districts.dart';
import 'package:impactlyflutter/Model/Governorate.dart';
import 'package:impactlyflutter/View/Auth/Signup/Controller/SignupController.dart';
import 'package:impactlyflutter/Widgets/Dropdown/DropdownCustom.dart';
import 'package:provider/provider.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Constant/text_styles.dart';
import 'package:impactlyflutter/Services/Failure.dart';
import 'package:impactlyflutter/Services/Routes.dart';
import 'package:impactlyflutter/View/Auth/Login/Controller/LoginPageController.dart';
import 'package:impactlyflutter/View/Auth/Login/LoginPage.dart';
import 'package:impactlyflutter/Widgets/Button/ButtonCustom.dart';
import 'package:impactlyflutter/Widgets/TextInput/TextInputCustom.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupController>(
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
                    Gap(90),
                    Row(
                      children: [
                        Text(
                          "Create Account",
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
                    Gap(23),
                    Text("Full Name", style: TextStyles.title),
                    Gap(10),
                    TextInputCustom(
                      hint: "Full name",
                      isrequierd: true,
                      controller: controller.fullname,
                    ),
                    Gap(22),
                    Text("Email", style: TextStyles.title),
                    Gap(10),
                    TextInputCustom(
                      hint: "Email address",
                      isrequierd: true,

                      controller: controller.email,
                    ),
                    Gap(22),
                    Text("Phone Number", style: TextStyles.title),
                    Gap(10),
                    TextInputCustom(
                      isrequierd: true,
                      hint: "Phone number",
                      controller: controller.phone,
                    ),
                    Gap(22),
                    Text("Role", style: TextStyles.title),
                    Gap(10),
                    DropdownCustom<int>(
                      isrequierd: true,
                      hint: "Role",
                      value: controller.role,
                      items: [
                        DropdownMenuItem(value: 1, child: Text("Organizer")),
                        DropdownMenuItem(value: 2, child: Text("User")),
                      ],
                      onChanged: (p0) {
                        controller.SelectRole(p0);
                      },
                    ),
                    if (controller.role == 1) Gap(22),
                    if (controller.role == 1)
                      Text("Address", style: TextStyles.title),
                    if (controller.role == 1) Gap(10),
                    if (controller.role == 1)
                      TextInputCustom(
                        isrequierd: true,
                        hint: "Address",
                        controller: controller.address,
                      ),
                    if (controller.role == 2) Gap(22),
                    if (controller.role == 2)
                      Text("Birth of date", style: TextStyles.title),
                    if (controller.role == 2) Gap(10),
                    if (controller.role == 2)
                      TextInputCustom(
                        isrequierd: true,
                        controller: controller.bod,
                        hint: "Birth of date",
                        suffix: GestureDetector(
                          onTap: () {
                            controller.PickBirthday(context);
                          },
                          child: SvgPicture.asset(
                            'assets/SVG/birthday.svg',
                            color: AppColors.primary,
                            width: 22,
                          ),
                        ),
                      ),
                    if (controller.role == 2) Gap(22),
                    if (controller.role == 2)
                      Text("Governorates", style: TextStyles.title),
                    if (controller.role == 2) Gap(10),
                    if (controller.role == 2)
                      DropdownCustom<Governorate>(
                        isrequierd: true,
                        hint: "Governorates",
                        value: controller.governorate,
                        items:
                            controller.governorates
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.name!),
                                  ),
                                )
                                .toList(),
                        onChanged: (p0) {
                          controller.SelectGovernorate(p0);
                        },
                      ),
                    if (controller.governorate != null) Gap(22),
                    if (controller.governorate != null)
                      Text("Districts", style: TextStyles.title),
                    if (controller.governorate != null) Gap(10),
                    if (controller.governorate != null)
                      DropdownCustom<District>(
                        isrequierd: true,
                        hint: "Districts",
                        value: controller.districts,
                        items:
                            controller.governorate!.districts!
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.name!),
                                  ),
                                )
                                .toList(),
                        onChanged: (p0) {
                          controller.SelectDistricts(p0);
                        },
                      ),
                    if (controller.role == 1) Gap(22),
                    if (controller.role == 1)
                      Text("Association Name", style: TextStyles.title),
                    if (controller.role == 1) Gap(10),
                    if (controller.role == 1)
                      TextInputCustom(
                        isrequierd: true,
                        hint: "Association Name",
                        controller: controller.association_name,
                      ),
                    Gap(22),
                    Text("Password", style: TextStyles.title),
                    Gap(10),
                    TextInputCustom(
                      isrequierd: true,
                      hint: "Password",
                      ispassword: true,
                      controller: controller.password,
                    ),
                    Gap(22),
                    Text("Confirm Password", style: TextStyles.title),
                    Gap(10),
                    TextInputCustom(
                      controller: controller.confirmpassword,
                      hint: "Confirm Password",
                      isrequierd: true,
                      ispassword: true,
                      validator: (p0) {
                        if (controller.confirmpassword.text !=
                            controller.password.text) {
                          return 'The passwords do not match.';
                        }
                        return null;
                      },
                    ),

                    Gap(51),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 27),
                      child: ButtonCustom(
                        onTap: () async {
                          if (controller.keyform.currentState!.validate()) {
                            EasyLoading.show();
                            try {
                              Either<Failure, bool> res =
                                  await controller.Signup(context);

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
                        title: "Sign up",
                        color: AppColors.thirdy,
                      ),
                    ),
                    Gap(20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
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
                                  create: (context) => Loginpagecontroller(),
                                  builder: (context, child) => Loginpage(),
                                ),
                              ),
                          child: Text(
                            "Sign in",
                            style: TextStyles.smallpra.copyWith(
                              fontSize: 12.sp,
                              color: AppColors.secondery,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(50),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
