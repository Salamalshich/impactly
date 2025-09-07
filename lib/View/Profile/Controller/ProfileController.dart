import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:impactlyflutter/Constant/url.dart';
import 'package:impactlyflutter/Model/Districts.dart';
import 'package:impactlyflutter/Model/Governorate.dart';
import 'package:impactlyflutter/Model/Profile.dart';
import 'package:impactlyflutter/Services/Failure.dart';
import 'package:impactlyflutter/Services/NetworkClient.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:impactlyflutter/Services/CustomDialog.dart';

class ProfileController with ChangeNotifier {
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
  Profile? profile;
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
      if (value != null) {
        SelectBod(DateFormat('yyyy-MM-dd').format(value).toString());
      }
    });
  }

  SelectGovernorate(value) {
    governorate = value;
    notifyListeners();
  }

  SelectDistricts(value) {
    districts = value;
    notifyListeners();
  }

  SelectRole(value) {
    role = value;
    notifyListeners();
  }

  void fillProfileData() {
    if (profile == null) return;

    fullname.text = profile!.name ?? '';
    email.text = profile!.email ?? '';
    phone.text = profile!.phone ?? '';
    address.text = profile!.address ?? '';
    association_name.text = profile!.associationName ?? '';
    bod.text = profile!.birthDate ?? '';

    if (profile!.district != null) {
      try {
        for (var gov in governorates) {
          var dist = gov.districts?.firstWhere(
            (d) => d.id == profile!.district!.id,
            orElse: () => District(id: -1, name: "Not Found"),
          );
          if (dist != null && dist.id != -1) {
            districts = dist;
            governorate = gov;
            break;
          }
        }
      } catch (e) {
        log("Error mapping district: $e");
      }
    }

    notifyListeners();
  }

  Future<Either<Failure, bool>> GetProfile(BuildContext context) async {
    final client = Provider.of<NetworkClient>(context, listen: false);
    try {
      var response = await client.request(
        path: AppApi.GetProfile,
        requestType: RequestType.GET,
        withtoken: true,
      );

      log(response.statusCode.toString());
      log(response.body);
      var json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        profile = Profile.fromJson(json);
        fillProfileData();
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

  Future<Either<Failure, bool>> Signup(BuildContext context) async {
    final client = Provider.of<NetworkClient>(context, listen: false);
    try {
      var response = await client.request(
        path: AppApi.UpdateProfile,
        withtoken: true,
        requestType: RequestType.PUT,
        body: jsonEncode({
          "name": fullname.text,
          "email": email.text,
          "phone": phone.text,
          "address": address.text,
          "association_name": association_name.text,
          "birth_date": bod.text,
          "district_id": districts?.id?.toString(),
        }),
      );

      log(response.statusCode.toString());
      log(response.body);
      var json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        CustomDialog.DialogSuccess(
          context,
          title: "Update Profile Successfully",
        );
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
        governorates.clear(); // مهم لحتى ما يكرر البيانات
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
