import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Constant/text_styles.dart';
import 'package:impactlyflutter/Constant/url.dart';
import 'package:impactlyflutter/Model/Event.dart';
import 'package:impactlyflutter/Services/CustomDialog.dart';
import 'package:impactlyflutter/Services/Failure.dart';
import 'package:impactlyflutter/Services/NetworkClient.dart';
import 'package:impactlyflutter/Services/Routes.dart';
import 'package:impactlyflutter/Widgets/TextInput/TextInputCustom.dart';
import 'package:provider/provider.dart';

class HomePageVolunteerController with ChangeNotifier {
  bool isLoadinggetEvent = false;
  List<Event> listEvent = [];
  List<Event> listEventfilter = [];
  TextEditingController searchcontroller = TextEditingController();
  // Logger logger = Logger();
  int? idgovernorate;
  void searchEvent(String query) {
    filterEvent(query: query);
  }

  void filterEvent({String query = ""}) {
    if (query.isEmpty) {
      // إذا ما في بحث، رجع القائمة الأصلية
      listEventfilter = List.from(listEvent);
    } else {
      listEventfilter =
          listEvent.where((event) {
            bool queryMatches =
                (event.title?.toLowerCase().contains(query.toLowerCase()) ??
                    false);

            return queryMatches;
          }).toList();
    }
    notifyListeners();
  }

  Future<Either<Failure, bool>> DistrictEvents(BuildContext context) async {
    final client = Provider.of<NetworkClient>(context, listen: false);
    listEvent.clear();
    isLoadinggetEvent = true;
    notifyListeners();
    try {
      final response = await client.request(
        path: AppApi.DistrictEvents,
        withtoken: true,
        requestType: RequestType.GET,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        var json = await jsonDecode(response.body);

        for (var event in json) {
          listEvent.add(Event.fromJson(event));
        }
        listEventfilter = listEvent;
        isLoadinggetEvent = false;
        notifyListeners();
        return Right(true);
      } else if (response.statusCode == 404) {
        isLoadinggetEvent = false;
        notifyListeners();
        return Left(ResultFailure(''));
      } else {
        isLoadinggetEvent = false;
        notifyListeners();
        return Left(GlobalFailure());
      }
    } catch (e) {
      isLoadinggetEvent = false;
      notifyListeners();
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  Future<Either<Failure, bool>> RegisterOnEvent(
    BuildContext context,
    int id,
  ) async {
    final client = Provider.of<NetworkClient>(context, listen: false);

    try {
      final response = await client.request(
        path: AppApi.RegisterOnEvent(id),
        withtoken: true,

        requestType: RequestType.POST,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        CustomRoute.RoutePop(context);
        CustomDialog.DialogSuccess(context, title: "${data['message']}");
        DistrictEvents(context);
        return Right(true);
      } else if (response.statusCode == 400) {
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

  DialogConfirmRegisteration(BuildContext context, Event event) {
    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("Confirm registration process"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                content: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          """Are you sure you want to register for this event?

You can withdraw before the event starts from the Event Management page.""",
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
                        Either<Failure, bool> result = await RegisterOnEvent(
                          context,
                          event.id!,
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
                        color: AppColors.active,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Confirm", style: TextStyles.button),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      CustomRoute.RoutePop(context);
                      // cleardata();
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

  TextEditingController item_namecontroller = TextEditingController();
  TextEditingController quantitycontroller = TextEditingController();
  TextEditingController notescontroller = TextEditingController();

  Future<Either<Failure, bool>> AddPledge(BuildContext context, int id) async {
    final client = Provider.of<NetworkClient>(context, listen: false);

    try {
      final response = await client.request(
        path: AppApi.AddPledge,
        withtoken: true,

        requestType: RequestType.POST,
        body: jsonEncode({
          "event_id": id,
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

  DialogAddOrUpdatePledges(BuildContext context, int? id_event) async {
    final formkey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("Add New Pledge"),
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
                          Text("Notes", style: TextStyles.title),
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

                          result = await AddPledge(context, id_event!);

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
                        child: Text("Add", style: TextStyles.button),
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
}
