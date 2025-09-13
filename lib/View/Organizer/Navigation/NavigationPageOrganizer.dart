import 'package:flutter/material.dart';
import 'package:impactlyflutter/View/Organizer/Navigation/Controller/NavigationPageOrganizerController.dart';
<<<<<<< HEAD
import 'package:impactlyflutter/l10n/app_localizations.dart';
=======
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
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
<<<<<<< HEAD
                  label: AppLocalizations.of(context)!.allevent,
                  icon: Icon(Icons.event),
                ),

                BottomNavigationBarItem(
                  label: AppLocalizations.of(context)!.settings,

=======
                  label: "Event",
                  icon: Icon(Icons.event_available),
                ),
                BottomNavigationBarItem(
                  label: "Setting",
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
                  icon: Icon(Icons.settings),
                ),
              ],
            ),
            body: controller.pages[controller.index],
          ),
    );
  }
}
