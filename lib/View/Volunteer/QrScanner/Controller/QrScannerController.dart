import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:impactlyflutter/Constant/url.dart';
import 'package:impactlyflutter/Services/CustomDialog.dart';
import 'package:impactlyflutter/Services/Failure.dart';
import 'package:impactlyflutter/Services/NetworkClient.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class QrScannerController with ChangeNotifier {
  late MobileScannerController controller;
  bool _hasScanned = false; // للتحقق إذا تم المسح بالفعل

  void initState() {
    controller = MobileScannerController(
      // autoStart: true,
      autoStart: true,
      autoZoom: true,
      facing: CameraFacing.back,
      formats: [BarcodeFormat.qrCode],
    );
  }

  void handleBarcode(BuildContext context, Barcode barcode) {
    if (_hasScanned) return; // إذا سبق المسح، تجاهل أي مسح آخر
    _hasScanned = true;

    final qrData = barcode.rawValue;
    if (qrData == null) return;

    log("QR scanned: $qrData");

    sendQrToApi(context, qrData);
  }

  Future<Either<Failure, bool>> sendQrToApi(
    BuildContext context,
    String qr,
  ) async {
    final client = Provider.of<NetworkClient>(context, listen: false);

    try {
      final response = await client.request(
        path: AppApi.ScanQR,
        withtoken: true,

        requestType: RequestType.POST,
        body: jsonEncode({"encrypted_data": qr}),
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        CustomDialog.DialogSuccess(context, title: "${data['message']}");
        return Right(true);
      } else if (response.statusCode == 400) {
        CustomDialog.DialogError(context, title: "${data['message']}");

        return Left(ResultFailure(''));
      } else if (response.statusCode == 404) {
        return Left(ResultFailure(''));
      } else {
        return Left(GlobalFailure());
      }
    } catch (e) {
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }
}
