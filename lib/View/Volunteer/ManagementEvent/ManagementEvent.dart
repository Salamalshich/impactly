import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Constant/text_styles.dart';
import 'package:impactlyflutter/Services/Routes.dart';
import 'package:impactlyflutter/View/EventDetails/Controller/EventDetailsController.dart';
import 'package:impactlyflutter/View/EventDetails/EventDetails.dart';
import 'package:impactlyflutter/View/Volunteer/ManagementEvent/Controller/ManagementEventController.dart';
import 'package:impactlyflutter/Widgets/Button/ButtonCustom.dart';
import 'package:impactlyflutter/Widgets/TextInput/TextInputCustomSearch.dart';
import 'package:impactlyflutter/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ManagementEvent extends StatelessWidget {
  const ManagementEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ManagementEventController>(
      builder:
          (context, controller, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                AppLocalizations.of(context)!.event_management,
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
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(16),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextInputCustomSearch(
                        hint: AppLocalizations.of(context)!.search,
                        controller: controller.searchcontroller,
                        onSearch: (query) => controller.searchEvent(query),
                      ),
                    ),
                    IconButton(
                      onPressed: () => controller.MyRegisteredEvents(context),
                      icon: Icon(Icons.refresh),
                    ),
                  ],
                ),
                Gap(10),
                controller.isLoadinggetEvent
                    ? Center(child: CircularProgressIndicator())
                    : controller.listVolunteerRegisterationfilter.isEmpty
                    ? Center(
                      child: Text(
                        AppLocalizations.of(context)!.no_data_available,
                      ),
                    )
                    : SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            controller.listVolunteerRegisterationfilter
                                .map(
                                  (e) => Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: AppColors.grey50,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!.register_information,
                                                  style: TextStyles.header,
                                                ),
                                                Gap(10),
                                                Row(
                                                  children: [
                                                    Icon(Icons.shield_outlined),
                                                    Gap(5),
                                                    Text(
                                                      AppLocalizations.of(
                                                        context,
                                                      )!.status,
                                                    ),
                                                    Gap(5),
                                                    Expanded(
                                                      child: Text(
                                                        e.registration!.status!,
                                                        style: TextStyles
                                                            .paraghraph
                                                            .copyWith(
                                                              color:
                                                                  AppColors
                                                                      .grey400,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Gap(5),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .access_time_outlined,
                                                    ),
                                                    Gap(5),
                                                    Text(
                                                      AppLocalizations.of(
                                                        context,
                                                      )!.hours,
                                                    ),
                                                    Gap(5),
                                                    Expanded(
                                                      child: Text(
                                                        e
                                                            .registration!
                                                            .hoursWorked
                                                            .toString(),
                                                        style: TextStyles
                                                            .paraghraph
                                                            .copyWith(
                                                              color:
                                                                  AppColors
                                                                      .grey400,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Gap(5),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.feedback_outlined,
                                                    ),
                                                    Gap(5),
                                                    Text(
                                                      AppLocalizations.of(
                                                        context,
                                                      )!.feedback,
                                                    ),
                                                    Gap(5),
                                                    Expanded(
                                                      child: Text(
                                                        e
                                                                .registration!
                                                                .feedback ??
                                                            "nothing",
                                                        style: TextStyles
                                                            .paraghraph
                                                            .copyWith(
                                                              color:
                                                                  AppColors
                                                                      .grey400,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Gap(5),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .star_border_outlined,
                                                    ),
                                                    Gap(5),
                                                    Text(
                                                      AppLocalizations.of(
                                                        context,
                                                      )!.rating,
                                                    ),
                                                    Gap(5),
                                                    Expanded(
                                                      child: Text(
                                                        e.registration!.rating
                                                            .toString(),
                                                        style: TextStyles
                                                            .paraghraph
                                                            .copyWith(
                                                              color:
                                                                  AppColors
                                                                      .grey400,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Divider(thickness: 1),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            AppLocalizations.of(
                                                              context,
                                                            )!.event_information,
                                                            style:
                                                                TextStyles
                                                                    .header,
                                                          ),
                                                          Gap(10),
                                                          Text(
                                                            e.event!.title!,
                                                            style:
                                                                TextStyles
                                                                    .title,
                                                          ),
                                                          if (e
                                                                  .event!
                                                                  .category !=
                                                              null)
                                                            Text(
                                                              e
                                                                  .event!
                                                                  .category!,
                                                              style: TextStyles
                                                                  .paraghraph
                                                                  .copyWith(
                                                                    color:
                                                                        AppColors
                                                                            .grey300,
                                                                  ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          AppColors.primary,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            AppLocalizations.of(
                                                              context,
                                                            )!.max,
                                                            style: TextStyles
                                                                .paraghraph
                                                                .copyWith(
                                                                  fontSize:
                                                                      10.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      AppColors
                                                                          .basic,
                                                                ),
                                                          ),
                                                          Text(
                                                            e
                                                                .event!
                                                                .maxVolunteers
                                                                .toString(),
                                                            style: TextStyles
                                                                .paraghraph
                                                                .copyWith(
                                                                  fontSize:
                                                                      10.sp,
                                                                  color:
                                                                      AppColors
                                                                          .basic,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Gap(5),
                                                Text(
                                                  e.event!.description!,
                                                  style: TextStyles.paraghraph,
                                                ),
                                                Gap(5),
                                                Wrap(
                                                  alignment:
                                                      WrapAlignment.start,
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.start,
                                                  spacing: 5,
                                                  runSpacing: 5,
                                                  children: [
                                                    Wrap(
                                                      spacing: 5,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .location_on_outlined,
                                                        ),
                                                        if (e
                                                                .event!
                                                                .governorateName !=
                                                            null)
                                                          Gap(5),
                                                        if (e
                                                                .event!
                                                                .governorateName !=
                                                            null)
                                                          Text(
                                                            e
                                                                .event!
                                                                .governorateName!,
                                                            style: TextStyles
                                                                .paraghraph
                                                                .copyWith(
                                                                  color:
                                                                      AppColors
                                                                          .grey400,
                                                                ),
                                                          ),
                                                        if (e
                                                                .event!
                                                                .governorateName !=
                                                            null)
                                                          Gap(5),
                                                        if (e
                                                                .event!
                                                                .districtName !=
                                                            null)
                                                          Text(
                                                            e
                                                                .event!
                                                                .districtName!,
                                                            style: TextStyles
                                                                .paraghraph
                                                                .copyWith(
                                                                  color:
                                                                      AppColors
                                                                          .grey400,
                                                                ),
                                                          ),
                                                        if (e.event!.location !=
                                                            null)
                                                          Gap(5),
                                                        if (e.event!.location !=
                                                            null)
                                                          Text(
                                                            e.event!.location!,
                                                            style: TextStyles
                                                                .paraghraph
                                                                .copyWith(
                                                                  color:
                                                                      AppColors
                                                                          .grey400,
                                                                ),
                                                          ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.event_available,
                                                        ),
                                                        Gap(5),
                                                        Text(
                                                          AppLocalizations.of(
                                                            context,
                                                          )!.from,
                                                        ),
                                                        Gap(5),
                                                        Expanded(
                                                          child: Text(
                                                            DateFormat(
                                                              'yyyy-MM-dd HH:mm a',
                                                            ).format(
                                                              DateTime.parse(
                                                                e
                                                                    .event!
                                                                    .startDate!,
                                                              ),
                                                            ),
                                                            style: TextStyles
                                                                .paraghraph
                                                                .copyWith(
                                                                  color:
                                                                      AppColors
                                                                          .grey400,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.event_busy),
                                                        Gap(5),
                                                        Text(
                                                          AppLocalizations.of(
                                                            context,
                                                          )!.to,
                                                        ),
                                                        Gap(5),
                                                        Expanded(
                                                          child: Text(
                                                            DateFormat(
                                                              'yyyy-MM-dd HH:mm a',
                                                            ).format(
                                                              DateTime.parse(
                                                                e
                                                                    .event!
                                                                    .endDate!,
                                                              ),
                                                            ),
                                                            style: TextStyles
                                                                .paraghraph
                                                                .copyWith(
                                                                  color:
                                                                      AppColors
                                                                          .grey400,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    if (e.event!.status ==
                                                        "completed")
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .gpp_good_outlined,
                                                          ),
                                                          Gap(5),
                                                          Text(
                                                            AppLocalizations.of(
                                                              context,
                                                            )!.status_is,
                                                          ),
                                                          Gap(5),
                                                          Expanded(
                                                            child: Text(
                                                              e.event!.status!,
                                                              style: TextStyles
                                                                  .paraghraph
                                                                  .copyWith(
                                                                    color:
                                                                        AppColors
                                                                            .grey400,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .volunteer_activism_outlined,
                                                        ),
                                                        Gap(5),
                                                        Text(
                                                          "${AppLocalizations.of(context)!.registered}: ",
                                                        ),
                                                        Gap(5),
                                                        Text(
                                                          e
                                                              .event!
                                                              .volunteerRegistrationsCount
                                                              .toString(),
                                                          style: TextStyles
                                                              .paraghraph
                                                              .copyWith(
                                                                color:
                                                                    AppColors
                                                                        .grey400,
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
                                          if (e.registration!.status ==
                                                  'attended' &&
                                              (e.registration!.feedback ==
                                                      null &&
                                                  e.registration!.rating ==
                                                      null)) ...[
                                            Expanded(
                                              child: ButtonCustom(
                                                fullWidth: true,
                                                onTap: () {
                                                  controller.DialogFeedbackEvent(
                                                    context,
                                                    e.registration!.id!,
                                                  );
                                                },
                                                title:
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.feedback_and_rating,
                                              ),
                                            ),
                                            Gap(5),
                                          ],
                                          if (DateTime.now().isAfter(
                                            DateTime.parse(e.event!.startDate!),
                                          )) ...[
                                            Expanded(
                                              child: ButtonCustom(
                                                fullWidth: true,
                                                onTap: () {
                                                  controller.DialogLateReportEvent(
                                                    context,
                                                    e.event!.id!,
                                                  );
                                                },
                                                title:
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.late_report,
                                              ),
                                            ),
                                            Gap(5),
                                          ],
                                          Expanded(
                                            child: ButtonCustom(
                                              fullWidth: true,
                                              onTap: () {
                                                controller.DialogReportEvent(
                                                  context,
                                                  e.registration!.id!,
                                                );
                                              },
                                              title:
                                                  AppLocalizations.of(
                                                    context,
                                                  )!.report_event,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Gap(5),
                                      Row(
                                        children: [
                                          if (e.event!.status != 'completed' &&
                                              e.registration!.status !=
                                                  'cancelled')
                                            Expanded(
                                              child: ButtonCustom(
                                                color: AppColors.active,
                                                fullWidth: true,
                                                onTap:
                                                    () =>
                                                        controller.DialogWithdrawFromEvent(
                                                          context,
                                                          e.registration!.id!,
                                                        ),
                                                title:
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.withdraw,
                                              ),
                                            ),
                                          if (e.event!.status == 'completed' &&
                                              e.registration!.status ==
                                                  'attended')
                                            Expanded(
                                              child: ButtonCustom(
                                                color: AppColors.active,
                                                fullWidth: true,
                                                onTap:
                                                    () => CustomRoute.RouteTo(
                                                      context,
                                                      ChangeNotifierProvider(
                                                        create:
                                                            (context) =>
                                                                EventDetailsController()
                                                                  ..GetEventDetails(
                                                                    context,
                                                                    e
                                                                        .event!
                                                                        .id!,
                                                                  ),
                                                        builder:
                                                            (context, child) =>
                                                                EventDetails(
                                                                  false,
                                                                ),
                                                      ),
                                                    ),
                                                title:
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.show_details,
                                              ),
                                            ),
                                        ],
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
