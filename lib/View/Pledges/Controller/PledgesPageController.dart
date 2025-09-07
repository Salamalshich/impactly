import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Constant/text_styles.dart';
import 'package:impactlyflutter/Controller/GovernorateController.dart';
import 'package:impactlyflutter/Model/Pledges.dart';
import 'package:impactlyflutter/Services/CustomDialog.dart';
import 'package:impactlyflutter/Services/Failure.dart';
import 'package:impactlyflutter/Services/Routes.dart';
import 'package:impactlyflutter/Widgets/TextInput/TextInputCustom.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:impactlyflutter/Constant/url.dart';
import 'package:impactlyflutter/Services/NetworkClient.dart';

class PledgesPageController with ChangeNotifier {
  bool isLoadinggetPledges = false;
  List<Pledges> listPledges = [];
  List<Pledges> listPledgesfilter = [];

  TextEditingController searchcontroller = TextEditingController();
  int? idPledges;
  void searchPledges(String query) {
    filterPledges(query: query);
  }

  void filterPledges({String query = ""}) {
    if (query.isEmpty) {
      // إذا ما في بحث، رجع القائمة الأصلية
      listPledgesfilter = List.from(listPledges);
    } else {
      listPledgesfilter =
          listPledges.where((pledges) {
            bool queryMatches =
                (pledges.itemName?.toLowerCase().contains(
                      query.toLowerCase(),
                    ) ??
                    false) ||
                (pledges.notes?.toLowerCase().contains(query.toLowerCase()) ??
                    false) ||
                (pledges.quantity?.toString().toLowerCase().contains(
                      query.toLowerCase(),
                    ) ??
                    false) ||
                (pledges.status?.toLowerCase().contains(query.toLowerCase()) ??
                    false);

            return queryMatches;
          }).toList();
    }
    notifyListeners();
  }

  TextEditingController item_namecontroller = TextEditingController();
  TextEditingController quantitycontroller = TextEditingController();
  TextEditingController notescontroller = TextEditingController();

