import 'package:flutter/material.dart';
import 'package:impactlyflutter/View/Organizer/Navigation/Controller/NavigationPageOrganizerController.dart';
import 'package:provider/provider.dart';

class NavigationPageOrganizer extends StatelessWidget {
  const NavigationPageOrganizer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationPageOrganizerController>(
      builder:
          (context, controller, child) => Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.index,
              type: BottomNavigationBarType.fixed,
              onTap: (value) => controller.ChangeIndex(value),
              items: [
                BottomNavigationBarItem(
                  label: "Event",
                  icon: Icon(Icons.event_available),
                ),
                BottomNavigationBarItem(
                  label: "Setting",
                  icon: Icon(Icons.settings),
                ),
              ],
            ),
            body: controller.pages[controller.index],
          ),
    );
  }
}
