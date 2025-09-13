import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Constant/text_styles.dart';
<<<<<<< HEAD
import 'package:impactlyflutter/Controller/CategoryController.dart';
import 'package:impactlyflutter/Controller/GovernorateController%20copy.dart';
import 'package:impactlyflutter/Model/Category.dart';
=======
import 'package:impactlyflutter/Controller/GovernorateController.dart';
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
import 'package:impactlyflutter/Model/Districts.dart';
import 'package:impactlyflutter/Model/Event.dart';
import 'package:impactlyflutter/Model/Governorate.dart';
import 'package:impactlyflutter/Services/CustomDialog.dart';
import 'package:impactlyflutter/Services/Failure.dart';
import 'package:impactlyflutter/Services/Routes.dart';
import 'package:impactlyflutter/Widgets/Button/ButtonCustom.dart';
import 'package:impactlyflutter/Widgets/Dropdown/DropdownCustom.dart';
import 'package:impactlyflutter/Widgets/TextInput/TextInputCustom.dart';
<<<<<<< HEAD
import 'package:impactlyflutter/l10n/app_localizations.dart';
=======
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:impactlyflutter/Constant/url.dart';
import 'package:impactlyflutter/Services/NetworkClient.dart';

class MyEventController with ChangeNotifier {
  bool isLoadinggetEvent = false;
  List<Event> listEvent = [];
  List<Event> listEventfilter = [];

  TextEditingController searchcontroller = TextEditingController();
  int? idEvent;
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
                    false) ||
                (event.description?.toLowerCase().contains(
                      query.toLowerCase(),
                    ) ??
                    false) ||
                (event.location?.toLowerCase().contains(query.toLowerCase()) ??
                    false) ||
                (event.category?.toLowerCase().contains(query.toLowerCase()) ??
                    false) ||
                (event.maxVolunteers?.toString().toLowerCase().contains(
                      query.toLowerCase(),
                    ) ??
                    false) ||
                (event.startDate?.toLowerCase().contains(query.toLowerCase()) ??
                    false) ||
                (event.endDate?.toLowerCase().contains(query.toLowerCase()) ??
                    false);

            return queryMatches;
          }).toList();
    }
    notifyListeners();
  }

  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController eventdatefrom = TextEditingController();
  TextEditingController eventdateto = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  TextEditingController categorycontroller = TextEditingController();
  TextEditingController maxvolunteerscontroller = TextEditingController();
  Governorate? governorate;
  District? districts;
<<<<<<< HEAD
  Category? category;
