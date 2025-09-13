import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Constant/text_styles.dart';
import 'package:impactlyflutter/Services/Routes.dart';
import 'package:impactlyflutter/View/Pledges/Controller/PledgesPageController.dart';
import 'package:impactlyflutter/Widgets/Button/ButtonCustom.dart';
import 'package:impactlyflutter/Widgets/TextInput/TextInputCustomSearch.dart';
import 'package:impactlyflutter/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PledgesPage extends StatelessWidget {
  const PledgesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PledgesPageController>(
      builder:
          (context, controller, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                AppLocalizations.of(context)!.my_pledges,
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
                        onSearch: (query) => controller.searchPledges(query),
                      ),
                    ),
                    IconButton(
                      onPressed: () => controller.GetMyPledges(context),
                      icon: Icon(Icons.refresh),
                    ),
                  ],
                ),
                Gap(10),
                controller.isLoadinggetPledges
                    ? Center(child: CircularProgressIndicator())
                    : controller.listPledgesfilter.isEmpty
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
                            controller.listPledgesfilter.map((e) {
                              return Column(
                                children: [
                                  Padding(
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
                                            Text(
                                              AppLocalizations.of(
                                                context,
                                              )!.event,
                                              style: TextStyles.header,
                                            ),
                                            Gap(5),
                                            Column(
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
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Gap(5),
                                            Divider(),
                                            Gap(5),
                                            Text(
                                              AppLocalizations.of(
                                                context,
                                              )!.pledges,
                                              style: TextStyles.header,
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
                                                    Icon(Icons.title),
                                                    Gap(5),
                                                    Text(
                                                      AppLocalizations.of(
                                                        context,
                                                      )!.item_amount,
                                                    ),
                                                    Gap(5),
                                                    Expanded(
                                                      child: Text(
                                                        e.itemName ??
                                                            e.amount.toString(),
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
                                                if (e.quantity != null)
                                                  Row(
                                                    children: [
                                                      Icon(Icons.numbers),
                                                      Gap(5),
                                                      Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.quantity,
                                                      ),
                                                      Gap(5),
                                                      Expanded(
                                                        child: Text(
                                                          e.quantity!
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
                                                Row(
                                                  children: [
                                                    Icon(Icons.notes_outlined),
                                                    Gap(5),
                                                    Text(
                                                      AppLocalizations.of(
                                                        context,
                                                      )!.notes,
                                                    ),
                                                    Gap(5),
                                                    Expanded(
                                                      child: Text(
                                                        e.notes ?? '',
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
                                                      Icons.gpp_good_outlined,
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
                                                        e.status ?? '',
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
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (e.status == 'pending')
                                    Row(
                                      children: [
                                        if (e.donationType == 'item') ...[
                                          Expanded(
                                            child: ButtonCustom(
                                              fullWidth: true,
                                              onTap:
                                                  () =>
                                                      controller.DialogAddOrUpdatePledges(
                                                        context,
                                                        pledge: e,
                                                      ),
                                              title:
                                                  AppLocalizations.of(
                                                    context,
                                                  )!.edit,
                                            ),
                                          ),
                                          Gap(5),
                                        ],
                                        Expanded(
                                          child: ButtonCustom(
                                            color: AppColors.red,
                                            fullWidth: true,
                                            onTap:
                                                () =>
                                                    controller.DialogDeletePledges(
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
                                ],
                              );
                            }).toList(),
                      ),
                    ),
              ],
            ),
          ),
    );
  }
}
