import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:impactlyflutter/Constant/url.dart';
import 'package:impactlyflutter/Services/Failure.dart';
import 'package:impactlyflutter/Services/NetworkClient.dart';
import 'package:impactlyflutter/Services/Routes.dart';
import 'package:impactlyflutter/View/Organizer/Navigation/Controller/NavigationPageOrganizerController.dart';
import 'package:impactlyflutter/View/Organizer/Navigation/NavigationPageOrganizer.dart';
import 'package:impactlyflutter/View/Volunteer/Navigation/Controller/NavigationPageEmployeerController.dart';
import 'package:impactlyflutter/View/Volunteer/Navigation/NavigationPageVolunteer.dart';
import 'package:provider/provider.dart';
import 'package:impactlyflutter/Services/CustomDialog.dart';
import 'package:impactlyflutter/Services/ServicesProvider.dart';

class Loginpagecontroller with ChangeNotifier {
  GlobalKey<FormState> keyform = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Future<Either<Failure, bool>> Login(BuildContext context) async {
    final client = Provider.of<NetworkClient>(context, listen: false);
    String? device_token = await FirebaseMessaging.instance.getToken();
    log(device_token!);
    try {
      var response = await client.request(
        path: AppApi.LOGIN,
        requestType: RequestType.POST,
        body: jsonEncode({
          "email": email.text,
          "password": password.text,
          "device_token": device_token,
        }),
      );

      log(response.statusCode.toString());
      log(response.body);
      var json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List<dynamic> roles = json['roles'];
        if (roles.contains("Organizer")) {
          await context.read<ServicesProvider>().saveTokenAndRole(
            json['token'],
            "Organizer",
          );
          CustomRoute.RouteReplacementTo(
            context,
            ChangeNotifierProvider(
              create: (context) => NavigationPageOrganizerController(),
              lazy: true,
              builder: (context, child) => NavigationPageOrganizer(),
            ),
          );
        } else {
          if (roles.contains("User")) {
            await context.read<ServicesProvider>().saveTokenAndRole(
              json['token'],
              "User",
            );
            CustomRoute.RouteReplacementTo(
              context,
              ChangeNotifierProvider(
                create: (context) => NavigationPageVolunteerController(),
                lazy: true,
                builder: (context, child) => NavigationPageVolunteer(),
              ),
            );
          }
        }

        return Right(true);
      } else if (response.statusCode == 500) {
        CustomDialog.DialogError(context, title: json);

        return Right(false);
      } else if (response.statusCode == 401) {
        if (json.containsKey('message')) {
          CustomDialog.DialogError(context, title: json['message']);
        }
        return Right(false);
      } else {
        CustomDialog.DialogError(context, title: json);
        return Right(false);
      }
    } catch (e) {
      log(e.toString());
      return Left(GlobalFailure());
    }
  }
}
