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
import 'package:impactlyflutter/l10n/app_localizations.dart';
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
                AppLocalizations.of(context)!.profile,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (context.read<ServicesProvider>().role == 'User')
                        Row(
                          children: [
                            Text(
                              "${AppLocalizations.of(context)!.total_hours}:",
                              style: TextStyles.header,
                            ),
                            Gap(20),
                            Text(
                              "${controller.profile?.totalHours.toString() ?? ''}h",
                              style: TextStyles.title.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      Text(
                        "${controller.profile?.status ?? ''}",
                        style: TextStyles.subheader.copyWith(
                          color: AppColors.active,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Text(
                    AppLocalizations.of(context)!.full_name,
                    style: TextStyles.title,
                  ),
                  Gap(10),
                  TextInputCustom(
                    hint: AppLocalizations.of(context)!.full_name,
                    isrequierd: true,
                    controller: controller.fullname,
                  ),
                  Gap(22),
                  Text(
                    AppLocalizations.of(context)!.email,
                    style: TextStyles.title,
                  ),
                  Gap(10),
                  TextInputCustom(
                    hint: AppLocalizations.of(context)!.email_address,
                    isrequierd: true,
                    enable: false,
                    controller: controller.email,
                  ),
                  Gap(22),
                  Text(
                    AppLocalizations.of(context)!.phone_number,
                    style: TextStyles.title,
                  ),
                  Gap(10),
                  TextInputCustom(
                    isrequierd: true,
                    hint: AppLocalizations.of(context)!.phone_number,
                    controller: controller.phone,
                  ),
                  if (context.watch<ServicesProvider>().role != "User") Gap(22),
                  if (context.watch<ServicesProvider>().role != "User")
                    Text(
                      AppLocalizations.of(context)!.address,
                      style: TextStyles.title,
                    ),
                  if (context.watch<ServicesProvider>().role != "User") Gap(10),
                  if (context.watch<ServicesProvider>().role != "User")
                    TextInputCustom(
                      isrequierd: true,
                      hint: AppLocalizations.of(context)!.address,
                      controller: controller.address,
                    ),
                  if (context.watch<ServicesProvider>().role == "User") Gap(22),
                  if (context.watch<ServicesProvider>().role == "User")
                    Text(
                      AppLocalizations.of(context)!.birth_of_date,
                      style: TextStyles.title,
                    ),
                  if (context.watch<ServicesProvider>().role == "User") Gap(10),
                  if (context.watch<ServicesProvider>().role == "User")
                    TextInputCustom(
                      isrequierd: true,
                      controller: controller.bod,
                      hint: AppLocalizations.of(context)!.birth_of_date,
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
                    Text(
                      AppLocalizations.of(context)!.governorates,
                      style: TextStyles.title,
                    ),
                  if (context.watch<ServicesProvider>().role == "User") Gap(10),
                  if (context.watch<ServicesProvider>().role == "User")
                    DropdownCustom<Governorate>(
                      isrequierd: true,
                      hint: AppLocalizations.of(context)!.governorates,
                      value: controller.governorate,
                      items:
                          controller.governorates
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.name ?? ""),
                                ),
                              )
                              .toList(),
                      onChanged: (p0) => controller.SelectGovernorate(p0),
                    ),
                  if (controller.governorate != null) Gap(22),
                  if (controller.governorate != null)
                    Text(
                      AppLocalizations.of(context)!.districts,
                      style: TextStyles.title,
                    ),
                  if (controller.governorate != null) Gap(10),
                  if (controller.governorate != null)
                    if (controller.governorate?.districts != null &&
                        controller.governorate!.districts!.isNotEmpty)
                      DropdownCustom<District>(
                        isrequierd: true,
                        hint: AppLocalizations.of(context)!.districts,
                        value:
                            controller.districts != null &&
                                    controller.governorate!.districts!.any(
                                      (d) => d.id == controller.districts!.id,
                                    )
                                ? controller.districts
                                : null,
                        items:
                            controller.governorate!.districts!
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.name ?? ""),
                                  ),
                                )
                                .toList(),
                        onChanged: (p0) => controller.SelectDistricts(p0),
                      ),
                  if (context.watch<ServicesProvider>().role != "User") Gap(22),
                  if (context.watch<ServicesProvider>().role != "User")
                    Text(
                      AppLocalizations.of(context)!.association_name,
                      style: TextStyles.title,
                    ),
                  if (context.watch<ServicesProvider>().role != "User") Gap(10),
                  if (context.watch<ServicesProvider>().role != "User")
                    TextInputCustom(
                      isrequierd: true,
                      hint: AppLocalizations.of(context)!.association_name,
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
                            Either<Failure, bool> res =
                                await controller.UpdateProfile(context);
                            res.fold((l) {
                              EasyLoading.showError(l.message);
                              EasyLoading.dismiss();
                            }, (r) => EasyLoading.dismiss());
                          } catch (e) {
                            EasyLoading.dismiss();
                          }
                        }
                      },
                      title: AppLocalizations.of(context)!.update_profile,
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
