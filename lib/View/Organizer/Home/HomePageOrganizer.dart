import 'package:flutter/material.dart';
import 'package:impactlyflutter/View/Organizer/Home/Controller/HomePageOrganizerController.dart';
import 'package:provider/provider.dart';

class HomePageOrganizer extends StatelessWidget {
  const HomePageOrganizer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageOrganizerController>(
      builder: (context, controller, child) => Scaffold(),
    );
  }
}
