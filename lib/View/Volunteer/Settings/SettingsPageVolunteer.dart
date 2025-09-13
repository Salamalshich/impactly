import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:impactlyflutter/Constant/text_styles.dart';
import 'package:impactlyflutter/Services/ServicesProvider.dart';
<<<<<<< HEAD
import 'package:impactlyflutter/View/Language/LanguageSelector.dart';
import 'package:impactlyflutter/View/MyEvent/Controller/MyEventController.dart';
import 'package:impactlyflutter/View/MyEvent/MyEvent.dart';
import 'package:impactlyflutter/View/Notifications/Controller/NotificationsController.dart';
import 'package:impactlyflutter/View/Notifications/NotificationsPage.dart';
=======
import 'package:impactlyflutter/View/MyEvent/Controller/MyEventController.dart';
import 'package:impactlyflutter/View/MyEvent/MyEvent.dart';
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
import 'package:impactlyflutter/View/Pledges/Controller/PledgesPageController.dart';
import 'package:impactlyflutter/View/Pledges/PledgesPage.dart';
import 'package:impactlyflutter/View/Profile/Controller/ProfileController.dart';
import 'package:impactlyflutter/View/Profile/ProfilePage.dart';
import 'package:impactlyflutter/View/Volunteer/ManagementEvent/Controller/ManagementEventController.dart';
import 'package:impactlyflutter/View/Volunteer/ManagementEvent/ManagementEvent.dart';
<<<<<<< HEAD
import 'package:impactlyflutter/View/Volunteer/Report/Controller/ReportPageController.dart';
import 'package:impactlyflutter/View/Volunteer/Report/ReportPage.dart';
import 'package:impactlyflutter/View/Wallet/Controller/WalletController.dart';
import 'package:impactlyflutter/View/Wallet/WalletPage.dart';
import 'package:impactlyflutter/l10n/app_localizations.dart';
=======
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
import 'package:provider/provider.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Services/Routes.dart';
import 'package:impactlyflutter/View/Auth/Login/Controller/LoginPageController.dart';
import 'package:impactlyflutter/View/Auth/Login/LoginPage.dart';
import 'package:impactlyflutter/Widgets/Button/ButtonCustom.dart';

class SettingsPageVolunteer extends StatelessWidget {
  const SettingsPageVolunteer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: TextStyles.header.copyWith(color: AppColors.black),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          buildButton(
            context,
            iconPath: "assets/SVG/profile.svg",
            label: AppLocalizations.of(context)!.profile,
=======
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Gap(20),
          Center(
            child: Text(
              "Settings",
              style: TextStyles.header.copyWith(color: AppColors.black),
            ),
          ),
          ButtonCustom(
            borderradius: 15,
            fullheight: true,
            bordersize: 0.5,
            bordercolor: Color(0x1A000000),
            color: const Color(0x0d000000),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 17),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/SVG/profile.svg",
                    color: Color(0xff1D1B20),
                  ),
                  Gap(7),
                  Text(
                    "Profile",
                    style: TextStyles.paraghraph.copyWith(
                      color: Color(0xff1D1B20),
                    ),
                  ),
                ],
              ),
            ),
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
            onTap: () async {
              CustomRoute.RouteTo(
                context,
                ChangeNotifierProvider(
                  create:
                      (context) =>
                          ProfileController()
                            ..getGovernorates(context)
                            ..GetProfile(context),
                  builder: (context, child) => ProfilePage(),
                ),
              );
            },
          ),
          Gap(20),
<<<<<<< HEAD
          buildButton(
            context,
            iconPath: "assets/SVG/wallet.svg",
            label: AppLocalizations.of(context)!.wallet,
            onTap: () async {
              CustomRoute.RouteTo(
                context,
                ChangeNotifierProvider(
                  create: (context) => WalletController()..GetWallet(context),
                  builder: (context, child) => WalletPage(),
                ),
              );
            },
          ),
          Gap(20),
          buildButton(
            context,
            iconPath: "assets/SVG/event.svg",
            label: AppLocalizations.of(context)!.event_management,
=======
          ButtonCustom(
            borderradius: 15,
            fullheight: true,
            bordersize: 0.5,
            bordercolor: Color(0x1A000000),
            color: const Color(0x0d000000),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 17),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/SVG/event.svg",
                    color: Color(0xff1D1B20),
                  ),
                  Gap(7),
                  Text(
                    "Event Management",
                    style: TextStyles.paraghraph.copyWith(
                      color: Color(0xff1D1B20),
                    ),
                  ),
                ],
              ),
            ),
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
            onTap: () async {
              CustomRoute.RouteTo(
                context,
                ChangeNotifierProvider(
                  create:
                      (context) =>
                          ManagementEventController()
                            ..MyRegisteredEvents(context),
                  builder: (context, child) => ManagementEvent(),
                ),
              );
            },
          ),
          Gap(20),
