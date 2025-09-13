// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:impactlyflutter/Services/Routes.dart';
import 'package:impactlyflutter/Services/ServicesProvider.dart';
import 'package:impactlyflutter/View/Auth/Login/Controller/LoginPageController.dart';
import 'package:impactlyflutter/View/Auth/Login/LoginPage.dart';
import 'package:impactlyflutter/View/OnBoarding/OnboardingScreen.dart';
import 'package:impactlyflutter/View/Organizer/Navigation/Controller/NavigationPageOrganizerController.dart';
import 'package:impactlyflutter/View/Organizer/Navigation/NavigationPageOrganizer.dart';
import 'package:impactlyflutter/View/Volunteer/Navigation/Controller/NavigationPageEmployeerController.dart';
import 'package:impactlyflutter/View/Volunteer/Navigation/NavigationPageVolunteer.dart';
import 'package:provider/provider.dart';

class SplashController with ChangeNotifier {
  @override
  dispose() {
    log("close splash");
    super.dispose();
  }

  whenIslogin(BuildContext context) async {
    Future.delayed(Duration(seconds: 5)).then((value) async {
      if (Provider.of<ServicesProvider>(
        context,
        listen: false,
      ).isShowBoarding) {
        if (Provider.of<ServicesProvider>(context, listen: false).isLoggedIn) {
          if (Provider.of<ServicesProvider>(context, listen: false).role ==
              'Organizer') {
            toHomePageOrganizer(context);
          } else {
            toHomePageVolunteer(context);
          }
        } else {
          toLoginPage(context);
        }
      } else {
        CustomRoute.RouteReplacementTo(context, OnboardingScreen());
      }
    });
  }

  toLoginPage(BuildContext context) {
    CustomRoute.RouteReplacementTo(
      context,
      ChangeNotifierProvider<Loginpagecontroller>(
        create: (context) => Loginpagecontroller(),
        child: Loginpage(),
      ),
    );
  }

  toHomePageVolunteer(BuildContext context) {
    CustomRoute.RouteReplacementTo(
      context,
      ChangeNotifierProvider(
        create: (context) => NavigationPageVolunteerController(),
        lazy: true,
        builder: (context, child) => NavigationPageVolunteer(),
      ),
    );
  }

  toHomePageOrganizer(BuildContext context) {
    CustomRoute.RouteReplacementTo(
      context,
      ChangeNotifierProvider(
        create: (context) => NavigationPageOrganizerController(),
        lazy: true,
        builder: (context, child) => NavigationPageOrganizer(),
      ),
    );
  }
}
