import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:impactlyflutter/Constant/url.dart';
import 'package:impactlyflutter/Model/Category.dart';
import 'package:impactlyflutter/Services/Failure.dart';
import 'package:impactlyflutter/Services/NetworkClient.dart';
import 'package:provider/provider.dart';
import 'package:impactlyflutter/Services/CustomDialog.dart';

class CategoryController with ChangeNotifier {
  List<Category> categories = [];

  Future<Either<Failure, List<Category>>> getCategories(
    BuildContext context,
  ) async {
    categories.clear();
    final client = Provider.of<NetworkClient>(context, listen: false);
    try {
      var response = await client.request(
        path: AppApi.CATEGORIES,
        requestType: RequestType.GET,
      );

      log(response.statusCode.toString());
      log(response.body);

      var json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        json.forEach((v) {
          categories.add(Category.fromJson(v));
        });
        notifyListeners();
        return Right(categories);
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
