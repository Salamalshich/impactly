// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:impactlyflutter/Constant/url.dart';
import 'package:impactlyflutter/Model/Transactions.dart';
import 'package:impactlyflutter/Model/Wallet.dart';
import 'package:impactlyflutter/Services/CustomDialog.dart';
import 'package:impactlyflutter/Services/Failure.dart';
import 'package:impactlyflutter/Services/NetworkClient.dart';

import 'package:provider/provider.dart';

class WalletController with ChangeNotifier {
  Wallet? wallet;
  List<Transactions> receivedTransactions = []; // ✅ مو null
  List<Transactions> sentTransactions = [];
  Future<Either<Failure, bool>> GetWallet(BuildContext context) async {
    final client = Provider.of<NetworkClient>(context, listen: false);
    try {
      final response = await client.request(
        path: AppApi.GetWallet,
        withtoken: true,
        requestType: RequestType.GET,
      );

      log(response.statusCode.toString());
      log(response.body.toString());

      Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        wallet = Wallet.fromJson(data['wallet']);
        data['transactions']['sent'].forEach((v) {
          sentTransactions.add(Transactions.fromJson(v));
        });
        data['transactions']['received'].forEach((v) {
          receivedTransactions.add(Transactions.fromJson(v));
        });
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
