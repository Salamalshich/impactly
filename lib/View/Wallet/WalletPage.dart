import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Constant/text_styles.dart';
import 'package:impactlyflutter/Services/Routes.dart';
import 'package:impactlyflutter/View/Wallet/Controller/WalletController.dart';
import 'package:impactlyflutter/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WalletPage extends StatelessWidget {
  WalletPage();

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletController>(
      builder:
          (context, controller, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                AppLocalizations.of(context)!.wallet,
                style: TextStyles.header.copyWith(color: AppColors.black),
              ),
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                onPressed: () => CustomRoute.RoutePop(context),
                icon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
              ),
            ),
            body: ListView(
              padding: EdgeInsets.all(16),
              children: [
                Row(
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.wallet_balance}:",
                      style: TextStyles.header,
                    ),
                    Gap(10),
                    Text(
                      "${controller.wallet?.balance ?? '0.00'}",
                      style: TextStyles.title,
                    ),
                  ],
                ),
                Gap(10),
                Text(AppLocalizations.of(context)!.sent),
                controller.sentTransactions.isEmpty
                    ? Center(child: Text(AppLocalizations.of(context)!.no_data))
                    : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        dataRowColor: WidgetStateColor.resolveWith(
                          (states) => AppColors.active,
                        ),
                        dataTextStyle: TextStyles.paraghraph.copyWith(
                          color: AppColors.basic,
                        ),
                        headingTextStyle: TextStyles.paraghraph.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        border: TableBorder.all(
                          color: AppColors.grey100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        columns: [
                          DataColumn(
                            label: Text(AppLocalizations.of(context)!.amount),
                          ),
                          DataColumn(
                            label: Text(AppLocalizations.of(context)!.type),
                          ),
                          DataColumn(
                            label: Text(AppLocalizations.of(context)!.status),
                          ),
                          DataColumn(
                            label: Text(AppLocalizations.of(context)!.method),
                          ),
                          DataColumn(
                            label: Text(AppLocalizations.of(context)!.notes),
                          ),
                          DataColumn(
                            label: Text(AppLocalizations.of(context)!.date),
                          ),
                        ],
                        rows:
                            controller.sentTransactions
                                .map(
                                  (e) => DataRow(
                                    cells: [
                                      DataCell(Text(e.amount ?? "-")),
                                      DataCell(Text(e.type ?? "-")),
                                      DataCell(Text(e.status ?? "-")),
                                      DataCell(Text(e.method ?? "-")),
                                      DataCell(Text(e.notes ?? "-")),
                                      DataCell(
                                        Text(
                                          e.createdAt == null
                                              ? "-"
                                              : DateFormat(
                                                "yyyy-MM-dd HH:mm a",
                                              ).format(
                                                DateTime.parse(e.createdAt!),
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                Gap(10),
                Divider(),
                Gap(10),
                Text(AppLocalizations.of(context)!.received),
                controller.receivedTransactions.isEmpty
                    ? Center(child: Text(AppLocalizations.of(context)!.no_data))
                    : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        dataRowColor: WidgetStateColor.resolveWith(
                          (states) => AppColors.active,
                        ),
                        dataTextStyle: TextStyles.paraghraph.copyWith(
                          color: AppColors.basic,
                        ),
                        headingTextStyle: TextStyles.paraghraph.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        border: TableBorder.all(
                          color: AppColors.grey100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        columns: [
                          DataColumn(
                            label: Text(AppLocalizations.of(context)!.amount),
                          ),
                          DataColumn(
                            label: Text(AppLocalizations.of(context)!.type),
                          ),
                          DataColumn(
                            label: Text(AppLocalizations.of(context)!.status),
                          ),
                          DataColumn(
                            label: Text(AppLocalizations.of(context)!.method),
                          ),
                          DataColumn(
                            label: Text(AppLocalizations.of(context)!.notes),
                          ),
                          DataColumn(
                            label: Text(AppLocalizations.of(context)!.date),
                          ),
                        ],
                        rows:
                            controller.receivedTransactions
                                .map(
                                  (e) => DataRow(
                                    cells: [
                                      DataCell(Text(e.amount ?? "-")),
                                      DataCell(Text(e.type ?? "-")),
                                      DataCell(Text(e.status ?? "-")),
                                      DataCell(Text(e.method ?? "-")),
                                      DataCell(Text(e.notes ?? "-")),
                                      DataCell(
                                        Text(
                                          e.createdAt == null
                                              ? "-"
                                              : DateFormat(
                                                "yyyy-MM-dd HH:mm a",
                                              ).format(
                                                DateTime.parse(e.createdAt!),
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                      ),
                    ),
              ],
            ),
          ),
    );
  }
}
