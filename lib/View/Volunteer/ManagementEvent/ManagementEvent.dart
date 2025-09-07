import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Constant/text_styles.dart';
import 'package:impactlyflutter/Services/Routes.dart';
import 'package:impactlyflutter/View/Volunteer/ManagementEvent/Controller/ManagementEventController.dart';
import 'package:impactlyflutter/Widgets/Button/ButtonCustom.dart';
import 'package:impactlyflutter/Widgets/TextInput/TextInputCustomSearch.dart';
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
                "Event Management",
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
                TextInputCustomSearch(
                  hint: "Search",
                  controller: controller.searchcontroller,
                  onSearch: (query) => controller.searchEvent(query),
                ),
                Gap(10),
                controller.isLoadinggetEvent
                    ? Center(child: CircularProgressIndicator())
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
                                                  "Register information",
                                                  style: TextStyles.header,
                                                ),
                                                Gap(10),
                                                Row(
                                                  children: [
                                                    Icon(Icons.shield_outlined),
                                                    Gap(5),
                                                    Text("Status:"),
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
                                                    Text("Hours:"),
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
                                                    Text("Feedback:"),
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
                                                    Text("Rating:"),
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
                                                            "Event information",
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
                                                            "Max",
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
                                                        Text("From"),
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
                                                        Text("To"),
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
                                                          Text("Status is"),
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
                                                        Text("Registered: "),
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
                                                // Gap(5),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (e.registration!.status == 'attended')
                                        Row(
                                          children: [
                                            Expanded(
                                              child: ButtonCustom(
                                                fullWidth: true,
                                                onTap: () {
                                                  controller.DialogFeedbackEvent(
                                                    context,
                                                    e.registration!.id!,
                                                  );
                                                },

                                                title: "Feedback and rating",
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (e.event!.status != 'completed' &&
                                          e.registration!.status != 'cancelled')
                                        Row(
                                          children: [
                                            Gap(5),
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
                                                title: "Withdraw",
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
