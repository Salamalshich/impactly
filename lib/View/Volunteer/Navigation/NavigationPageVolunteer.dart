import 'package:flutter/material.dart';
import 'package:impactlyflutter/View/Volunteer/Navigation/Controller/NavigationPageEmployeerController.dart';
<<<<<<< HEAD
import 'package:impactlyflutter/l10n/app_localizations.dart';
=======
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
import 'package:provider/provider.dart';

class NavigationPageVolunteer extends StatelessWidget {
  const NavigationPageVolunteer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationPageVolunteerController>(
      builder:
<<<<<<< HEAD
          (context, controller, child) => SafeArea(
            child: Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: controller.index,
                onTap: (value) => controller.ChangeIndex(value),
                items: [
                  BottomNavigationBarItem(
                    label: AppLocalizations.of(context)!.qr_scanner,
                    icon: Icon(Icons.qr_code_scanner),
                  ),
                  BottomNavigationBarItem(
                    label: AppLocalizations.of(context)!.home,
                    icon: Icon(Icons.home),
                  ),
                  BottomNavigationBarItem(
                    label: AppLocalizations.of(context)!.settings,
                    icon: Icon(Icons.settings),
                  ),
                ],
              ),
              body: controller.pages[controller.index],
            ),
=======
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
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
          ),
    );
  }
}