  Future<Either<Failure, bool>> GetMyPledges(BuildContext context) async {
    final client = Provider.of<NetworkClient>(context, listen: false);
    listPledges.clear();
    isLoadinggetPledges = true;
    notifyListeners();
    try {
      final response = await client.request(
        path: AppApi.GetMyPledges,
        withtoken: true,
        requestType: RequestType.GET,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        var json = await jsonDecode(response.body);

        for (var pledges in json) {
          listPledges.add(Pledges.fromJson(pledges));
        }
        listPledgesfilter = listPledges;
        isLoadinggetPledges = false;
        notifyListeners();
        return Right(true);
      } else if (response.statusCode == 404) {
        isLoadinggetPledges = false;
        notifyListeners();
        return Left(ResultFailure(''));
      } else {
        isLoadinggetPledges = false;
        notifyListeners();
        return Left(GlobalFailure());
      }
    } catch (e) {
      isLoadinggetPledges = false;
      notifyListeners();
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  Future<Either<Failure, bool>> AddPledge(BuildContext context) async {
    final client = Provider.of<NetworkClient>(context, listen: false);

    try {
      final response = await client.request(
        path: AppApi.AddPledge,
        withtoken: true,

        requestType: RequestType.POST,
        body: jsonEncode({
          "item_name": item_namecontroller.text,
          "quantity": quantitycontroller.text,
          "notes": notescontroller.text,
        }),
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        CustomRoute.RoutePop(context);
        cleardata();
        CustomDialog.DialogSuccess(context, title: "${data['message']}");
        GetMyPledges(context);
        return Right(true);
      } else if (response.statusCode == 404) {
        return Left(ResultFailure(''));
      } else {
        return Left(GlobalFailure());
      }
    } catch (e) {
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  cleardata() {
    item_namecontroller.clear();
    quantitycontroller.clear();
    notescontroller.clear();
  }

  filldata(Pledges pledge, BuildContext context) async {
    item_namecontroller.text = pledge.itemName!;
    quantitycontroller.text = pledge.quantity!.toString();
    notescontroller.text = pledge.notes!;
  }

  DialogAddOrUpdatePledges(BuildContext context, {Pledges? pledge}) async {
    await context.read<GovernorateController>().getGovernorates(context);
    final formkey = GlobalKey<FormState>();
    if (pledge != null) {
      filldata(pledge, context);
    }
    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("${pledge != null ? "Update" : "Add New"} Pledge"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                content: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Item name", style: TextStyles.title),
                          Gap(5),
                          TextInputCustom(
                            controller: item_namecontroller,
                            hint: "Item name",
                            icon: Icon(Icons.title),
                          ),
                          Gap(10),
                          Text("Quantity", style: TextStyles.title),
                          Gap(5),
                          TextInputCustom(
                            controller: quantitycontroller,
                            hint: "Quantitiy",
                            icon: Icon(Icons.numbers_outlined),
                          ),
                          Gap(10),
                          Text("Location", style: TextStyles.title),
                          Gap(5),
                          TextInputCustom(
                            controller: notescontroller,
                            hint: "Notes",
                            icon: Icon(Icons.notes_outlined),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        EasyLoading.show();
                        try {
                          Either<Failure, bool> result;
                          if (pledge != null) {
                            result = await UpdatePledge(context, pledge.id!);
                          } else {
                            result = await AddPledge(context);
                          }
                          result.fold(
                            (l) {
                              EasyLoading.showError(l.message);
                              EasyLoading.dismiss();
                            },
                            (r) {
                              EasyLoading.dismiss();
                            },
                          );
                        } catch (e) {
                          EasyLoading.dismiss();
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          pledge != null ? "Update" : "Add",
                          style: TextStyles.button,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      cleardata();

                      CustomRoute.RoutePop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Close",
                        style: TextStyles.pramed.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
    );
  }

  Future<Either<Failure, bool>> UpdatePledge(
    BuildContext context,
    int id,
  ) async {
    final client = Provider.of<NetworkClient>(context, listen: false);

    try {
      final response = await client.request(
        path: AppApi.UpdatePledge(id),
        withtoken: true,
        requestType: RequestType.PUT,
        body: jsonEncode({
          "item_name": item_namecontroller.text,
          "quantity": quantitycontroller.text,
          "notes": notescontroller.text,
        }),
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        CustomRoute.RoutePop(context);
        cleardata();
        CustomDialog.DialogSuccess(context, title: "${data['message']}");
        GetMyPledges(context);
        return Right(true);
      } else if (response.statusCode == 404) {
        CustomDialog.DialogError(context, title: "${data['message']}");
        return Right(true);
      } else if (response.statusCode == 422) {
        CustomDialog.DialogError(context, title: "${data['message']}");
        return Right(true);
      } else {
        return Left(GlobalFailure());
      }
    } catch (e) {
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  Future<Either<Failure, bool>> DeletePledges(
    BuildContext context,
    int id,
  ) async {
    final client = Provider.of<NetworkClient>(context, listen: false);

    try {
      final response = await client.request(
        path: AppApi.DeletePledge(id),
        withtoken: true,

        requestType: RequestType.DELETE,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        CustomRoute.RoutePop(context);
        CustomDialog.DialogSuccess(context, title: "${data['message']}");
        GetMyPledges(context);
        return Right(true);
      } else if (response.statusCode == 404) {
        CustomDialog.DialogError(context, title: "${data['message']}");
        return Right(true);
      } else {
        return Left(GlobalFailure());
      }
    } catch (e) {
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  DialogDeletePledges(BuildContext context, Pledges Pledges) {
    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("Delete Pledge"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                content: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          "Are you sure you want to delete the pledge and its associated data?",
                          style: TextStyles.paraghraph,
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () async {
                      EasyLoading.show();
                      try {
                        Either<Failure, bool> result = await DeletePledges(
                          context,
                          Pledges.id!,
                        );
                        result.fold(
                          (l) {
                            EasyLoading.showError(l.message);
                            EasyLoading.dismiss();
                          },
                          (r) {
                            EasyLoading.dismiss();
                          },
                        );
                      } catch (e) {
                        EasyLoading.dismiss();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Delete", style: TextStyles.button),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      CustomRoute.RoutePop(context);
                      cleardata();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Close",
                        style: TextStyles.pramed.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
    );
  }
}
