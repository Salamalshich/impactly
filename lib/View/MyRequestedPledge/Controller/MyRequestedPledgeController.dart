import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Constant/text_styles.dart';
import 'package:impactlyflutter/Model/Pledges.dart';
import 'package:impactlyflutter/Services/CustomDialog.dart';
import 'package:impactlyflutter/Services/Failure.dart';
import 'package:impactlyflutter/Services/Routes.dart';
import 'package:impactlyflutter/Services/NetworkClient.dart';
import 'package:impactlyflutter/Constant/url.dart';
import 'package:impactlyflutter/Widgets/Dropdown/DropdownCustom.dart';
import 'package:impactlyflutter/Widgets/TextInput/TextInputCustom.dart';
import 'package:impactlyflutter/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class MyRequestedPledgeController with ChangeNotifier {
  bool isLoading = false;
  List<Pledges> pledges = [];

  // TextControllers
  TextEditingController itemNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  int? eventid;
  String donationType = "item"; // default

  // ================== API Calls ==================
  Future<Either<Failure, bool>> getEventRequests(
    BuildContext context,
    int eventId,
  ) async {
    final client = Provider.of<NetworkClient>(context, listen: false);
    eventid = eventId;
    pledges.clear();
    isLoading = true;
    notifyListeners();
    try {
      final response = await client.request(
        path: AppApi.GetEventRequests(eventId),
        withtoken: true,
        requestType: RequestType.GET,
      );
      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        for (var p in json) {
          pledges.add(Pledges.fromJson(p));
        }
        isLoading = false;
        notifyListeners();
        return Right(true);
      } else {
        isLoading = false;
        notifyListeners();
        return Left(GlobalFailure());
      }
    } catch (e) {
      log(e.toString());
      isLoading = false;
      notifyListeners();
      return Left(GlobalFailure());
    }
  }

  Future<Either<Failure, bool>> addRequestedPledge(BuildContext context) async {
    final client = Provider.of<NetworkClient>(context, listen: false);
    log(donationType);
    try {
      Map<String, dynamic> bodyData = {
        "event_id": eventid,
        "donation_type": donationType,
        "notes": notesController.text,
      };

      if (donationType == "item") {
        bodyData["item_name"] = itemNameController.text;
        bodyData["quantity"] = int.tryParse(quantityController.text) ?? 0;
      } else if (donationType == "money") {
        bodyData["amount"] = double.tryParse(amountController.text) ?? 0;
      }

      final response = await client.request(
        path: AppApi.AddRequestedPledge,
        withtoken: true,
        requestType: RequestType.POST,
        body: jsonEncode(bodyData),
      );

      log(response.statusCode.toString());
      log(response.body.toString());

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        CustomRoute.RoutePop(context);
        cleardata();
        CustomDialog.DialogSuccess(
          context,
          title: "Request added successfully",
        );
        getEventRequests(context, eventid!);
        return Right(true);
      } else {
        CustomDialog.DialogError(context, title: "${data['message']}");
        return Left(GlobalFailure());
      }
    } catch (e) {
      log(e.toString());
      return Left(GlobalFailure());
    }
  }

  Future<Either<Failure, bool>> updateRequestedPledge(
    BuildContext context,
    int pledgeId,
    int eventId,
  ) async {
    final client = Provider.of<NetworkClient>(context, listen: false);

    try {
      final response = await client.request(
        path: AppApi.UpdateRequestedPledge(pledgeId),
        withtoken: true,
        requestType: RequestType.PUT,
        body: jsonEncode({
          "item_name": donationType == "item" ? itemNameController.text : null,
          "quantity": donationType == "item" ? quantityController.text : null,
          "amount": donationType == "money" ? amountController.text : null,
          "notes": notesController.text,
        }),
      );

      log(response.statusCode.toString());
      log(response.body.toString());
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        CustomRoute.RoutePop(context);
        cleardata();
        CustomDialog.DialogSuccess(
          context,
          title: "Request updated successfully",
        );
        getEventRequests(context, eventId);
        return Right(true);
      } else {
        CustomDialog.DialogError(context, title: "${data['message']}");
        return Left(GlobalFailure());
      }
    } catch (e) {
      log(e.toString());
      return Left(GlobalFailure());
    }
  }

  Future<Either<Failure, bool>> deleteRequestedPledge(
    BuildContext context,
    int pledgeId,
    int eventId,
  ) async {
    final client = Provider.of<NetworkClient>(context, listen: false);

    try {
      final response = await client.request(
        path: AppApi.DeleteRequestedPledge(pledgeId),
        withtoken: true,
        requestType: RequestType.DELETE,
      );

      log(response.statusCode.toString());
      log(response.body.toString());
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        CustomRoute.RoutePop(context);
        CustomDialog.DialogSuccess(
          context,
          title: "Request deleted successfully",
        );
        getEventRequests(context, eventId);
        return Right(true);
      } else {
        CustomDialog.DialogError(context, title: "${data['message']}");
        return Left(GlobalFailure());
      }
    } catch (e) {
      log(e.toString());
      return Left(GlobalFailure());
    }
  }

  // ================== Dialogs ==================
  DialogAddOrUpdatePledge(
    BuildContext context, {
    int? eventId,
    Pledges? pledge,
  }) async {
    final formkey = GlobalKey<FormState>();

    if (pledge != null) {
      donationType = pledge.donationType ?? "item";
      itemNameController.text = pledge.itemName ?? "";
      quantityController.text = pledge.quantity?.toString() ?? "";
      amountController.text = pledge.amount?.toString() ?? "";
      notesController.text = pledge.notes ?? "";
    }

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text(
                  pledge != null
                      ? AppLocalizations.of(context)!.update_request
                      : AppLocalizations.of(context)!.add_request,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                content: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: SingleChildScrollView(
                    child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (pledge == null) ...[
                            Text(
                              AppLocalizations.of(context)!.donation_type,
                              style: TextStyles.title,
                            ),
                            Gap(5),
                            DropdownCustom<String>(
                              value: donationType,
                              items: [
                                DropdownMenuItem(
                                  value: "item",
                                  child: Text(
                                    AppLocalizations.of(context)!.material_item,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "money",
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.monetary_amount,
                                  ),
                                ),
                              ],
                              onChanged: (val) {
                                setState(() {
                                  donationType = val!;
                                  cleardata();
                                });
                              },
                            ),
                            Gap(10),
                          ],
                          if (donationType == "item") ...[
                            Text(
                              AppLocalizations.of(context)!.item_name,
                              style: TextStyles.title,
                            ),
                            Gap(5),
                            TextInputCustom(
                              controller: itemNameController,
                              hint: AppLocalizations.of(context)!.item_name,
                              icon: Icon(Icons.inventory),
                            ),
                            Gap(10),
                            Text(
                              AppLocalizations.of(context)!.quantity,
                              style: TextStyles.title,
                            ),
                            Gap(5),
                            TextInputCustom(
                              controller: quantityController,
                              hint: AppLocalizations.of(context)!.quantity,
                              icon: Icon(Icons.format_list_numbered),
                            ),
                          ],
                          if (donationType == "money") ...[
                            Text(
                              AppLocalizations.of(context)!.amount,
                              style: TextStyles.title,
                            ),
                            Gap(5),
                            TextInputCustom(
                              controller: amountController,
                              hint: AppLocalizations.of(context)!.amount,
                              icon: Icon(Icons.monetization_on),
                            ),
                          ],
                          Gap(10),
                          Text(
                            AppLocalizations.of(context)!.notes,
                            style: TextStyles.title,
                          ),
                          Gap(5),
                          TextInputCustom(
                            controller: notesController,
                            hint: AppLocalizations.of(context)!.notes,
                            icon: Icon(Icons.note),
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
                        Either<Failure, bool> result;
                        if (pledge != null) {
                          result = await updateRequestedPledge(
                            context,
                            pledge.id!,
                            pledge.eventId!,
                          );
                        } else {
                          result = await addRequestedPledge(context);
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
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        pledge != null
                            ? AppLocalizations.of(context)!.update
                            : AppLocalizations.of(context)!.add,
                        style: TextStyles.button,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      cleardata();
                      CustomRoute.RoutePop(context);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.close,
                      style: TextStyles.pramed.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
    );
  }

  DialogDeletePledge(BuildContext context, Pledges pledge) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.delete_request),
            content: Text(AppLocalizations.of(context)!.delete_confirmation),
            actions: [
              GestureDetector(
                onTap: () async {
                  EasyLoading.show();
                  final result = await deleteRequestedPledge(
                    context,
                    pledge.id!,
                    pledge.eventId!,
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
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    AppLocalizations.of(context)!.delete,
                    style: TextStyles.button,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => CustomRoute.RoutePop(context),
                child: Text(
                  AppLocalizations.of(context)!.close,
                  style: TextStyles.pramed.copyWith(color: AppColors.primary),
                ),
              ),
            ],
          ),
    );
  }

  // ================== Helpers ==================
  cleardata() {
    itemNameController.clear();
    quantityController.clear();
    amountController.clear();
    notesController.clear();
  }
}
