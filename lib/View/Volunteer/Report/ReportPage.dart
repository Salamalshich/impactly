import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Constant/text_styles.dart';
import 'package:impactlyflutter/Services/Routes.dart';
import 'package:impactlyflutter/View/Volunteer/Report/Controller/ReportPageController.dart';
import 'package:impactlyflutter/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ReportPageController>(
      builder:
          (context, controller, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                AppLocalizations.of(context)!.reports,
                style: TextStyles.header.copyWith(color: AppColors.black),
              ),
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                onPressed: () => CustomRoute.RoutePop(context),
                icon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
              ),
            ),
            body: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.listReports.length,
              itemBuilder: (context, index) {
                final report = controller.listReports[index];
                final reportable = report.reportable;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.grey50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${report.reportableType} ${AppLocalizations.of(context)!.report}",
                            style: TextStyles.header.copyWith(
                              color: AppColors.active,
                            ),
                          ),
                          Gap(5),
                          Divider(),
                          Gap(5),
                          if (reportable != null)
                            report.reportableType == "Event"
                                ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.event_name,
                                          style: TextStyles.title.copyWith(
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        Gap(5),
                                        Text(
                                          reportable.title ?? '',
                                          style: TextStyles.paraghraph.copyWith(
                                            color: AppColors.grey400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                                : Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.user_name,
                                      style: TextStyles.title.copyWith(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    Gap(5),
                                    Text(
                                      reportable.name ?? '',
                                      style: TextStyles.paraghraph.copyWith(
                                        color: AppColors.grey400,
                                      ),
                                    ),
                                  ],
                                ),
                          Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.reason,
                                style: TextStyles.title.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                              Gap(5),
                              Text(
                                report.reason ?? '',
                                style: TextStyles.paraghraph.copyWith(
                                  color: AppColors.grey400,
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.status,
                                style: TextStyles.title.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                              Gap(5),
                              Text(
                                report.status ?? '',
                                style: TextStyles.paraghraph.copyWith(
                                  color: AppColors.grey400,
                                ),
                              ),
                            ],
                          ),
                          if (report.resolution != null) Divider(),
                          if (report.resolution != null)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.resolution,
                                  style: TextStyles.title.copyWith(
                                    color: AppColors.primary,
                                  ),
                                ),
                                Gap(5),
                                Text(
                                  report.resolution ?? '',
                                  style: TextStyles.paraghraph.copyWith(
                                    color: AppColors.grey400,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
    );
  }
}
