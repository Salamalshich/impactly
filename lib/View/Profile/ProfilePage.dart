import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:impactlyflutter/Model/Districts.dart';
import 'package:impactlyflutter/Model/Governorate.dart';
import 'package:impactlyflutter/Services/ServicesProvider.dart';
import 'package:impactlyflutter/View/Profile/Controller/ProfileController.dart';
import 'package:impactlyflutter/Widgets/Dropdown/DropdownCustom.dart';
import 'package:provider/provider.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Constant/text_styles.dart';
import 'package:impactlyflutter/Services/Failure.dart';
import 'package:impactlyflutter/Services/Routes.dart';
import 'package:impactlyflutter/Widgets/Button/ButtonCustom.dart';
import 'package:impactlyflutter/Widgets/TextInput/TextInputCustom.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(
      builder:
          (context, controller, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                "Profile",
                style: TextStyles.header.copyWith(color: AppColors.black),
              ),
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                onPressed: () => CustomRoute.RoutePop(context),
                icon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
              ),
            ),
            backgroundColor: AppColors.basic,
            body: Form(
              key: controller.keyform,
              child: ListView(
                padding: EdgeInsets.all(10),
                children: [
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
                    enable: false,
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

                  if (context.watch<ServicesProvider>().role != "User") Gap(22),
                  if (context.watch<ServicesProvider>().role != "User")
                    Text("Address", style: TextStyles.title),
                  if (context.watch<ServicesProvider>().role != "User") Gap(10),
                  if (context.watch<ServicesProvider>().role != "User")
                    TextInputCustom(
                      isrequierd: true,
                      hint: "Address",
                      controller: controller.address,
                    ),
                  if (context.watch<ServicesProvider>().role == "User") Gap(22),
                  if (context.watch<ServicesProvider>().role == "User")
                    Text("Birth of date", style: TextStyles.title),
                  if (context.watch<ServicesProvider>().role == "User") Gap(10),
                  if (context.watch<ServicesProvider>().role == "User")
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
                  if (context.watch<ServicesProvider>().role == "User") Gap(22),
                  if (context.watch<ServicesProvider>().role == "User")
                    Text("Governorates", style: TextStyles.title),
                  if (context.watch<ServicesProvider>().role == "User") Gap(10),
                  if (context.watch<ServicesProvider>().role == "User")
                    DropdownCustom<Governorate>(
                      isrequierd: true,
                      hint: "Governorates",
                      value: controller.governorate,
                      items:
                          (controller.governorates)
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.name ?? ""),
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
                    if (controller.governorate?.districts != null &&
                        controller.governorate!.districts!.isNotEmpty)
                      DropdownCustom<District>(
                        isrequierd: true,
                        hint: "Districts",
                        value: controller.districts,
                        items:
                            controller.governorate!.districts!
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.name ?? ""),
                                  ),
                                )
                                .toList(),
                        onChanged: (p0) {
                          controller.SelectDistricts(p0);
                        },
                      ),
                  if (context.watch<ServicesProvider>().role != "User") Gap(22),
                  if (context.watch<ServicesProvider>().role != "User")
                    Text("Association Name", style: TextStyles.title),
                  if (context.watch<ServicesProvider>().role != "User") Gap(10),
                  if (context.watch<ServicesProvider>().role != "User")
                    TextInputCustom(
                      isrequierd: true,
                      hint: "Association Name",
                      controller: controller.association_name,
                    ),

                  Gap(51),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 27),
                    child: ButtonCustom(
                      onTap: () async {
                        if (controller.keyform.currentState!.validate()) {
                          EasyLoading.show();
                          try {
                            Either<Failure, bool> res = await controller.Signup(
                              context,
                            );

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
                      title: "Update profile",
                      color: AppColors.thirdy,
                    ),
                  ),

                  Gap(20),
                ],
              ),
            ),
          ),
    );
  }
}
