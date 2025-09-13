import 'package:flutter/material.dart';
import 'package:impactlyflutter/View/Volunteer/Home/Controller/HomePageVolunteerController.dart';
import 'package:impactlyflutter/View/Volunteer/Home/HomePageVolunteer.dart';
import 'package:impactlyflutter/View/Volunteer/QrScanner/Controller/QrScannerController.dart';
import 'package:impactlyflutter/View/Volunteer/QrScanner/QrScanner.dart';
import 'package:impactlyflutter/View/Volunteer/Settings/SettingsPageVolunteer.dart';
import 'package:provider/provider.dart';

class NavigationPageVolunteerController with ChangeNotifier {
  int index = 1;

  List<Widget> pages = [
    ChangeNotifierProvider(
      create: (context) => QrScannerController()..initState(),
      builder: (context, child) => Qrscanner(),
    ),
    ChangeNotifierProvider(
      create:
          (context) => HomePageVolunteerController()..DistrictEvents(context),
      builder: (context, child) => HomePageVolunteer(),
    ),
    SettingsPageVolunteer(),
  ];
  ChangeIndex(int value) {
    index = value;
    notifyListeners();
  }
}
