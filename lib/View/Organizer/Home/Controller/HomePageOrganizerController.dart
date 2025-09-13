import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Constant/text_styles.dart';
import 'package:impactlyflutter/Constant/url.dart';
import 'package:impactlyflutter/Controller/CategoryController.dart';
import 'package:impactlyflutter/Controller/GovernorateController%20copy.dart';
import 'package:impactlyflutter/Model/Category.dart' show Category;
import 'package:impactlyflutter/Model/Districts.dart';
import 'package:impactlyflutter/Model/Event.dart';
import 'package:impactlyflutter/Model/Governorate.dart';
import 'package:impactlyflutter/Model/Pledges.dart';
import 'package:impactlyflutter/Services/CustomDialog.dart';
import 'package:impactlyflutter/Services/Failure.dart';
import 'package:impactlyflutter/Services/NetworkClient.dart';
import 'package:impactlyflutter/Services/Routes.dart';
import 'package:impactlyflutter/Widgets/Button/ButtonCustom.dart';
import 'package:impactlyflutter/Widgets/Dropdown/DropdownCustom.dart';
import 'package:impactlyflutter/Widgets/TextInput/TextInputCustom.dart';
import 'package:impactlyflutter/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomePageOrganizerController with ChangeNotifier {
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

  TextEditingController startDateFilter = TextEditingController();
  TextEditingController endDateFilter = TextEditingController();
  TextEditingController maxVolunteersFilter = TextEditingController();

  int? selectedGovernorateId;
  int? selectedDistrictId;
  int? selectedCategoryId;

  List<Governorate> governorates = [];
  List<Category> categories = [];

  List<District> filteredDistricts = [];

  // دوال لاختيار القيم
  void setGovernorate(int? id) {
    selectedGovernorateId = id;
    if (selectedGovernorateId == null) {
    } else {
      final gov = governorates.firstWhere(
        (g) => g.id == selectedGovernorateId,
        orElse: () => Governorate(districts: []),
      );
      filteredDistricts = gov.districts!;
    }

    selectedDistrictId = null;
    notifyListeners();
  }

  void setDistrict(int? id) {
    selectedDistrictId = id;
    notifyListeners();
  }

  void setCategory(int? id) {
    selectedCategoryId = id;
    notifyListeners();
  }

  // اختيار التاريخ
  Future<void> pickDate(BuildContext context, bool isStart) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      final formatted = picked.toIso8601String().split("T").first;
      if (isStart) {
        startDateFilter.text = formatted;
      } else {
        endDateFilter.text = formatted;
      }
      notifyListeners();
    }
  }

  // تطبيق الفلاتر محلياً
  void applyFilters() {
    listEventfilter =
        listEvent.where((event) {
          bool matches = true;

          // فلتر التاريخ من
          if (startDateFilter.text.isNotEmpty) {
            final startFilter = DateTime.parse(startDateFilter.text);
            final eventStart = DateTime.parse(event.startDate!);
            if (eventStart.isBefore(startFilter)) matches = false;
          }

          // فلتر التاريخ إلى
          if (endDateFilter.text.isNotEmpty) {
            final endFilter = DateTime.parse(endDateFilter.text);
            final eventEnd = DateTime.parse(event.endDate!);
            if (eventEnd.isAfter(endFilter)) matches = false;
          }

          // فلتر المحافظة
          if (selectedGovernorateId != null &&
              event.governorateName != null &&
              governorates
                      .firstWhere(
                        (g) => g.id == selectedGovernorateId,
                        orElse: () => Governorate(districts: []),
                      )
                      .name !=
                  event.governorateName) {
            matches = false;
          }

          // فلتر الحي
          if (selectedDistrictId != null &&
              event.districtId != selectedDistrictId) {
            matches = false;
          }

          // فلتر التصنيف
          if (selectedCategoryId != null &&
              event.category !=
                  categories
                      .firstWhere((c) => c.id == selectedCategoryId)
                      .name) {
            matches = false;
          }

          // فلتر max متطوعين
          if (maxVolunteersFilter.text.isNotEmpty) {
            int maxFilter = int.tryParse(maxVolunteersFilter.text) ?? 0;
            if ((event.maxVolunteers ?? 0) > maxFilter) matches = false;
          }

          return matches;
        }).toList();

    notifyListeners();
  }

  // مسح الفلاتر
  void clearFilters() {
    startDateFilter.clear();
    endDateFilter.clear();
    maxVolunteersFilter.clear();
    selectedGovernorateId = null;
    selectedDistrictId = null;
    selectedCategoryId = null;
    governorates.clear();
    categories.clear();
    listEventfilter = List.from(listEvent);
    notifyListeners();
  }

  void showEventFilters(BuildContext context) async {
    final gove = await context.read<GovernorateController>().getGovernorates(
      context,
    );
    gove.fold((l) {}, (r) async {
      governorates = r;
    });

    final cat = await context.read<CategoryController>().getCategories(context);
    cat.fold((l) {}, (r) async {
      categories = r;
    });
showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  ),
  builder: (context) {
    return StatefulBuilder(
      builder: (context, setModalState) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.filter_event,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),

                ButtonCustom(
                  child: Wrap(
                    children: [
                      if (startDateFilter.text.isNotEmpty &&
                          endDateFilter.text.isNotEmpty) ...[
                        Text(
                          startDateFilter.text,
                          style: TextStyles.pramed.copyWith(
                            color: AppColors.basic,
                          ),
                        ),
                        Icon(Icons.arrow_forward, color: AppColors.basic),
                        Text(
                          endDateFilter.text,
                          style: TextStyles.pramed.copyWith(
                            color: AppColors.basic,
                          ),
                        ),
                      ],
                      if (startDateFilter.text.isEmpty &&
                          endDateFilter.text.isEmpty)
                        Text(AppLocalizations.of(context)!.pick_date_range,
                            style: TextStyles.button),
                    ],
                  ),
                  onTap: () async {
                    final picked = await showDateRangePicker(
                      barrierColor: AppColors.basic,
                      context: context,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                      initialDateRange:
                          startDateFilter.text.isNotEmpty &&
                                  endDateFilter.text.isNotEmpty
                              ? DateTimeRange(
                                  start: DateTime.parse(startDateFilter.text),
                                  end: DateTime.parse(endDateFilter.text),
                                )
                              : null,
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            dialogBackgroundColor: Colors.white,
                            colorScheme: ColorScheme.light(
                              primary: AppColors.primary,
                              onPrimary: Colors.white,
                              onSurface: Colors.black,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (picked != null) {
                      setModalState(() {
                        startDateFilter.text =
                            picked.start.toIso8601String().split("T").first;
                        endDateFilter.text =
                            picked.end.toIso8601String().split("T").first;
                      });
                    }
                  },
                ),

                const SizedBox(height: 16),

                DropdownCustom<int>(
                  value: selectedGovernorateId,
                  hint: AppLocalizations.of(context)!.governorate,
                  items: governorates
                      .map(
                        (gov) => DropdownMenuItem<int>(
                          value: gov.id,
                          child: Text(gov.name ?? ""),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    setModalState(() {
                      setGovernorate(val);
                    });
                  },
                ),
                const SizedBox(height: 12),

                if (selectedGovernorateId != null) ...[
                  DropdownCustom<int>(
                    value: selectedDistrictId,
                    hint: AppLocalizations.of(context)!.district,
                    items: filteredDistricts
                        .map(
                          (dist) => DropdownMenuItem<int>(
                            value: dist.id,
                            child: Text(dist.name ?? ""),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      setModalState(() {
                        setDistrict(val);
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                ],

                DropdownCustom<int>(
                  value: selectedCategoryId,
                  hint: AppLocalizations.of(context)!.category,
                  items: categories
                      .map(
                        (cat) => DropdownMenuItem<int>(
                          value: cat.id,
                          child: Text(cat.name ?? ""),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    setModalState(() {
                      setCategory(val);
                    });
                  },
                ),
                const SizedBox(height: 12),

                TextInputCustom(
                  controller: maxVolunteersFilter,
                  type: TextInputType.number,
                  hint: AppLocalizations.of(context)!.max_volunteer,
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: ButtonCustom(
                        color: AppColors.primary,
                        onTap: () {
                          applyFilters();
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check, color: AppColors.basic),
                            Gap(5),
                            Text(AppLocalizations.of(context)!.apply,
                                style: TextStyles.button),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ButtonCustom(
                        bordersize: 1,
                        color: AppColors.basic,
                        bordercolor: AppColors.primary,
                        onTap: () {
                          clearFilters();
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check, color: AppColors.primary),
                            Gap(5),
                            Text(
                              AppLocalizations.of(context)!.clear,
                              style: TextStyles.button
                                  .copyWith(color: AppColors.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  },
);

  }

  Future<Either<Failure, bool>> AllEvents(BuildContext context) async {
    final client = Provider.of<NetworkClient>(context, listen: false);
    listEvent.clear();
    isLoadinggetEvent = true;
    notifyListeners();
    try {
      final response = await client.request(
        path: AppApi.AllEvents,
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
                  Either<Failure, bool> result = await AddReport(context, id);
                  result.fold(
                    (l) {
                      EasyLoading.showError(l.message);
                      EasyLoading.dismiss();
                    },
                    (r) {
                      EasyLoading.dismiss();
                    },
                  );
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
  TextEditingController item_namecontroller = TextEditingController();
  TextEditingController quantitycontroller = TextEditingController();
  TextEditingController notescontroller = TextEditingController();
  String donationType = "item"; // default
  int? requested_id; // default
  TextEditingController amountController =
      TextEditingController(); // للمبلغ المالي
DialogAddOrUpdatePledges(
  BuildContext context,
  int? id_event,
  List<Pledges> requestedpledges,
) async {
  final formkey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.add_new_pledge),
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
                      Text(AppLocalizations.of(context)!.select_pledge, style: TextStyles.title),
                      DropdownCustom<Pledges>(
                        hint: AppLocalizations.of(context)!.select,
                        items: requestedpledges.map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              "${e.amount ?? ''} ${e.itemName ?? ''} ${e.quantity ?? ''}",
                            ),
                          ),
                        ).toList(),
                        onChanged: (val) {
                          setState(() {
                            donationType = val!.donationType!;
                            requested_id = val.id;
                          });
                        },
                      ),
                      Gap(10),
                      if (donationType == "item") ...[
                        Text(AppLocalizations.of(context)!.item_name, style: TextStyles.title),
                        Gap(5),
                        TextInputCustom(
                          controller: item_namecontroller,
                          hint: AppLocalizations.of(context)!.item_name,
                          icon: Icon(Icons.title),
                        ),
                        Gap(10),
                        Text(AppLocalizations.of(context)!.quantity, style: TextStyles.title),
                        Gap(5),
                        TextInputCustom(
                          controller: quantitycontroller,
                          hint: AppLocalizations.of(context)!.quantity,
                          icon: Icon(Icons.numbers_outlined),
                        ),
                      ],
                      if (donationType == "money") ...[
                        Text(AppLocalizations.of(context)!.amount, style: TextStyles.title),
                        Gap(5),
                        TextInputCustom(
                          controller: amountController,
                          hint: AppLocalizations.of(context)!.amount,
                          icon: Icon(Icons.monetization_on),
                        ),
                      ],
                      Gap(10),
                      Text(AppLocalizations.of(context)!.notes, style: TextStyles.title),
                      Gap(5),
                      TextInputCustom(
                        controller: notescontroller,
                        hint: AppLocalizations.of(context)!.notes,
                        icon: Icon(Icons.notes_outlined),
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
                if (formkey.currentState!.validate()) {
                  EasyLoading.show();
                  Either<Failure, bool> result;

                  result = await AddPledge(
                    context,
                    id_event!,
                    donationType,
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
              onPressed: () {
                cleardata();
                CustomRoute.RoutePop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.close,
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
  // تعديل دالة AddPledge
  Future<Either<Failure, bool>> AddPledge(
    BuildContext context,
    int id,
    String donationType,
  ) async {
    final client = Provider.of<NetworkClient>(context, listen: false);

    try {
      Map<String, dynamic> body = {
        "event_id": id,
        "donation_type": donationType,
        "notes": notescontroller.text,
        "requested_id": requested_id,
      };

      if (donationType == "item") {
        body["item_name"] = item_namecontroller.text;
        body["quantity"] = int.tryParse(quantitycontroller.text) ?? 0;
      } else if (donationType == "money") {
        body["amount"] = double.tryParse(amountController.text) ?? 0;
      }

      final response = await client.request(
        path: AppApi.AddPledge,
        withtoken: true,
        requestType: RequestType.POST,
        body: jsonEncode(body),
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        CustomRoute.RoutePop(context);
        cleardata();
        CustomDialog.DialogSuccess(
          context,
          title: data['message'] ?? "Pledge added successfully",
        );
        return Right(true);
      }
      if (response.statusCode == 422) {
        CustomDialog.DialogError(context, title: data['message']);
        return Right(false);
      } else {
        return Left(GlobalFailure());
      }
    } catch (e) {
      log(e.toString());
      return Left(GlobalFailure());
    }
  }

  cleardata() {
    item_namecontroller.clear();
    quantitycontroller.clear();
    notescontroller.clear();
  }
}