<<<<<<< HEAD
          buildButton(
            context,
            iconPath: "assets/SVG/Manegment_Event.svg",
            label: AppLocalizations.of(context)!.my_event,
=======
          ButtonCustom(
            borderradius: 15,
            fullheight: true,
            bordersize: 0.5,
            bordercolor: Color(0x1A000000),
            color: const Color(0x0d000000),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 17),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/SVG/Manegment_Event.svg",
                    color: Color(0xff1D1B20),
                  ),
                  Gap(7),
                  Text(
                    "My Event",
                    style: TextStyles.paraghraph.copyWith(
                      color: Color(0xff1D1B20),
                    ),
                  ),
                ],
              ),
            ),
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
            onTap: () async {
              CustomRoute.RouteTo(
                context,
                ChangeNotifierProvider(
                  create: (context) => MyEventController()..GetMyEvent(context),
                  builder: (context, child) => MyEvent(),
                ),
              );
            },
          ),
          Gap(20),
<<<<<<< HEAD
          buildButton(
            context,
            iconPath: "assets/SVG/pledge.svg",
            label: AppLocalizations.of(context)!.my_pledges,
=======
          ButtonCustom(
            borderradius: 15,
            fullheight: true,
            bordersize: 0.5,
            bordercolor: Color(0x1A000000),
            color: const Color(0x0d000000),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 17),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/SVG/pledge.svg",

                    color: Color(0xff1D1B20),
                  ),
                  Gap(7),
                  Text(
                    "My Pledages",
                    style: TextStyles.paraghraph.copyWith(
                      color: Color(0xff1D1B20),
                    ),
                  ),
                ],
              ),
            ),
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
            onTap: () async {
              CustomRoute.RouteTo(
                context,
                ChangeNotifierProvider(
                  create:
                      (context) =>
                          PledgesPageController()..GetMyPledges(context),
                  builder: (context, child) => PledgesPage(),
                ),
              );
            },
          ),
          Gap(20),
<<<<<<< HEAD
          buildButton(
            context,
            iconPath: "assets/SVG/notifications.svg",
            label: AppLocalizations.of(context)!.notifications,
            onTap: () async {
              CustomRoute.RouteTo(
                context,
                ChangeNotifierProvider(
                  create:
                      (context) =>
                          NotificationsController()..Notifications(context),
                  builder: (context, child) => NotificationsPage(),
                ),
              );
            },
          ),
          Gap(20),
          buildButton(
            context,
            iconPath: "assets/SVG/report.svg",
            label: AppLocalizations.of(context)!.reports,
            onTap: () async {
              CustomRoute.RouteTo(
                context,
                ChangeNotifierProvider(
                  create:
                      (context) =>
                          ReportPageController()..GetMyReports(context),
                  builder: (context, child) => ReportPage(),
                ),
              );
            },
          ),
          Gap(20),
          buildButton(
            context,
            iconPath: "assets/SVG/language.svg",
            label: AppLocalizations.of(context)!.language,
            onTap: () async {
              CustomRoute.RouteTo(context, LanguageSelector());
            },
          ),
          Gap(20),
          buildButton(
            context,
            iconPath: "assets/SVG/Log out.svg",
            label: AppLocalizations.of(context)!.logout,
=======
          ButtonCustom(
            borderradius: 15,
            fullheight: true,
            bordersize: 0.5,
            bordercolor: Color(0x1A000000),
            color: const Color(0x0d000000),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 17),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/SVG/Log out.svg",
                    color: Color(0xff1D1B20),
                  ),
                  Gap(7),
                  Text(
                    "Logout",
                    style: TextStyles.paraghraph.copyWith(
                      color: Color(0xff1D1B20),
                    ),
                  ),
                ],
              ),
            ),
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
            onTap: () async {
              await context.read<ServicesProvider>().logout();
              CustomRoute.RouteAndRemoveUntilTo(
                context,
                ChangeNotifierProvider(
                  create: (context) => Loginpagecontroller(),
                  builder: (context, child) => Loginpage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
<<<<<<< HEAD

  Widget buildButton(
    BuildContext context, {
    required String iconPath,
    required String label,
    required VoidCallback onTap,
  }) {
    return ButtonCustom(
      borderradius: 15,
      fullheight: true,
      bordersize: 0.5,
      bordercolor: Color(0x1A000000),
      color: const Color(0x0d000000),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 17),
        child: Row(
          children: [
            SvgPicture.asset(iconPath, color: Color(0xff1D1B20)),
            Gap(7),
            Text(
              label,
              style: TextStyles.paraghraph.copyWith(color: Color(0xff1D1B20)),
            ),
          ],
        ),
      ),
    );
  }
=======
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
}
