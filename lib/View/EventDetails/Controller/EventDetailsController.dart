import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Constant/text_styles.dart';
import 'package:impactlyflutter/Model/EventDetails.dart';
import 'package:impactlyflutter/Model/Pledges.dart';
import 'package:impactlyflutter/Model/VolunteerParticipation.dart';
import 'package:impactlyflutter/Services/CustomDialog.dart';
import 'package:impactlyflutter/Services/Failure.dart';
import 'package:impactlyflutter/Services/Routes.dart';
import 'package:impactlyflutter/View/MyEvent/Controller/MyEventController.dart';
import 'package:impactlyflutter/Widgets/Dropdown/DropdownCustom.dart';
import 'package:impactlyflutter/Widgets/TextInput/TextInputCustom.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:impactlyflutter/Constant/url.dart';
import 'package:impactlyflutter/Services/NetworkClient.dart';

class EventDetailsController with ChangeNotifier {
  bool isLoadinggetEvent = false;
  EventDetails? eventDetails;
  MyEventController? myEventController;
  List<VolunteerParticipation>? listattendancesfilter;
  TextEditingController searchcontroller = TextEditingController();
  int? idEvent;
  BuildContext? context2;
  initcontroller(MyEventController value, BuildContext context2) {
    myEventController = value;
    this.context2 = context2;
  }

  void searchEvent(String query) {
    filterEvent(query: query);
  }

  void filterEvent({String query = ""}) {
    if (query.isEmpty) {
      // إذا ما في بحث، رجع القائمة الأصلية
      listattendancesfilter = List.from(eventDetails!.volunteerParticipations!);
    } else {
      listattendancesfilter =
          eventDetails!.volunteerParticipations!.where((attendances) {
            bool queryMatches =
                (attendances.checkIn.toString().toLowerCase().contains(
                  query.toLowerCase(),
                )) ||
                (attendances.checkOut.toString().toLowerCase().contains(
                  query.toLowerCase(),
                )) ||
                (attendances.hoursWorked.toString().toLowerCase().contains(
                  query.toLowerCase(),
                )) ||
                (attendances.user!.name!.toLowerCase().contains(
                  query.toLowerCase(),
                ));

            return queryMatches;
          }).toList();
    }
    notifyListeners();
  }

  Future<Either<Failure, bool>> GetEventDetails(
    BuildContext context,
    int id,
  ) async {
    final client = Provider.of<NetworkClient>(context, listen: false);
    isLoadinggetEvent = true;
    idEvent = id;
    notifyListeners();
    try {
      final response = await client.request(
        path: AppApi.EventDetails(id),
        withtoken: true,
        requestType: RequestType.GET,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        var json = await jsonDecode(response.body);
        eventDetails = EventDetails.fromJson(json);
        filterEvent();

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

  Future<Either<Failure, bool>> VerifyHours(
    BuildContext context,
    int id,
  ) async {
    final client = Provider.of<NetworkClient>(context, listen: false);

    try {
      final response = await client.request(
        path: AppApi.VerifyHours(id),
        withtoken: true,

        requestType: RequestType.POST,
        body: jsonEncode({"hours_worked": workedhourscontroller.text}),
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        CustomRoute.RoutePop(context);
        CustomDialog.DialogSuccess(context, title: "${data['message']}");
        GetEventDetails(context, idEvent!);
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

  filldata(VolunteerParticipation volunteerParticipation) async {
    workedhourscontroller.text = volunteerParticipation.hoursWorked!.toString();
  }

  TextEditingController workedhourscontroller = TextEditingController();
  DialogVerifedVolunteer(
    BuildContext context,
    VolunteerParticipation volunteerParticipation,
  ) async {
    final formkey = GlobalKey<FormState>();
    filldata(volunteerParticipation);
    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("Verifed Volunteer"),
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
                          Text("Worked Hours", style: TextStyles.title),
                          Gap(5),
                          TextInputCustom(
                            controller: workedhourscontroller,
                            hint: "Worked Hours",
                            icon: Icon(Icons.access_time_outlined),
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
                          Either<Failure, bool> result = await VerifyHours(
                            context,
                            volunteerParticipation.id!,
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

  Future<Either<Failure, bool>> VolunteerNoShow(
    BuildContext context,
    int id,
  ) async {
    final client = Provider.of<NetworkClient>(context, listen: false);

    try {
      final response = await client.request(
        path: AppApi.VolunteerNoShow(id),
        withtoken: true,
        requestType: RequestType.POST,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        CustomRoute.RoutePop(context);
        CustomDialog.DialogSuccess(context, title: "${data['message']}");
        GetEventDetails(context, idEvent!);
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

  DialogVolunteerNoShow(
    BuildContext context,
    VolunteerParticipation volunteerParticipation,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("Volunteer NoShow"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                content: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          "Are you sure you want to change your event volunteer status to no-show?",
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
                        Either<Failure, bool> result = await VolunteerNoShow(
                          context,
                          volunteerParticipation.id!,
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

  Future<Either<Failure, bool>> CompleteEvent(BuildContext context) async {
    final client = Provider.of<NetworkClient>(context, listen: false);

    try {
      final response = await client.request(
        path: AppApi.CompleteEvent(idEvent!),
        withtoken: true,

        requestType: RequestType.POST,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        CustomRoute.RoutePop(context);
        CustomDialog.DialogSuccess(context, title: "${data['message']}");
        GetEventDetails(context, idEvent!);
        myEventController!.GetMyEvent(context2!);

        return Right(true);
      } else if (response.statusCode == 403) {
        CustomDialog.DialogError(context, title: "${data['message']}");

        return Right(false);
      } else {
        return Left(GlobalFailure());
      }
    } catch (e) {
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  DialogCompleteEvent(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("Complete Event"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                content: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          "Are you sure you want to complete event?",
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
                        Either<Failure, bool> result = await CompleteEvent(
                          context,
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

  Future<Either<Failure, bool>> UpdateStatusPledges(
    BuildContext context,
    int id,
  ) async {
    final client = Provider.of<NetworkClient>(context, listen: false);

    try {
      final response = await client.request(
        path: AppApi.UpdateStatusPledges(id),
        withtoken: true,
        requestType: RequestType.POST,
        body: jsonEncode({"status": status}),
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        CustomRoute.RoutePop(context);
        CustomDialog.DialogSuccess(context, title: "${data['message']}");
        GetEventDetails(context, idEvent!);
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

  String? status;

  SelectStatus(value, Function setstatus) {
    setstatus(() {
      status = value;
    });
  }

  DialogUpdateStatusPledges(BuildContext context, Pledges pledge) {
    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("Update Status Pledge"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                content: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Select pledge status", style: TextStyles.title),
                        Gap(5),
                        DropdownCustom<String>(
                          items:
                              ['approved', 'rejected', 'delivered']
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (p0) {
                            SelectStatus(p0, setState);
                          },
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
                        Either<Failure, bool> result =
                            await UpdateStatusPledges(context, pledge.id!);
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
