import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Constant/text_styles.dart';
import 'package:impactlyflutter/Services/Routes.dart';
import 'package:impactlyflutter/View/EventDetails/Controller/EventDetailsController.dart';
import 'package:impactlyflutter/View/EventDetails/EventDetails.dart';
import 'package:impactlyflutter/View/MyEvent/Controller/MyEventController.dart';
import 'package:impactlyflutter/View/MyRequestedPledge/Controller/MyRequestedPledgeController.dart';
import 'package:impactlyflutter/View/MyRequestedPledge/MyRequstedPledge.dart';
import 'package:impactlyflutter/Widgets/Button/ButtonCustom.dart';
import 'package:impactlyflutter/Widgets/TextInput/TextInputCustomSearch.dart';
import 'package:impactlyflutter/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyEventController>(
      builder:
          (context, controller, child) => Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add, color: AppColors.basic),
              onPressed: () {
                controller.DialogAddOrUpdateEvent(context);
              },
            ),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                AppLocalizations.of(context)!.my_event,
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
                      onPressed: () => controller.GetMyEvent(context),
                      icon: Icon(Icons.refresh),
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
                                                            e.title!,
                                                            style:
                                                                TextStyles
                                                                    .title,
                                                          ),
                                                          if (e.category !=
                                                              null)
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
                                                            e.maxVolunteers
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
                                                  e.description!,
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
                                                        if (e.districtName !=
                                                            null)
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
                                                        ),
                                                      ],
                                                    ),
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
                                                            e.status!,
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
                                                    if (e.rejectionReason !=
                                                        null)
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .messenger_outline_sharp,
                                                          ),
                                                          Gap(5),
                                                          Text(
                                                            AppLocalizations.of(
                                                              context,
                                                            )!.rejection_reason,
                                                          ),
                                                          Gap(5),
                                                          Expanded(
                                                            child: Text(
                                                              e.rejectionReason!,
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
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (e.status != 'completed')
                                        Row(
                                          children: [
                                            Expanded(
                                              child: ButtonCustom(
                                                fullWidth: true,
                                                onTap:
                                                    () =>
                                                        controller.DialogAddOrUpdateEvent(
                                                          context,
                                                          event: e,
                                                        ),
                                                title:
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.edit,
                                              ),
                                            ),
                                            Gap(5),
                                            Expanded(
                                              child: ButtonCustom(
                                                color: AppColors.red,
                                                fullWidth: true,
                                                onTap:
                                                    () =>
                                                        controller.DialogDeleteEvent(
                                                          context,
                                                          e,
                                                        ),
                                                title:
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.delete,
                                              ),
                                            ),
                                          ],
                                        ),
                                      Gap(5),
                                      ButtonCustom(
                                        color: AppColors.secondery,
                                        fullWidth: true,
                                        onTap:
                                            () => CustomRoute.RouteTo(
                                              context,
                                              ChangeNotifierProvider(
                                                create:
                                                    (context) =>
                                                        MyRequestedPledgeController()
                                                          ..getEventRequests(
                                                            context,
                                                            e.id!,
                                                          ),
                                                builder:
                                                    (context, child) =>
                                                        MyRequestedPledge(),
                                              ),
                                            ),
                                        title:
                                            AppLocalizations.of(
                                              context,
                                            )!.pledges,
                                      ),
                                      Gap(5),
                                      ButtonCustom(
                                        color: AppColors.primary,
                                        fullWidth: true,
                                        onTap:
                                            () => CustomRoute.RouteTo(
                                              context,
                                              ChangeNotifierProvider(
                                                create:
                                                    (context) =>
                                                        EventDetailsController()
                                                          ..initcontroller(
                                                            controller,
                                                            context,
                                                          )
                                                          ..GetEventDetails(
                                                            context,
                                                            e.id!,
                                                          ),
                                                builder:
                                                    (context, child) =>
                                                        EventDetails(true),
                                              ),
                                            ),
                                        title:
                                            AppLocalizations.of(
                                              context,
                                            )!.show_details,
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
