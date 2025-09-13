import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:impactlyflutter/View/Organizer/Home/Controller/HomePageOrganizerController.dart';
import 'package:impactlyflutter/View/Organizer/Home/HomePageOrganizer.dart';
=======
import 'package:impactlyflutter/View/MyEvent/Controller/MyEventController.dart';
import 'package:impactlyflutter/View/MyEvent/MyEvent.dart';
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
import 'package:impactlyflutter/View/Organizer/Settings/SettingsPageOrganizer.dart';
import 'package:provider/provider.dart';

class NavigationPageOrganizerController with ChangeNotifier {
  int index = 0;

  List<Widget> pages = [
    ChangeNotifierProvider(
<<<<<<< HEAD
      create: (context) => HomePageOrganizerController()..AllEvents(context),
      builder: (context, child) => HomePageOrganizer(),
    ),

=======
      create: (context) => MyEventController()..GetMyEvent(context),
      builder: (context, child) => MyEvent(),
    ),
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
    SettingsPageOrganizer(),
  ];
  ChangeIndex(int value) {
    index = value;
    notifyListeners();
  }
}
