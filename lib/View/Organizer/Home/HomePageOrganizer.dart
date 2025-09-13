import 'package:flutter/material.dart';
import 'package:impactlyflutter/View/Organizer/Home/Controller/HomePageOrganizerController.dart';
import 'package:impactlyflutter/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Constant/text_styles.dart';
import 'package:impactlyflutter/Widgets/Button/ButtonCustom.dart';
import 'package:impactlyflutter/Widgets/TextInput/TextInputCustomSearch.dart';
import 'package:intl/intl.dart';

class HomePageOrganizer extends StatelessWidget {
  const HomePageOrganizer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageOrganizerController>(
      builder:
          (context, controller, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                AppLocalizations.of(context)!.allevent,
                style: TextStyles.header.copyWith(color: AppColors.black),
              ),
              elevation: 0,
              centerTitle: true,
            ),
            body: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(16),
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => controller.showEventFilters(context),
                      icon: Icon(Icons.filter_alt_outlined),
                    ),
                    Expanded(
                      child: TextInputCustomSearch(
                        hint: AppLocalizations.of(context)!.search,
                        controller: controller.searchcontroller,
                        onSearch: (query) => controller.searchEvent(query),
                      ),
                    ),
                    IconButton(
                      onPressed: () => controller.AllEvents(context),
                      icon: Icon(Icons.refresh_sharp),
                    ),
                  ],
                ),
                Gap(10),

                controller.isLoadinggetEvent
                    ? Center(child: CircularProgressIndicator())
                    : controller.listEventfilter.isEmpty
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
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.max,
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
                                                    Text(
                                                      AppLocalizations.of(
                                                        context,
                                                      )!.from,
                                                    ),
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
                                                    Text(
                                                      AppLocalizations.of(
                                                        context,
                                                      )!.to,
                                                    ),
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
                                                    Text(
                                                      AppLocalizations.of(
                                                        context,
                                                      )!.registered,
                                                    ),
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
                                            if (e
                                                .requestedPledges!
                                                .isNotEmpty) ...[
                                              Divider(),
                                              Text(
                                                AppLocalizations.of(
                                                  context,
                                                )!.pledges,
                                                style: TextStyles.title,
                                              ),
                                              Gap(5),
                                              Column(
                                                children:
                                                    e.requestedPledges!
                                                        .map(
                                                          (e) => Wrap(
                                                            runSpacing: 5,
                                                            spacing: 5,
                                                            children: [
                                                              if (e.donationType ==
                                                                  'money') ...[
                                                                Icon(
                                                                  Icons
                                                                      .monetization_on_outlined,
                                                                ),

                                                                Text(
                                                                  e.amount!
                                                                      .toString(),
                                                                  style: TextStyles
                                                                      .paraghraph
                                                                      .copyWith(
                                                                        color:
                                                                            AppColors.grey400,
                                                                      ),
                                                                ),
                                                              ],
                                                              if (e.donationType !=
                                                                  'money') ...[
                                                                Icon(
                                                                  Icons
                                                                      .inventory_2_outlined,
                                                                ),
                                                                Text(
                                                                  e.itemName!,
                                                                  style: TextStyles
                                                                      .paraghraph
                                                                      .copyWith(
                                                                        color:
                                                                            AppColors.grey400,
                                                                      ),
                                                                ),
                                                                Text(
                                                                  e.quantity!
                                                                      .toString(),
                                                                  style: TextStyles
                                                                      .paraghraph
                                                                      .copyWith(
                                                                        color:
                                                                            AppColors.grey400,
                                                                      ),
                                                                ),
                                                              ],
                                                              Text(
                                                                e.notes ?? '',
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                        .toList(),
                                              ),
                                            ],
                                            Gap(5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                if (e
                                                    .requestedPledges!
                                                    .isNotEmpty) ...[
                                                  Gap(5),
                                                  ButtonCustom(
                                                    fullWidth: false,
                                                    width: 150,
                                                    fullheight: true,
                                                    onTap:
                                                        () => controller.DialogAddOrUpdatePledges(
                                                          context,
                                                          e.id,
                                                          e.requestedPledges!,
                                                        ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            8.0,
                                                          ),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.newpledge,
                                                        style:
                                                            TextStyles.button,
                                                      ),
                                                    ),
                                                  ),
                                                  Gap(5),
                                                ],
                                                ButtonCustom(
                                                  fullWidth: false,
                                                  width: 150,
                                                  fullheight: true,
                                                  onTap: () {
                                                    controller.DialogReportEvent(
                                                      context,
                                                      e.id!,
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          8.0,
                                                        ),
                                                    child: Text(
                                                      AppLocalizations.of(
                                                        context,
                                                      )!.report,
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
