import 'package:flutter/material.dart';
import 'package:impactlyflutter/View/MyEvent/Controller/MyEventController.dart';
import 'package:impactlyflutter/View/MyEvent/MyEvent.dart';
import 'package:impactlyflutter/View/Organizer/Settings/SettingsPageOrganizer.dart';
import 'package:provider/provider.dart';

class NavigationPageOrganizerController with ChangeNotifier {
  int index = 0;

  List<Widget> pages = [
    ChangeNotifierProvider(
      create: (context) => MyEventController()..GetMyEvent(context),
      builder: (context, child) => MyEvent(),
    ),
    SettingsPageOrganizer(),
  ];
  ChangeIndex(int value) {
    index = value;
    notifyListeners();
  }
}
