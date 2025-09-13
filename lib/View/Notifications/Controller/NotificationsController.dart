// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:impactlyflutter/Constant/url.dart';
import 'package:impactlyflutter/Model/Notification.dart' as notification;
import 'package:impactlyflutter/Services/CustomDialog.dart';
import 'package:impactlyflutter/Services/Failure.dart';
import 'package:impactlyflutter/Services/NetworkClient.dart';

import 'package:provider/provider.dart';

class NotificationsController with ChangeNotifier {
  List<notification.Notification> notifications = []; // ✅ مو null
  Future<Either<Failure, bool>> Notifications(BuildContext context) async {
    final client = Provider.of<NetworkClient>(context, listen: false);
    try {
      final response = await client.request(
        path: AppApi.Notifications,
        withtoken: true,
        requestType: RequestType.GET,
      );

      log(response.statusCode.toString());
      log(response.body.toString());

      Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // wallet = Wallet.fromJson(data['wallet']);
        data['notifications'].forEach((v) {
          notifications.add(notification.Notification.fromJson(v));
        });
        // data['transactions']['received'].forEach((v) {
        //   receivedTransactions.add(Transactions.fromJson(v));
        // });
        notifyListeners();
        return Right(true);
      } else {
        CustomDialog.DialogError(context, title: "${data['message']}");
        return Left(GlobalFailure());
      }
    } catch (e) {
      log(e.toString());
      return Left(GlobalFailure());
    }
  }
}
