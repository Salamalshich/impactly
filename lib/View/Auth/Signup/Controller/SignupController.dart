import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:impactlyflutter/Constant/url.dart';
import 'package:impactlyflutter/Model/Districts.dart';
import 'package:impactlyflutter/Model/Governorate.dart';
import 'package:impactlyflutter/Services/Failure.dart';
import 'package:impactlyflutter/Services/NetworkClient.dart';
import 'package:impactlyflutter/Services/Routes.dart';
import 'package:impactlyflutter/View/Auth/Login/Controller/LoginPageController.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:impactlyflutter/Services/CustomDialog.dart';
import 'package:impactlyflutter/View/Auth/Login/LoginPage.dart';

class SignupController with ChangeNotifier {
  GlobalKey<FormState> keyform = GlobalKey<FormState>();
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  int role = 2;
  Governorate? governorate;
  District? districts;
  TextEditingController address = TextEditingController();
  TextEditingController association_name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController bod = TextEditingController();
  SelectBod(value) {
    bod.text = value;
    notifyListeners();
  }

  PickBirthday(BuildContext context) {
    showDatePicker(
      context: context,
      firstDate: DateTime(1950),
      lastDate: DateTime(DateTime.now().year),
    ).then((value) {
      SelectBod(DateFormat('yyyy-MM-dd').format(value!).toString());
    });
  }

  SelectGovernorate(value) {
    governorate = value;
<<<<<<< HEAD
    districts = null;
=======
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
    notifyListeners();
  }

  SelectDistricts(value) {
    districts = value;
    notifyListeners();
  }

  SelectRole(value) {
    role = value;
<<<<<<< HEAD
    if (role == 1) {
      governorate = null;
      districts = null;
      bod.clear();
      fullname.clear();
    } else {
      association_name.clear();
      address.clear();
    }
=======
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
    notifyListeners();
  }

  Future<Either<Failure, bool>> Signup(BuildContext context) async {
    final client = Provider.of<NetworkClient>(context, listen: false);
    try {
      var response = await client.request(
        path: AppApi.REGISTER,
        requestType: RequestType.POST,
        body: jsonEncode({
          "name": fullname.text,
          "password": password.text,
          "email": email.text,
          "phone": phone.text,
          "address": address.text,
          "association_name": association_name.text,
          "birth_date": bod.text,
          "district_id": districts?.id?.toString(),
          "role_id": role, // 1 = Organizer , 2= User
        }),
      );

      log(response.statusCode.toString());
      log(response.body);
      var json = jsonDecode(response.body);

      if (response.statusCode == 201) {
        CustomRoute.RouteReplacementTo(
          context,
          ChangeNotifierProvider(
            create: (context) => Loginpagecontroller(),
            lazy: true,
            builder: (context, child) => Loginpage(),
          ),
        );
        CustomDialog.DialogSuccess(context, title: json['message']);
        return Right(true);
      } else if (response.statusCode == 400) {
        if (json.containsKey('errors')) {
          var userErrors = json['errors'];

          if (userErrors.containsKey('name') && userErrors['name'] != null) {
            CustomDialog.DialogError(context, title: userErrors['name'][0]);
          }

          if (userErrors.containsKey('email') && userErrors['email'] != null) {
            CustomDialog.DialogError(context, title: userErrors['email'][0]);
          }

          if (userErrors.containsKey('phone') && userErrors['phone'] != null) {
            CustomDialog.DialogError(context, title: userErrors['phone'][0]);
          }

          if (userErrors.containsKey('password') &&
              userErrors['password'] != null) {
            CustomDialog.DialogError(context, title: userErrors['password'][0]);
          }
        }

        if (json.containsKey('address') && json['address'] != null) {
          CustomDialog.DialogError(context, title: json['address'][0]);
        }

        return Right(false);
      } else {
        CustomDialog.DialogError(context, title: json['message']);
        return Right(false);
      }
    } catch (e) {
      log(e.toString());
      return Left(GlobalFailure());
    }
  }

  List<Governorate> governorates = [];

  Future<Either<Failure, List<Governorate>>> getGovernorates(
    BuildContext context,
  ) async {
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
