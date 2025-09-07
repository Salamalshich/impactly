import 'package:flutter/material.dart';
import 'package:impactlyflutter/View/Volunteer/Navigation/Controller/NavigationPageEmployeerController.dart';
import 'package:provider/provider.dart';

class NavigationPageVolunteer extends StatelessWidget {
  const NavigationPageVolunteer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationPageVolunteerController>(
      builder:
          (context, controller, child) => Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.index,

              onTap: (value) => controller.ChangeIndex(value),
              items: [
                BottomNavigationBarItem(
                  label: "Qr Scanner",
                  icon: Icon(Icons.qr_code_scanner),
                ),
                BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
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
