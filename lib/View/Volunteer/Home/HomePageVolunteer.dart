import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Constant/text_styles.dart';
import 'package:impactlyflutter/View/Volunteer/Home/Controller/HomePageVolunteerController.dart';
import 'package:impactlyflutter/Widgets/Button/ButtonCustom.dart';
import 'package:impactlyflutter/Widgets/TextInput/TextInputCustomSearch.dart';
<<<<<<< HEAD
import 'package:impactlyflutter/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
=======
import 'package:intl/intl.dart';

>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
import 'package:provider/provider.dart';

class HomePageVolunteer extends StatelessWidget {
  const HomePageVolunteer({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final locale = AppLocalizations.of(context)!;

=======
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
    return Consumer<HomePageVolunteerController>(
      builder:
          (context, controller, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
<<<<<<< HEAD
                locale.home,
=======
                "Home",
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
                style: TextStyles.header.copyWith(color: AppColors.black),
              ),
              elevation: 0,
              centerTitle: true,
            ),
            body: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(16),
              children: [
<<<<<<< HEAD
                Row(
                  children: [
                    IconButton(
                      onPressed: () => controller.showEventFilters(context),
                      icon: Icon(Icons.filter_alt_outlined),
                    ),
                    Expanded(
                      child: TextInputCustomSearch(
                        hint: locale.search,
                        controller: controller.searchcontroller,
                        onSearch: (query) => controller.searchEvent(query),
                      ),
                    ),
                    IconButton(
                      onPressed: () => controller.DistrictEvents(context),
                      icon: Icon(Icons.refresh),
                    ),
                  ],
                ),
                Gap(10),
                Wrap(
                  children: [
                    ChoiceChip(
                      backgroundColor: AppColors.active,
                      label: Text(locale.all),
                      selected: false,
                      onSelected: (value) => controller.AllEvents(context),
                    ),
                    ChoiceChip(
                      label: Text(locale.by_district),
                      selected: true,
                      onSelected: (value) => controller.DistrictEvents(context),
                    ),
                  ],
=======
                TextInputCustomSearch(
                  hint: "Search",
                  controller: controller.searchcontroller,
                  onSearch: (query) => controller.searchEvent(query),
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
                ),
                Gap(10),
                controller.isLoadinggetEvent
                    ? Center(child: CircularProgressIndicator())
<<<<<<< HEAD
                    : controller.listEventfilter.isEmpty
                    ? Center(child: Text(locale.no_data_available))
=======
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
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
<<<<<<< HEAD
                                                        locale.max,
=======
                                                        "Max",
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
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
<<<<<<< HEAD
=======

>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
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
<<<<<<< HEAD
                                                    Gap(5),
=======

                                                    Gap(5),

>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
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
<<<<<<< HEAD
=======

>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
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
<<<<<<< HEAD
=======

>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
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
<<<<<<< HEAD
=======

>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
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
<<<<<<< HEAD
                                                    Text(locale.from),
                                                    Gap(5),
=======
                                                    Text("From"),
                                                    Gap(5),

>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
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
<<<<<<< HEAD
                                                    Text(locale.to),
=======
                                                    Text("To"),
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
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
<<<<<<< HEAD
=======

>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .volunteer_activism_outlined,
                                                    ),
                                                    Gap(5),
<<<<<<< HEAD
                                                    Text(
                                                      locale.registered_colon,
                                                    ),
=======
                                                    Text("Registered: "),
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
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
<<<<<<< HEAD
                                            if (e
                                                .requestedPledges!
                                                .isNotEmpty) ...[
                                              Divider(),
                                              Text(
                                                locale.pledge,
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
=======
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
                                            Gap(5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                e.isRegistered!
                                                    ? Text(
<<<<<<< HEAD
                                                      locale.already_registered,
=======
                                                      "You have already registered",
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
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
<<<<<<< HEAD
                                                          locale.register,
=======
                                                          "Register",
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
                                                          style:
                                                              TextStyles.button,
                                                        ),
                                                      ),
                                                    ),
<<<<<<< HEAD
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
                                                        locale.new_pledge,
                                                        style:
                                                            TextStyles.button,
                                                      ),
                                                    ),
                                                  ),
                                                ],
=======
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
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
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
