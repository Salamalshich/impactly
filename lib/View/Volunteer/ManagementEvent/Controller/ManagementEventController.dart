import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Constant/text_styles.dart';
import 'package:impactlyflutter/Model/VolunteerRegisteration.dart';
import 'package:impactlyflutter/Services/CustomDialog.dart';
import 'package:impactlyflutter/Services/Failure.dart';
import 'package:impactlyflutter/Services/Routes.dart';
import 'package:impactlyflutter/Widgets/TextInput/TextInputCustom.dart';
<<<<<<< HEAD
import 'package:impactlyflutter/l10n/app_localizations.dart';
=======
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:impactlyflutter/Constant/url.dart';
import 'package:impactlyflutter/Services/NetworkClient.dart';

class ManagementEventController with ChangeNotifier {
  bool isLoadinggetEvent = false;
  List<VolunteerRegisteration> listVolunteerRegisteration = [];
  List<VolunteerRegisteration> listVolunteerRegisterationfilter = [];
  TextEditingController searchcontroller = TextEditingController();
  int? idEvent;
  void searchEvent(String query) {
    filterEvent(query: query);
  }

  void filterEvent({String query = ""}) {
    if (query.isEmpty) {
      // إذا ما في بحث، رجع القائمة الأصلية
      listVolunteerRegisterationfilter = List.from(listVolunteerRegisteration);
    } else {
      listVolunteerRegisterationfilter =
          listVolunteerRegisteration.where((volunteerRegisteration) {
            bool queryMatches =
                (volunteerRegisteration.event!.title?.toLowerCase().contains(
                      query.toLowerCase(),
                    ) ??
                    false) ||
                (volunteerRegisteration.event!.description
                        ?.toLowerCase()
                        .contains(query.toLowerCase()) ??
                    false) ||
                (volunteerRegisteration.event!.location?.toLowerCase().contains(
                      query.toLowerCase(),
                    ) ??
                    false) ||
                (volunteerRegisteration.event!.category?.toLowerCase().contains(
                      query.toLowerCase(),
                    ) ??
                    false) ||
                (volunteerRegisteration.event!.maxVolunteers
                        ?.toString()
                        .toLowerCase()
                        .contains(query.toLowerCase()) ??
                    false) ||
                (volunteerRegisteration.event!.startDate
                        ?.toLowerCase()
                        .contains(query.toLowerCase()) ??
                    false) ||
                (volunteerRegisteration.event!.endDate?.toLowerCase().contains(
                      query.toLowerCase(),
                    ) ??
                    false);

            return queryMatches;
          }).toList();
    }
    notifyListeners();
  }

