import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:impactlyflutter/Constant/url.dart';
import 'package:impactlyflutter/Model/Governorate.dart';
import 'package:impactlyflutter/Services/Failure.dart';
import 'package:impactlyflutter/Services/NetworkClient.dart';
import 'package:provider/provider.dart';
import 'package:impactlyflutter/Services/CustomDialog.dart';

class GovernorateController with ChangeNotifier {
  List<Governorate> governorates = [];

  Future<Either<Failure, List<Governorate>>> getGovernorates(
    BuildContext context,
  ) async {
    governorates.clear();
    final client = Provider.of<NetworkClient>(context, listen: false);
    try {
      var response = await client.request(
        path: AppApi.GOVERNORATES,
        requestType: RequestType.GET,
      );

      log(response.statusCode.toString());
      log(response.body);

      var json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (json.containsKey('data')) {
          json['data'].forEach((v) {
            governorates.add(Governorate.fromJson(v));
          });
          notifyListeners();
          return Right(governorates);
        } else {
          return Right([]);
        }
      } else {
        CustomDialog.DialogError(
          context,
          title: json['message'] ?? 'Something went wrong',
        );
        return Left(GlobalFailure());
      }
    } catch (e) {
      log(e.toString());
      return Left(GlobalFailure());
    }
  }
}
