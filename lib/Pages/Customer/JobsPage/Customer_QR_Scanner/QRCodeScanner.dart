import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:StandMan/widgets/MyButton.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Models/jobs_extra_amount_Modle.dart';
import '../../../../Utils/api_urls.dart';
import '../../../../widgets/ToastMessage.dart';
import '../../../../widgets/TopBar.dart';
import '../../HomePage/HomePage.dart';
import '../../HomePage/Paymeny_details.dart';
import 'package:http/http.dart' as http;

import '../Payment_Sheet/Customer_Payment_Sheet.dart';

class CustomerQRCodeScanner extends StatefulWidget {
  String? customerId;
  String? employeeId;
  String? jobId;
  String? jobName;
  String? buttonClickTime;
  CustomerQRCodeScanner({Key? key, this.customerId ,this.employeeId, this.buttonClickTime,  this.jobId, this.jobName, }) : super(key: key);

  @override
  State<CustomerQRCodeScanner> createState() => _CustomerQRCodeScannerState();
}

class _CustomerQRCodeScannerState extends State<CustomerQRCodeScanner> {

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 500.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  JobsExtraAmount jobsExtraAmount = JobsExtraAmount();

  bool progress = false;

  jobsExtraAmountWidget() async {
    progress = true;
    setState(() {});

    print("userEmployeeId = ${widget.employeeId}");
    print("buttonClickTime ${widget.buttonClickTime}");
    print("jobId ${widget.jobId}");

    // try {
      String apiUrl = jobsExtraAmountModelApiUrl;
      print("jobsExtraAmountApi: $apiUrl");
      final response = await http.post(Uri.parse(apiUrl),
          body: {
            "job_completion_time": widget.buttonClickTime,
            "employee_users_customers_id": widget.employeeId,
            "jobs_id": widget.jobId,
          }, headers: {
            'Accept': 'application/json'
          });
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("jobsExtraAmountResponse: ${responseString.toString()}");
        jobsExtraAmount = jobsExtraAmountFromJson(responseString);
        print("uusersCustomersId ${jobsExtraAmount.message?.usersCustomersId}");
        print("employeeUsersCustomersId ${jobsExtraAmount.message?.employeeUsersCustomersId}");
        print("jobsId ${jobsExtraAmount.message?.jobsId}");
      }
    // } catch (e) {
    //   print('Error in jobsExtraAmountWidget: ${e.toString()}');
    // }
    setState(() {
      progress = false;
    });

    Future.delayed(const Duration(seconds: 2), () {
      Payment(
        ctx: context,
        Price: jobsExtraAmount.message?.payment,
        PreviousAmount: jobsExtraAmount.message?.previousAmount,
        ExtraAmount: "${jobsExtraAmount.message?.extraAmount}",
        ServiceCharges: jobsExtraAmount.message?.serviceCharges.toString(),
        Tax: jobsExtraAmount.message?.tax,
        BookedTime: jobsExtraAmount.message?.bookedTime,
        BookedClosed: jobsExtraAmount.message?.bookedClose,
        ExtraTime: jobsExtraAmount.message?.extraTime.toString(),
        userCustomerId: jobsExtraAmount.message?.usersCustomersId.toString(),
        userEmployeeId: jobsExtraAmount.message?.employeeUsersCustomersId.toString(),
          jobId: jobsExtraAmount.message?.jobsId.toString(),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("CustomerId, jobId, jobName ${widget.customerId} ${widget.jobId} ${widget.jobName}");
      Future.delayed(const Duration(seconds: 3), () async {
        print("resultssss ${result?.code}");
      if(result?.code == "${widget.customerId} ${widget.jobId} ${widget.jobName}" ){

      await  jobsExtraAmountWidget();

      } else {
        toastFailedMessage("Failed to Scan", Colors.red);
      }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandManAppBar1(
        title: "Scan QR",
        bgcolor: Color(0xffffffff),
        titlecolor: Colors.white,
        iconcolor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          // Expanded(
          //   flex: 1,
          //   child: FittedBox(
          //     fit: BoxFit.contain,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: <Widget>[
          //         if (result != null)
          //           Text(
          //               'Barcode Data: ${result!.code}')
          //         else
          //           const Text('Scan a code'),
          //         // Row(
          //         //   mainAxisAlignment: MainAxisAlignment.center,
          //         //   crossAxisAlignment: CrossAxisAlignment.center,
          //         //   children: <Widget>[
          //         //     Container(
          //         //       margin: const EdgeInsets.all(8),
          //         //       child: ElevatedButton(
          //         //           onPressed: () async {
          //         //             await controller?.toggleFlash();
          //         //             setState(() {});
          //         //           },
          //         //           child: FutureBuilder(
          //         //             future: controller?.getFlashStatus(),
          //         //             builder: (context, snapshot) {
          //         //               return Text('Flash: ${snapshot.data}');
          //         //             },
          //         //           )),
          //         //     ),
          //         //     Container(
          //         //       margin: const EdgeInsets.all(8),
          //         //       child: ElevatedButton(
          //         //           onPressed: () async {
          //         //             await controller?.flipCamera();
          //         //             setState(() {});
          //         //           },
          //         //           child: FutureBuilder(
          //         //             future: controller?.getCameraInfo(),
          //         //             builder: (context, snapshot) {
          //         //               if (snapshot.data != null) {
          //         //                 return Text(
          //         //                     'Camera facing ${describeEnum(snapshot.data!)}');
          //         //               } else {
          //         //                 return const Text('loading');
          //         //               }
          //         //             },
          //         //           )),
          //         //     )
          //         //   ],
          //         // ),
          //         // Row(
          //         //   mainAxisAlignment: MainAxisAlignment.center,
          //         //   crossAxisAlignment: CrossAxisAlignment.center,
          //         //   children: <Widget>[
          //         //     Container(
          //         //       margin: const EdgeInsets.all(8),
          //         //       child: ElevatedButton(
          //         //         onPressed: () async {
          //         //           await controller?.pauseCamera();
          //         //         },
          //         //         child: const Text('pause',
          //         //             style: TextStyle(fontSize: 20)),
          //         //       ),
          //         //     ),
          //         //     Container(
          //         //       margin: const EdgeInsets.all(8),
          //         //       child: ElevatedButton(
          //         //         onPressed: () async {
          //         //           await controller?.resumeCamera();
          //         //         },
          //         //         child: const Text('resume',
          //         //             style: TextStyle(fontSize: 20)),
          //         //       ),
          //         //     )
          //         //   ],
          //         // ),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}



