import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:impactlyflutter/Constant/url.dart';
import 'package:impactlyflutter/Model/Report.dart';
import 'package:impactlyflutter/Services/Failure.dart';
import 'package:impactlyflutter/Services/NetworkClient.dart';
import 'package:provider/provider.dart';

class ReportPageController with ChangeNotifier {
  bool isLoadinggetReports = false;
  List<Reports> listReports = [];
  Future<Either<Failure, bool>> GetMyReports(BuildContext context) async {
    final client = Provider.of<NetworkClient>(context, listen: false);
    listReports.clear();
    isLoadinggetReports = true;
    notifyListeners();
    try {
      final response = await client.request(
        path: AppApi.MyReports,
        withtoken: true,
        requestType: RequestType.GET,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        var json = await jsonDecode(response.body);

        for (var report in json['reports']) {
          listReports.add(Reports.fromJson(report));
        }
        isLoadinggetReports = false;
        notifyListeners();
        return Right(true);
      } else if (response.statusCode == 404) {
        isLoadinggetReports = false;
        notifyListeners();
        return Left(ResultFailure(''));
      } else {
        isLoadinggetReports = false;
        notifyListeners();
        return Left(GlobalFailure());
      }
    } catch (e) {
      isLoadinggetReports = false;
      notifyListeners();
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }
}