=======
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
  void SelectEventDateFrom(BuildContext context, Function setstate) {
    showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    ).then((selectedDate) {
      if (selectedDate != null) {
        showTimePicker(context: context, initialTime: TimeOfDay.now()).then((
          selectedTime,
        ) {
          if (selectedTime != null) {
            final DateTime combinedDateTime = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              selectedTime.hour,
              selectedTime.minute,
            );

            final String formattedDateTime =
                combinedDateTime.toLocal().toIso8601String();
            setstate(() {
              eventdatefrom.text =
                  DateFormat('yyyy-MM-dd HH:mm')
                      .format(DateTime.parse(formattedDateTime).toLocal())
                      .toString();
            });
          }
        });
      }
    });
  }

  void SelectEventDateTo(BuildContext context, Function setstate) {
    showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    ).then((selectedDate) {
      if (selectedDate != null) {
        showTimePicker(context: context, initialTime: TimeOfDay.now()).then((
          selectedTime,
        ) {
          if (selectedTime != null) {
            final DateTime combinedDateTime = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              selectedTime.hour,
              selectedTime.minute,
            );

            final String formattedDateTime =
                combinedDateTime.toLocal().toIso8601String();
            setstate(() {
              eventdateto.text =
                  DateFormat('yyyy-MM-dd HH:mm')
                      .format(DateTime.parse(formattedDateTime).toLocal())
                      .toString();
            });
          }
        });
      }
    });
  }

  Future<Either<Failure, bool>> GetMyEvent(BuildContext context) async {
    final client = Provider.of<NetworkClient>(context, listen: false);
    listEvent.clear();
    isLoadinggetEvent = true;
    notifyListeners();
    try {
      final response = await client.request(
        path: AppApi.GetMyEvent,
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

  Future<Either<Failure, bool>> AddEvent(BuildContext context) async {
    final client = Provider.of<NetworkClient>(context, listen: false);

    try {
      final response = await client.request(
        path: AppApi.AddEvent,
        withtoken: true,

        requestType: RequestType.POST,
        body: jsonEncode({
          "title": titlecontroller.text,
          "description": descriptioncontroller.text,
          "start_date": eventdatefrom.text,
          "end_date": eventdateto.text,
          "location": locationcontroller.text,
<<<<<<< HEAD
          "category_id": category!.id,
=======
          "category": categorycontroller.text,
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
          "max_volunteers": maxvolunteerscontroller.text,
          "district_id": districts?.id.toString(),
        }),
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        CustomRoute.RoutePop(context);
        cleardata();
        CustomDialog.DialogSuccess(context, title: "${data['message']}");
        GetMyEvent(context);
        return Right(true);
<<<<<<< HEAD
      } else if (response.statusCode == 422) {
        CustomDialog.DialogError(context, title: "${data['message']}");
        return Right(true);
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

  cleardata() {
    titlecontroller.clear();
    descriptioncontroller.clear();
    eventdatefrom.clear();
    eventdateto.clear();
    locationcontroller.clear();
    categorycontroller.clear();
    maxvolunteerscontroller.clear();
    governorate = null;
    districts = null;
<<<<<<< HEAD
    category = null;
=======
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
  }

  filldata(Event event, BuildContext context) async {
    titlecontroller.text = event.title!;
    descriptioncontroller.text = event.description!;
    eventdatefrom.text =
        DateFormat(
          'yyyy-MM-dd HH:mm',
        ).format(DateTime.parse(event.startDate!)).toString();

    eventdateto.text =
        DateFormat(
          'yyyy-MM-dd HH:mm',
        ).format(DateTime.parse(event.endDate!)).toString();

    locationcontroller.text = event.location!;
    categorycontroller.text = event.category!;
    maxvolunteerscontroller.text = event.maxVolunteers.toString();

    final controller = Provider.of<GovernorateController>(
      context,
      listen: false,
    );

    for (var gov in controller.governorates) {
      log(controller.governorates.length.toString());
      districts =
          gov.districts!.where((d) => d.id == event.districtId).firstOrNull;
      if (districts != null) {
        governorate = gov;
        break;
      }
    }
<<<<<<< HEAD

    final catcontroller = Provider.of<CategoryController>(
      context,
      listen: false,
    );
    category =
        catcontroller.categories
            .where(
              (c) => c.nameAr == event.category || c.nameEn == event.category,
            )
            .firstOrNull;
  }

  SelectGovernorate(value, Function(void Function()) setState) {
    governorate = value;
    districts = null;
    setState(() {});
=======
  }

  SelectGovernorate(value) {
    governorate = value;
    districts = null;
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
    notifyListeners();
  }

  SelectDistricts(value) {
    districts = value;
    notifyListeners();
  }

<<<<<<< HEAD
  SelectCategory(value) {
    category = value;
    notifyListeners();
  }

  DialogAddOrUpdateEvent(BuildContext context, {Event? event}) async {
    await context.read<GovernorateController>().getGovernorates(context);
    await context.read<CategoryController>().getCategories(context);
=======
  DialogAddOrUpdateEvent(BuildContext context, {Event? event}) async {
    await context.read<GovernorateController>().getGovernorates(context);
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
    final formkey = GlobalKey<FormState>();
    if (event != null) {
      filldata(event, context);
    }
    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
<<<<<<< HEAD
                title: Text(
                  event != null
                      ? AppLocalizations.of(context)!.update_event
                      : AppLocalizations.of(context)!.add_new_event,
                ),
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
                            Text(
                              AppLocalizations.of(context)!.title,
                              style: TextStyles.title,
                            ),
                            Gap(5),
                            TextInputCustom(
                              controller: titlecontroller,
                              hint: AppLocalizations.of(context)!.title,
                              icon: Icon(Icons.title),
                            ),
                            Gap(10),
                            Text(
                              AppLocalizations.of(context)!.description,
                              style: TextStyles.title,
                            ),
                            Gap(5),
                            TextInputCustom(
                              controller: descriptioncontroller,
                              hint: AppLocalizations.of(context)!.description,
                              icon: Icon(Icons.title),
                            ),
                            Gap(10),
                            Text(
                              AppLocalizations.of(context)!.governorates,
                              style: TextStyles.title,
                            ),
                            Gap(5),
                            DropdownCustom<Governorate>(
                              isrequierd: true,
                              hint: AppLocalizations.of(context)!.governorates,
                              value: governorate,
                              items:
                                  context
                                      .watch<GovernorateController>()
                                      .governorates
=======
                title: Text("${event != null ? "Update" : "Add New"} Event"),
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
                          Text("Title", style: TextStyles.title),
                          Gap(5),
                          TextInputCustom(
                            controller: titlecontroller,
                            hint: "Title",
                            icon: Icon(Icons.title),
                          ),
                          Gap(10),
                          Text("Description", style: TextStyles.title),
                          Gap(5),
                          TextInputCustom(
                            controller: descriptioncontroller,
                            hint: "Description",
                            icon: Icon(Icons.title),
                          ),
                          Gap(10),
                          Text("Governorates", style: TextStyles.title),
                          Gap(5),
                          DropdownCustom<Governorate>(
                            isrequierd: true,
                            hint: "Governorates",
                            value: governorate,
                            items:
                                context
                                    .watch<GovernorateController>()
                                    .governorates
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e.name!),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (p0) {
                              setState(() {
                                SelectGovernorate(p0);
                              });
                            },
                          ),
                          if (governorate != null) Gap(10),
                          if (governorate != null)
                            Text("Districts", style: TextStyles.title),
                          if (governorate != null) Gap(5),
                          if (governorate != null)
                            DropdownCustom<District>(
                              isrequierd: true,
                              hint: "Districts",
                              value: districts,
                              items:
                                  governorate!.districts!
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e.name!),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (p0) {
<<<<<<< HEAD
                                SelectGovernorate(p0, setState);
                                setState(() {});
                              },
                            ),
                            if (governorate != null) Gap(10),
                            if (governorate != null)
                              Text(
                                AppLocalizations.of(context)!.districts,
                                style: TextStyles.title,
                              ),
                            if (governorate != null) Gap(5),
                            if (governorate != null)
                              DropdownCustom<District>(
                                isrequierd: true,
                                hint: AppLocalizations.of(context)!.districts,
                                value:
                                    districts != null &&
                                            governorate!.districts!.any(
                                              (d) => d.id == districts!.id,
                                            )
                                        ? districts
                                        : null,
                                items:
                                    governorate!.districts!
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e.name!),
                                          ),
                                        )
                                        .toList(),
                                onChanged: (p0) {
                                  SelectDistricts(p0);
                                  setState(() {});
                                },
                              ),
                            Gap(10),
                            Text(
                              AppLocalizations.of(context)!.start_event_date,
                              style: TextStyles.title,
                            ),
                            Gap(5),
                            ButtonCustom(
                              onTap:
                                  () => SelectEventDateFrom(context, setState),
                              title:
                                  eventdatefrom.text == ''
                                      ? AppLocalizations.of(context)!.pick
                                      : eventdatefrom.text,
                            ),
                            Gap(10),
                            Text(
                              AppLocalizations.of(context)!.end_event_date,
                              style: TextStyles.title,
                            ),
                            Gap(5),
                            ButtonCustom(
                              onTap: () => SelectEventDateTo(context, setState),
                              title:
                                  eventdateto.text == ''
                                      ? AppLocalizations.of(context)!.pick
                                      : eventdateto.text,
                            ),
                            Gap(10),
                            Text(
                              AppLocalizations.of(context)!.location,
                              style: TextStyles.title,
                            ),
                            Gap(5),
                            TextInputCustom(
                              controller: locationcontroller,
                              hint: AppLocalizations.of(context)!.location,
                              icon: Icon(Icons.title),
                            ),
                            Gap(10),
                            Text(
                              AppLocalizations.of(context)!.category,
                              style: TextStyles.title,
                            ),
                            Gap(5),
                            DropdownCustom<Category>(
                              isrequierd: true,
                              hint: AppLocalizations.of(context)!.category,
                              value: category,
                              items:
                                  context
                                      .watch<CategoryController>()
                                      .categories
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e.name!),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (p0) {
                                SelectCategory(p0);
                              },
                            ),
                            Gap(10),
                            Text(
                              AppLocalizations.of(context)!.max_volunteers,
                              style: TextStyles.title,
                            ),
                            Gap(5),
                            TextInputCustom(
                              controller: maxvolunteerscontroller,
                              hint:
                                  AppLocalizations.of(context)!.max_volunteers,
                              icon: Icon(Icons.title),
                            ),
                          ],
                        ),
=======
                                SelectDistricts(p0);
                              },
                            ),
                          Gap(10),
                          Text("Start Event Date", style: TextStyles.title),
                          Gap(5),
                          ButtonCustom(
                            onTap: () => SelectEventDateFrom(context, setState),

                            title:
                                eventdatefrom.text == ''
                                    ? "Pick"
                                    : eventdatefrom.text,
                          ),
                          Gap(10),
                          Text("End Event Date", style: TextStyles.title),
                          Gap(5),
                          ButtonCustom(
                            onTap: () => SelectEventDateTo(context, setState),

                            title:
                                eventdateto.text == ''
                                    ? "Pick"
                                    : eventdateto.text,
                          ),
                          Gap(10),
                          Text("Location", style: TextStyles.title),
                          Gap(5),
                          TextInputCustom(
                            controller: locationcontroller,
                            hint: "Location",
                            icon: Icon(Icons.title),
                          ),
                          Gap(10),
                          Text("Category", style: TextStyles.title),
                          Gap(5),
                          TextInputCustom(
                            controller: categorycontroller,
                            hint: "Category",
                            icon: Icon(Icons.title),
                          ),
                          Gap(10),
                          Text("Max Volunteers", style: TextStyles.title),
                          Gap(5),
                          TextInputCustom(
                            controller: maxvolunteerscontroller,
                            hint: "Max Volunteers",
                            icon: Icon(Icons.title),
                          ),
                        ],
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
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
                          if (event != null) {
                            result = await UpdateEvent(context, event.id!);
                          } else {
                            result = await AddEvent(context);
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
<<<<<<< HEAD
                          event != null
                              ? AppLocalizations.of(context)!.update
                              : AppLocalizations.of(context)!.add,
=======
                          event != null ? "Update" : "Add",
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
                          style: TextStyles.button,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      cleardata();
<<<<<<< HEAD
=======

>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
                      CustomRoute.RoutePop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
<<<<<<< HEAD
                        AppLocalizations.of(context)!.close,
=======
                        "Close",
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
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

  Future<Either<Failure, bool>> UpdateEvent(
    BuildContext context,
    int id,
  ) async {
    final client = Provider.of<NetworkClient>(context, listen: false);

    try {
      final response = await client.request(
        path: AppApi.UpdateEvent(id),
        withtoken: true,
        requestType: RequestType.PUT,
        body: jsonEncode({
          "title": titlecontroller.text,
          "description": descriptioncontroller.text,
          "start_date": eventdatefrom.text,
          "end_date": eventdateto.text,
          "location": locationcontroller.text,
          "category": categorycontroller.text,
          "max_volunteers": maxvolunteerscontroller.text,
          "district_id": districts?.id.toString(),
        }),
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        CustomRoute.RoutePop(context);
        cleardata();
        CustomDialog.DialogSuccess(context, title: "${data['message']}");
        GetMyEvent(context);
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

  Future<Either<Failure, bool>> DeleteEvent(
    BuildContext context,
    int id,
  ) async {
    final client = Provider.of<NetworkClient>(context, listen: false);

    try {
      final response = await client.request(
        path: AppApi.DeleteEvent(id),
        withtoken: true,

        requestType: RequestType.DELETE,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        CustomRoute.RoutePop(context);
        CustomDialog.DialogSuccess(context, title: "${data['message']}");
        GetMyEvent(context);
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

  DialogDeleteEvent(BuildContext context, Event event) {
<<<<<<< HEAD
    final loc = AppLocalizations.of(context)!;
=======
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
<<<<<<< HEAD
                title: Text(loc.delete_event),
=======
                title: Text("Delete Event"),
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                content: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
<<<<<<< HEAD
                    child: Text(
                      loc.delete_event_confirmation,
                      style: TextStyles.paraghraph,
=======
                    child: Column(
                      children: [
                        Text(
                          "Are you sure you want to delete the Event and its associated data?",
                          style: TextStyles.paraghraph,
                        ),
                      ],
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
                    ),
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () async {
                      EasyLoading.show();
                      try {
                        Either<Failure, bool> result = await DeleteEvent(
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
                        color: AppColors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
<<<<<<< HEAD
                        child: Text(loc.delete, style: TextStyles.button),
=======
                        child: Text("Delete", style: TextStyles.button),
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
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
<<<<<<< HEAD
                        loc.close,
=======
                        "Close",
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
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
