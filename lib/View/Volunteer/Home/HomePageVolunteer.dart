import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Constant/text_styles.dart';
import 'package:impactlyflutter/View/Volunteer/Home/Controller/HomePageVolunteerController.dart';
import 'package:impactlyflutter/Widgets/Button/ButtonCustom.dart';
import 'package:impactlyflutter/Widgets/TextInput/TextInputCustomSearch.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class HomePageVolunteer extends StatelessWidget {
  const HomePageVolunteer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageVolunteerController>(
      builder:
          (context, controller, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                "Home",
                style: TextStyles.header.copyWith(color: AppColors.black),
              ),
              elevation: 0,
              centerTitle: true,
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
                            controller.listEventfilter
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
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
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      e.title!,
                                                      style: TextStyles.title,
                                                    ),
                                                    if (e.category != null)
                                                      Text(
                                                        e.category!,
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
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  AppColors
                                                                      .basic,
                                                            ),
                                                      ),
                                                      Text(
                                                        e.maxVolunteers
                                                            .toString(),
                                                        style: TextStyles
                                                            .paraghraph
                                                            .copyWith(
                                                              fontSize: 10.sp,
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
                                              e.description!,
                                              style: TextStyles.paraghraph,
                                            ),
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
                                                    Icon(Icons.domain),

                                                    Gap(5),

                                                    Text(
                                                      e.organizerName!,
                                                      style: TextStyles
                                                          .paraghraph
                                                          .copyWith(
                                                            color:
                                                                AppColors
                                                                    .grey400,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                    ),
                                                    if (e.governorateName !=
                                                        null)
                                                      Gap(5),

                                                    if (e.governorateName !=
                                                        null)
                                                      Text(
                                                        e.governorateName!,
                                                        style: TextStyles
                                                            .paraghraph
                                                            .copyWith(
                                                              color:
                                                                  AppColors
                                                                      .grey400,
                                                            ),
                                                      ),
                                                    if (e.governorateName !=
                                                        null)
                                                      Gap(5),

                                                    if (e.districtName != null)
                                                      Text(
                                                        e.districtName!,
                                                        style: TextStyles
                                                            .paraghraph
                                                            .copyWith(
                                                              color:
                                                                  AppColors
                                                                      .grey400,
                                                            ),
                                                      ),
                                                    if (e.location != null)
                                                      Gap(5),

                                                    if (e.location != null)
                                                      Text(
                                                        e.location!,
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
                                                    Icon(Icons.event_available),
                                                    Gap(5),
                                                    Text("From"),
                                                    Gap(5),

                                                    Text(
                                                      DateFormat(
                                                        'yyyy-MM-dd HH:mm a',
                                                      ).format(
                                                        DateTime.parse(
                                                          e.startDate!,
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
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.event_busy),
                                                    Gap(5),
                                                    Text("To"),
                                                    Gap(5),
                                                    Text(
                                                      DateFormat(
                                                        'yyyy-MM-dd HH:mm a',
                                                      ).format(
                                                        DateTime.parse(
                                                          e.endDate!,
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
                                                      e.volunteerRegistrationsCount
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
                                            Gap(5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                e.isRegistered!
                                                    ? Text(
                                                      "You have already registered",
                                                      style: TextStyles
                                                          .paraghraph
                                                          .copyWith(
                                                            color:
                                                                AppColors
                                                                    .primary,
                                                          ),
                                                    )
                                                    : ButtonCustom(
                                                      fullWidth: false,
                                                      width: 150,
                                                      fullheight: true,
                                                      onTap:
                                                          () =>
                                                              controller.DialogConfirmRegisteration(
                                                                context,
                                                                e,
                                                              ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                              8.0,
                                                            ),
                                                        child: Text(
                                                          "Register",
                                                          style:
                                                              TextStyles.button,
                                                        ),
                                                      ),
                                                    ),
                                                Gap(5),
                                                ButtonCustom(
                                                  fullWidth: false,
                                                  width: 150,
                                                  fullheight: true,
                                                  onTap:
                                                      () =>
                                                          controller.DialogAddOrUpdatePledges(
                                                            context,
                                                            e.id,
                                                          ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          8.0,
                                                        ),
                                                    child: Text(
                                                      "New pledge",
                                                      style: TextStyles.button,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
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
