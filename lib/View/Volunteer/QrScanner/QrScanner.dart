import 'package:flutter/material.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/View/Volunteer/QrScanner/Controller/QrScannerController.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class Qrscanner extends StatefulWidget {
  const Qrscanner({super.key});

  @override
  State<Qrscanner> createState() => _QrscannerState();
}

class _QrscannerState extends State<Qrscanner> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<QrScannerController>(
        builder:
            (context, controller, child) => MobileScanner(
              controller: controller.controller,
              fit: BoxFit.fill,
              onDetect: (capture) {
                final barcode = capture.barcodes.first;
                controller.handleBarcode(context, barcode);
              },
              overlayBuilder:
                  (context, constraints) => Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.red, width: 3),
                    ),
                  ),
            ),
      ),
    );
  }
}
