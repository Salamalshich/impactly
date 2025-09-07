import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Constant/text_styles.dart';
import 'package:impactlyflutter/Controller/EncryptData.dart';
import 'package:impactlyflutter/Services/Routes.dart';
import 'package:impactlyflutter/View/EventDetails/Controller/EventDetailsController.dart';
import 'package:impactlyflutter/Widgets/Button/ButtonCustom.dart';
import 'package:impactlyflutter/Widgets/TextInput/TextInputCustomSearch.dart';
import 'package:intl/intl.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EventDetailsController>(
      builder:
          (context, controller, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                "Event Details",
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
                controller.isLoadinggetEvent
                    ? Center(child: CircularProgressIndicator())
                    : Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.eventDetails!.event!.title!,
                                        style: TextStyles.title,
                                      ),
                                      if (controller
                                              .eventDetails!
                                              .event!
                                              .category !=
                                          null)
                                        Text(
                                          controller
                                              .eventDetails!
                                              .event!
                                              .category!,
                                          style: TextStyles.paraghraph.copyWith(
                                            color: AppColors.grey300,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: AppColors.primary,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Max",
                                        style: TextStyles.paraghraph.copyWith(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.basic,
                                        ),
                                      ),
                                      Text(
                                        controller
                                            .eventDetails!
                                            .event!
                                            .maxVolunteers
                                            .toString(),
                                        style: TextStyles.paraghraph.copyWith(
                                          fontSize: 10.sp,
                                          color: AppColors.basic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Gap(5),
                            Text(
                              controller.eventDetails!.event!.description!,
                              style: TextStyles.paraghraph,
                            ),
                            Gap(5),

                            Wrap(
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              spacing: 5,
                              runSpacing: 5,
                              children: [
                                Wrap(
                                  spacing: 5,
                                  children: [
                                    Icon(Icons.location_on_outlined),
                                    if (controller
                                            .eventDetails!
                                            .event!
                                            .governorateName !=
                                        null)
                                      Gap(5),

                                    if (controller
                                            .eventDetails!
                                            .event!
                                            .governorateName !=
                                        null)
                                      Text(
                                        controller
                                            .eventDetails!
                                            .event!
                                            .governorateName!,
                                        style: TextStyles.paraghraph.copyWith(
                                          color: AppColors.grey400,
                                        ),
                                      ),
                                    if (controller
                                            .eventDetails!
                                            .event!
                                            .governorateName !=
                                        null)
                                      Gap(5),

                                    if (controller
                                            .eventDetails!
                                            .event!
                                            .districtName !=
                                        null)
                                      Text(
                                        controller
                                            .eventDetails!
                                            .event!
                                            .districtName!,
                                        style: TextStyles.paraghraph.copyWith(
                                          color: AppColors.grey400,
                                        ),
                                      ),
                                    if (controller
                                            .eventDetails!
                                            .event!
                                            .location !=
                                        null)
                                      Gap(5),

                                    if (controller
                                            .eventDetails!
                                            .event!
                                            .location !=
                                        null)
                                      Text(
                                        controller
                                            .eventDetails!
                                            .event!
                                            .location!,
                                        style: TextStyles.paraghraph.copyWith(
                                          color: AppColors.grey400,
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

                                    Expanded(
                                      child: Text(
                                        DateFormat('yyyy-MM-dd HH:mm a').format(
                                          DateTime.parse(
                                            controller
                                                .eventDetails!
                                                .event!
                                                .startDate!,
                                          ),
                                        ),
                                        style: TextStyles.paraghraph.copyWith(
                                          color: AppColors.grey400,
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
                                        DateFormat('yyyy-MM-dd HH:mm a').format(
                                          DateTime.parse(
                                            controller
                                                .eventDetails!
                                                .event!
                                                .endDate!,
                                          ),
                                        ),
                                        style: TextStyles.paraghraph.copyWith(
                                          color: AppColors.grey400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.gpp_good_outlined),
                                    Gap(5),
                                    Text("Status is"),
                                    Gap(5),
                                    Expanded(
                                      child: Text(
                                        controller.eventDetails!.event!.status!,
                                        style: TextStyles.paraghraph.copyWith(
                                          color: AppColors.grey400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (controller
                                        .eventDetails!
                                        .event!
                                        .rejectionReason !=
                                    null)
                                  Row(
                                    children: [
                                      Icon(Icons.messenger_outline_sharp),
                                      Gap(5),
                                      Text("Rejection Reason:"),
                                      Gap(5),
                                      Expanded(
                                        child: Text(
                                          controller
                                              .eventDetails!
                                              .event!
                                              .rejectionReason!,
                                          style: TextStyles.paraghraph.copyWith(
                                            color: AppColors.grey400,
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
                if (controller.eventDetails?.event!.status == 'approved')
                  Gap(10),
                if (controller.eventDetails?.event!.status == 'approved')
                  ButtonCustom(
                    onTap: () => controller.DialogCompleteEvent(context),
                    title: "Complete Event",
                    color: AppColors.primary,
                  ),
                Gap(10),
                Divider(thickness: 2),
                Gap(10),
                Row(
                  children: [
                    Expanded(
                      child: ButtonCustom(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              // البيانات يلي رح تتسجل
                              final data = {
                                "time": DateTime.now().toString(),
                                "event_id": controller.eventDetails!.event!.id!,
                                "type": "check_out",
                              };

                              // تشفير البيانات
                              final encryptedData = encryptAES(data);
                              log(encryptedData.toString());
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: AppColors.basic,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: PrettyQrView(
                                        decoration: const PrettyQrDecoration(
                                          image: PrettyQrDecorationImage(
                                            image: AssetImage(
                                              "assets/PNG/Logo.png",
                                            ),
                                          ),
                                        ),
                                        qrImage: QrImage(
                                          QrCode.fromData(
                                            data: encryptedData,
                                            errorCorrectLevel:
                                                QrErrorCorrectLevel.M,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        fullWidth: true,
                        fullheight: true,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.qr_code_2,
                                color: AppColors.basic,
                                size: 50,
                              ),
                              Text(
                                "Generate Qr Check Out",
                                style: TextStyles.button,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Gap(5),
                    Expanded(
                      child: ButtonCustom(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              // البيانات يلي رح تتسجل
                              final data = {
                                "time": DateTime.now().toString(),
                                "event_id": controller.eventDetails!.event!.id!,
                                "type": "check_in",
                              };

                              // تشفير البيانات
                              final encryptedData = encryptAES(data);
                              log(encryptedData.toString());
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: AppColors.basic,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: PrettyQrView(
                                        decoration: const PrettyQrDecoration(
                                          image: PrettyQrDecorationImage(
                                            image: AssetImage(
                                              "assets/PNG/Logo.png",
                                            ),
                                          ),
                                        ),
                                        qrImage: QrImage(
                                          QrCode.fromData(
                                            data: encryptedData,
                                            errorCorrectLevel:
                                                QrErrorCorrectLevel.M,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        fullWidth: true,
                        fullheight: true,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.qr_code_2,
                                color: AppColors.basic,
                                size: 50,
                              ),
                              Text(
                                "Generate Qr CheckIn",
                                style: TextStyles.button,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(10),
                Divider(thickness: 2),
                Gap(10),
                Text("Volunteer", style: TextStyles.header),
                Gap(5),

                TextInputCustomSearch(
                  hint: "Search",
                  controller: controller.searchcontroller,
                  onSearch: (query) => controller.searchEvent(query),
                ),
                Gap(10),
                controller.searchcontroller.text.isEmpty
                    ? Row(
                      children: [
                        Text("Total Volenteer: ", style: TextStyles.subheader),
                        Skeletonizer(
                          enabled: controller.isLoadinggetEvent,
                          child: Text(
                            "${controller.eventDetails?.volunteerParticipations!.length}",
                            style: TextStyles.title,
                          ),
                        ),
                      ],
                    )
                    : Row(
                      children: [
                        Text("Search result: ", style: TextStyles.subheader),
                        Text(
                          "${controller.listattendancesfilter!.length}",
                          style: TextStyles.title,
                        ),
                      ],
                    ),
                controller.isLoadinggetEvent
                    ? Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Skeletonizer(
                        enabled: controller.isLoadinggetEvent,
                        child: Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                  label: Text("Name"),
                                  headingRowAlignment: MainAxisAlignment.center,
                                ),
                                DataColumn(
                                  label: Text("Status"),
                                  headingRowAlignment: MainAxisAlignment.center,
                                ),
                                DataColumn(
                                  label: Text("Check In"),
                                  headingRowAlignment: MainAxisAlignment.center,
                                ),
                                DataColumn(
                                  label: Text("Check Out"),
                                  headingRowAlignment: MainAxisAlignment.center,
                                ),
                                DataColumn(
                                  label: Text("Hours"),
                                  headingRowAlignment: MainAxisAlignment.center,
                                ),
                                DataColumn(
                                  label: Text("Verifed"),
                                  headingRowAlignment: MainAxisAlignment.center,
                                ),
                                DataColumn(
                                  label: Text("Options"),
                                  headingRowAlignment: MainAxisAlignment.center,
                                ),
                              ],
                              rows:
                                  controller.listattendancesfilter!
                                      .map(
                                        (e) => DataRow(
                                          cells: [
                                            DataCell(
                                              Center(
                                                child: Text(e.user!.name!),
                                              ),
                                            ),
                                            DataCell(
                                              Center(child: Text(e.status!)),
                                            ),
                                            DataCell(
                                              Center(
                                                child: Text(
                                                  e.checkIn == null
                                                      ? "Unkown"
                                                      : DateFormat(
                                                        'yyyy-MM-dd HH:mm a',
                                                      ).format(
                                                        DateTime.parse(
                                                          e.checkIn.toString(),
                                                        ),
                                                      ),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Center(
                                                child: Text(
                                                  e.checkOut == null
                                                      ? "Unkown"
                                                      : DateFormat(
                                                        'yyyy-MM-dd HH:mm a',
                                                      ).format(
                                                        DateTime.parse(
                                                          e.checkOut!
                                                              .toString(),
                                                        ),
                                                      ),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Center(
                                                child: Text(
                                                  e.hoursWorked.toString(),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Center(
                                                child: Icon(
                                                  e.verifiedBy != null
                                                      ? Icons.check
                                                      : Icons.close,
                                                  color: AppColors.basic,
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Row(
                                                children: [
                                                  Center(
                                                    child: IconButton(
                                                      icon: Icon(
                                                        Icons
                                                            .check_circle_outline_outlined,
                                                        color: AppColors.basic,
                                                      ),
                                                      onPressed: () {
                                                        controller.DialogVerifedVolunteer(
                                                          context,
                                                          e,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Center(
                                                    child: IconButton(
                                                      icon: Icon(
                                                        Icons
                                                            .not_interested_outlined,
                                                        color: AppColors.basic,
                                                      ),
                                                      onPressed: () {
                                                        controller.DialogVolunteerNoShow(
                                                          context,
                                                          e,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                      .toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                Gap(10),
                Divider(thickness: 2),
                Gap(10),
                Text("Pledges", style: TextStyles.header),
                Gap(5),
                controller.isLoadinggetEvent
                    ? Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Skeletonizer(
                        enabled: controller.isLoadinggetEvent,
                        child: Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                  label: Text("Item name"),
                                  headingRowAlignment: MainAxisAlignment.center,
                                ),
                                DataColumn(
                                  label: Text("Quantity"),
                                  headingRowAlignment: MainAxisAlignment.center,
                                ),
                                DataColumn(
                                  label: Text("Notes"),
                                  headingRowAlignment: MainAxisAlignment.center,
                                ),
                                DataColumn(
                                  label: Text("Owner Name"),
                                  headingRowAlignment: MainAxisAlignment.center,
                                ),
                                DataColumn(
                                  label: Text("Owner Phone"),
                                  headingRowAlignment: MainAxisAlignment.center,
                                ),
                                DataColumn(
                                  label: Text("Owner Email"),
                                  headingRowAlignment: MainAxisAlignment.center,
                                ),
                                DataColumn(
                                  label: Text("Status"),
                                  headingRowAlignment: MainAxisAlignment.center,
                                ),

                                DataColumn(
                                  label: Text("Options"),
                                  headingRowAlignment: MainAxisAlignment.center,
                                ),
                              ],
                              rows:
                                  controller.eventDetails!.pledges!
                                      .map(
                                        (e) => DataRow(
                                          cells: [
                                            DataCell(
                                              Center(child: Text(e.itemName!)),
                                            ),
                                            DataCell(
                                              Center(
                                                child: Text(
                                                  e.quantity!.toString(),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Center(child: Text(e.notes!)),
                                            ),
                                            DataCell(
                                              Center(
                                                child: Text(e.user!.name!),
                                              ),
                                            ),
                                            DataCell(
                                              Center(
                                                child: Text(e.user!.phone!),
                                              ),
                                            ),
                                            DataCell(
                                              Center(
                                                child: Text(e.user!.email!),
                                              ),
                                            ),
                                            DataCell(
                                              Center(child: Text(e.status!)),
                                            ),
                                            DataCell(
                                              Row(
                                                children: [
                                                  Center(
                                                    child: IconButton(
                                                      icon: Icon(
                                                        Icons.shield_outlined,
                                                        color: AppColors.basic,
                                                      ),
                                                      onPressed: () {
                                                        controller.DialogUpdateStatusPledges(
                                                          context,
                                                          e,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                      .toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
              ],
            ),
          ),
    );
  }
}