  Future<Either<Failure, bool>> MyRegisteredEvents(BuildContext context) async {
    final client = Provider.of<NetworkClient>(context, listen: false);
    listVolunteerRegisteration.clear();
    isLoadinggetEvent = true;
    notifyListeners();
    try {
      final response = await client.request(
        path: AppApi.MyRegisteredEvents,
        withtoken: true,
<<<<<<< HEAD
=======
        pageination: false,
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
        requestType: RequestType.GET,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        var json = await jsonDecode(response.body);

        for (var event in json) {
          listVolunteerRegisteration.add(
            VolunteerRegisteration.fromJson(event),
          );
        }
        listVolunteerRegisterationfilter = listVolunteerRegisteration;
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

  Future<Either<Failure, bool>> WithdrawFromEvent(
    BuildContext context,
    int id,
  ) async {
    final client = Provider.of<NetworkClient>(context, listen: false);

    try {
      final response = await client.request(
        path: AppApi.WithdrawFromEvent(id),
        withtoken: true,

        requestType: RequestType.DELETE,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        CustomRoute.RoutePop(context);
        CustomDialog.DialogSuccess(context, title: "${data['message']}");
        MyRegisteredEvents(context);
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
<<<<<<< HEAD
DialogWithdrawFromEvent(BuildContext context, int id) {
  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.withdraw_from_event),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.withdraw_from_event_message,
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
                  Either<Failure, bool> result = await WithdrawFromEvent(context, id);
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
                  child: Text(AppLocalizations.of(context)!.withdraw, style: TextStyles.button),
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
                  AppLocalizations.of(context)!.close,
                  style: TextStyles.pramed.copyWith(color: AppColors.primary),
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}
=======

  DialogWithdrawFromEvent(BuildContext context, int id) {
    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("Withdraw from Event"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                content: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          "Are you sure you want to withdraw from this event? "
                          "Once withdrawn, you will not be able to register for this event again.",
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
                        Either<Failure, bool> result = await WithdrawFromEvent(
                          context,
                          id,
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
                        child: Text("Withdraw", style: TextStyles.button),
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
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836

  Future<Either<Failure, bool>> FeedbackEvent(
    BuildContext context,
    int id,
  ) async {
    final client = Provider.of<NetworkClient>(context, listen: false);

    try {
      final response = await client.request(
        path: AppApi.FeedbackEvent(id),
        withtoken: true,

        requestType: RequestType.PUT,
        body: jsonEncode({
          "feedback": feedbackcontroller.text,
          "rating": rate.toString(),
        }),
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        CustomRoute.RoutePop(context);
        CustomDialog.DialogSuccess(context, title: "${data['message']}");
        MyRegisteredEvents(context);
        return Right(true);
<<<<<<< HEAD
      } else if (response.statusCode == 403) {
        CustomDialog.DialogError(context, title: "${data['message']}");
        return Right(false);
=======
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
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

  TextEditingController feedbackcontroller = TextEditingController();
  int rate = 0;
  DialogFeedbackEvent(BuildContext context, int id) async {
<<<<<<< HEAD
  final formkey = GlobalKey<FormState>();
  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.feedback_event),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.feedback, style: TextStyles.title),
                      Gap(5),
                      TextInputCustom(
                        isrequierd: true,
                        controller: feedbackcontroller,
                        hint: AppLocalizations.of(context)!.feedback,
                        icon: Icon(Icons.access_time_outlined),
                      ),
                      Gap(10),
                      Text(AppLocalizations.of(context)!.rate, style: TextStyles.title),
                      Gap(5),
                      RatingBar.builder(
                        glow: false,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemBuilder: (context, index) => Icon(Icons.star, color: AppColors.primary),
                        maxRating: 5,
                        minRating: 1,
                        initialRating: 0,
                        tapOnlyMode: true,
                        onRatingUpdate: (value) => rate = value.round(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                if (rate == 0.0) {
                  CustomDialog.DialogError(
                    context,
                    title: AppLocalizations.of(context)!.rate_not_zero,
                  );
                } else if (formkey.currentState!.validate()) {
                  EasyLoading.show();
                  try {
                    Either<Failure, bool> result = await FeedbackEvent(context, id);
                    result.fold(
                      (l) => EasyLoading.showError(l.message),
                      (r) => EasyLoading.dismiss(),
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
                  child: Text(AppLocalizations.of(context)!.add, style: TextStyles.button),
                ),
              ),
            ),
            TextButton(
              onPressed: () => CustomRoute.RoutePop(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(AppLocalizations.of(context)!.close, style: TextStyles.pramed.copyWith(color: AppColors.primary)),
              ),
            ),
          ],
        );
      },
    ),
  );
}

  TextEditingController reasonreportcontroller = TextEditingController();

  Future<Either<Failure, bool>> AddReport(BuildContext context, int id) async {
    final client = Provider.of<NetworkClient>(context, listen: false);

    try {
      final response = await client.request(
        path: AppApi.AddReport,
        withtoken: true,

        requestType: RequestType.POST,
        body: jsonEncode({
          "reportable_type": "event",
          "reportable_id": id.toString(),
          "reason": reasonreportcontroller.text,
        }),
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        CustomRoute.RoutePop(context);
        CustomDialog.DialogSuccess(context, title: "${data['message']}");
        MyRegisteredEvents(context);
        return Right(true);
      } else if (response.statusCode == 403) {
        CustomDialog.DialogError(context, title: "${data['message']}");
        return Right(false);
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
DialogReportEvent(BuildContext context, int id) async {
  final formkey = GlobalKey<FormState>();
  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.report_event),
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
                    Text(AppLocalizations.of(context)!.reason, style: TextStyles.title),
                    Gap(5),
                    TextInputCustom(
                      isrequierd: true,
                      controller: reasonreportcontroller,
                      hint: AppLocalizations.of(context)!.reason,
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
                    Either<Failure, bool> result = await AddReport(context, id);
                    result.fold(
                      (l) => EasyLoading.showError(l.message),
                      (r) => EasyLoading.dismiss(),
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
                  child: Text(AppLocalizations.of(context)!.add, style: TextStyles.button),
                ),
              ),
            ),
            TextButton(
              onPressed: () => CustomRoute.RoutePop(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(AppLocalizations.of(context)!.close, style: TextStyles.pramed.copyWith(color: AppColors.primary)),
              ),
            ),
          ],
        );
      },
    ),
  );
}

  Future<Either<Failure, bool>> AddLateReport(
    BuildContext context,
    int id,
  ) async {
    final client = Provider.of<NetworkClient>(context, listen: false);

    try {
      final response = await client.request(
        path: AppApi.LateReport(id),
        withtoken: true,

        requestType: RequestType.POST,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        CustomRoute.RoutePop(context);
        CustomDialog.DialogSuccess(context, title: "${data['message']}");
        MyRegisteredEvents(context);
        return Right(true);
      } else if (response.statusCode == 422) {
        CustomDialog.DialogError(context, title: "${data['message']}");
        return Right(false);
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

  DialogLateReportEvent(BuildContext context, int id) async {
  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.late_report),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.late_report_message),
                ],
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                EasyLoading.show();
                try {
                  Either<Failure, bool> result = await AddLateReport(context, id);
                  result.fold(
                    (l) => EasyLoading.showError(l.message),
                    (r) => EasyLoading.dismiss(),
                  );
                } catch (e) {
                  EasyLoading.dismiss();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(AppLocalizations.of(context)!.ok, style: TextStyles.button),
                ),
              ),
            ),
            TextButton(
              onPressed: () => CustomRoute.RoutePop(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(AppLocalizations.of(context)!.close, style: TextStyles.pramed.copyWith(color: AppColors.primary)),
              ),
            ),
          ],
        );
      },
    ),
  );
}

=======
    final formkey = GlobalKey<FormState>();
    // filldata(volunteerParticipation);
    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("Feedback Event"),
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
                          Text("Feedback", style: TextStyles.title),
                          Gap(5),
                          TextInputCustom(
                            controller: feedbackcontroller,
                            hint: "Feedback",
                            icon: Icon(Icons.access_time_outlined),
                          ),
                          Gap(10),

                          Text("Rate", style: TextStyles.title),
                          Gap(5),
                          RatingBar.builder(
                            glow: false,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Icon(Icons.star, color: AppColors.primary);
                            },
                            maxRating: 5,
                            minRating: 1,
                            initialRating: 3,

                            tapOnlyMode: true,
                            onRatingUpdate: (value) {
                              rate = value.round();
                              log(rate.toString());
                            },
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
                          Either<Failure, bool> result = await FeedbackEvent(
                            context,
                            id,
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
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
}
