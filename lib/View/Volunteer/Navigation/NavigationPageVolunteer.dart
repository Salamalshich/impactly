import 'package:flutter/material.dart';
import 'package:impactlyflutter/View/Volunteer/Navigation/Controller/NavigationPageEmployeerController.dart';
import 'package:impactlyflutter/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class NavigationPageVolunteer extends StatelessWidget {
  const NavigationPageVolunteer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationPageVolunteerController>(
      builder:
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
          ),
    );
  }
}
