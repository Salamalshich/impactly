import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Constant/text_styles.dart';
import 'package:impactlyflutter/Services/Routes.dart';
import 'package:impactlyflutter/View/MyRequestedPledge/Controller/MyRequestedPledgeController.dart';
import 'package:impactlyflutter/Widgets/Button/ButtonCustom.dart';
import 'package:provider/provider.dart';
import 'package:impactlyflutter/l10n/app_localizations.dart';

class MyRequestedPledge extends StatelessWidget {
  const MyRequestedPledge({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyRequestedPledgeController>(
      builder:
          (context, controller, child) => Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add, color: AppColors.basic),
              onPressed: () {
                controller.DialogAddOrUpdatePledge(context);
              },
            ),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                AppLocalizations.of(context)!.pledge_event,
                style: TextStyles.header.copyWith(color: AppColors.black),
              ),
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                onPressed: () => CustomRoute.RoutePop(context),
                icon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
              ),
            ),
            body:
                controller.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : controller.pledges.isEmpty
                    ? Center(
                      child: Text(
                        AppLocalizations.of(context)!.no_data_available,
                      ),
                    )
                    : ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: controller.pledges.length,
                      itemBuilder: (context, index) {
                        final e = controller.pledges[index];

                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.grey50,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (e.donationType == 'money') ...[
                                        Text(
                                          "${AppLocalizations.of(context)!.amount}: \$${e.amount}",
                                          style: TextStyles.title,
                                        ),
                                        if (e.notes != null)
                                          Text(
                                            "${AppLocalizations.of(context)!.notes}: ${e.notes}",
                                            style: TextStyles.paraghraph,
                                          ),
                                      ] else ...[
                                        if (e.itemName != null)
                                          Text(
                                            "${AppLocalizations.of(context)!.item}: ${e.itemName}",
                                            style: TextStyles.title,
                                          ),
                                        if (e.quantity != null)
                                          Text(
                                            "${AppLocalizations.of(context)!.quantity}: ${e.quantity}",
                                            style: TextStyles.paraghraph,
                                          ),
                                        if (e.notes != null)
                                          Text(
                                            "${AppLocalizations.of(context)!.notes}: ${e.notes}",
                                            style: TextStyles.paraghraph,
                                          ),
                                      ],
                                      Gap(5),
                                      Wrap(
                                        alignment: WrapAlignment.start,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        spacing: 5,
                                        runSpacing: 5,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.gpp_good_outlined),
                                              Gap(5),
                                              Text(
                                                "${AppLocalizations.of(context)!.status}:",
                                              ),
                                              Gap(5),
                                              Expanded(
                                                child: Text(
                                                  e.status ??
                                                      AppLocalizations.of(
                                                        context,
                                                      )!.na,
                                                  style: TextStyles.paraghraph
                                                      .copyWith(
                                                        color:
                                                            AppColors.grey400,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ButtonCustom(
                                    fullWidth: true,
                                    onTap:
                                        () =>
                                            controller.DialogAddOrUpdatePledge(
                                              context,
                                              pledge: e,
                                            ),
                                    title: AppLocalizations.of(context)!.edit,
                                  ),
                                ),
                                Gap(5),
                                Expanded(
                                  child: ButtonCustom(
                                    color: AppColors.red,
                                    fullWidth: true,
                                    onTap:
                                        () => controller.DialogDeletePledge(
                                          context,
                                          e,
                                        ),
                                    title: AppLocalizations.of(context)!.delete,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
          ),
    );
  }
}
