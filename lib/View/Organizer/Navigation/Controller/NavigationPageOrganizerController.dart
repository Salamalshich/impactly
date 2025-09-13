import 'package:flutter/material.dart';
import 'package:impactlyflutter/View/Organizer/Home/Controller/HomePageOrganizerController.dart';
import 'package:impactlyflutter/View/Organizer/Home/HomePageOrganizer.dart';
import 'package:impactlyflutter/View/Organizer/Settings/SettingsPageOrganizer.dart';
import 'package:provider/provider.dart';

class NavigationPageOrganizerController with ChangeNotifier {
  int index = 0;

  List<Widget> pages = [
    ChangeNotifierProvider(
      create: (context) => HomePageOrganizerController()..AllEvents(context),
      builder: (context, child) => HomePageOrganizer(),
    ),

    SettingsPageOrganizer(),
  ];
  ChangeIndex(int value) {
    index = value;
    notifyListeners();
  }
}
