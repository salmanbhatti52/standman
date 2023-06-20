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
        setState(() {
          progress = false;
        });
      }
    // } catch (e) {
    //   print('Error in jobsExtraAmountWidget: ${e.toString()}');
    // }

    Future.delayed(const Duration(seconds: 2), () {
      Payment(
        ctx: context,
        Price: jobsExtraAmount.message?.payment,
        PreviousAmount: jobsExtraAmount.message?.previousAmount,
        ExtraAmount: "${jobsExtraAmount.message?.extraAmount}",
        ServiceCharges: jobsExtraAmount.message?.serviceCharges.toString(),
        Tax: "${jobsExtraAmount.message?.tax}",
        BookedTime: jobsExtraAmount.message?.bookedTime,
        BookedClosed: jobsExtraAmount.message?.bookedClose,
        ExtraTime: jobsExtraAmount.message?.extraTime.toString(),
        userCustomerId: jobsExtraAmount.message?.usersCustomersId.toString(),
        userEmployeeId: jobsExtraAmount.message?.employeeUsersCustomersId.toString(),
          jobId: jobsExtraAmount.message?.jobsId.toString(),
      );
    });
  }

  Map<String, dynamic>? paymentIntent;

  calculateAmount(String amount) {
    amount = "${widget.jobId}";
    final calculatedAmout = (int.parse(amount));
    return calculatedAmout.toString();
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer sk_test_51MV6RqJ1o3iGht9r8pNwA1f92pJOs9vweMCsMA6HJuTQtCiy0HTlPIAXFiI57ffEiu7EmmmfU0IHbjBGw4k5IliP0017I4MuHw',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  displayPaymentSheet() async {

    try {
      await Stripe.instance.presentPaymentSheet(
      ).then((value){
        // showDialog(
        //     context: ctx!,
        //     builder: (_) => AlertDialog(
        //       content: Column(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           Row(
        //             children: const [
        //               Icon(Icons.check_circle, color: Colors.green,),
        //               Text("Payment Successfull"),
        //             ],
        //           ),
        //         ],
        //       ),
        //     ));
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: Get.width,//350,
                  height:  537,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFF),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: Get.height * 0.02,),
                      const Text(
                        "Job Completed, Amount Paid",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: "Outfit",
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          // letterSpacing: -0.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        width: Get.width * 0.6 , //241,
                        height: Get.height * 0.095, // 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xffF3F3F3),
                          border: Border.all(color: Color(0xffF3F3F3), width: 1),
                        ),
                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 5,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '\$',
                                      style: TextStyle(
                                        color: Color(0xff21335B),
                                        fontFamily: "Outfit",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        // letterSpacing: -0.3,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      // jobsCustomersCompleteModel.message!.job!.price.toString(),
                                      ' 22.00',
                                      style: TextStyle(
                                        color: Color(0xff2B65EC),
                                        fontFamily: "Outfit",
                                        fontSize: 36,
                                        fontWeight: FontWeight.w600,
                                        // letterSpacing: -0.3,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Text(
                                  'you paid',
                                  style: TextStyle(
                                    color: Color(0xffA7A9B7),
                                    fontFamily: "Outfit",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    // letterSpacing: -0.3,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "From",
                              style: TextStyle(
                                color: Color(0xff2B65EC),
                                fontFamily: "Outfit",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                // letterSpacing: -0.3,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              // "${jobsCustomersCompleteModel.message!.customer!.firstName} ${jobsCustomersCompleteModel.message!.customer!.lastName}",
                              "Beby Jovanca",
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontFamily: "Outfit",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                // letterSpacing: -0.3,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Color(0xffF3F3F3),
                        height: 1,
                        indent: 40,
                        endIndent: 40,
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "To",
                              style: TextStyle(
                                color: Color(0xff2B65EC),
                                fontFamily: "Outfit",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                // letterSpacing: -0.3,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              // "${jobsCustomersCompleteModel.message!.employee!.firstName} ${jobsCustomersCompleteModel.message!.employee!.lastName}",
                              "Annette Black",
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontFamily: "Outfit",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                // letterSpacing: -0.3,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Color(0xffF3F3F3),
                        height: 1,
                        indent: 40,
                        endIndent: 40,
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Date",
                              style: TextStyle(
                                color: Color(0xff2B65EC),
                                fontFamily: "Outfit",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                // letterSpacing: -0.3,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  // "${jobsCustomersCompleteModel.message!.job!.startDate}",
                                  "24 Jul 2020",
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontFamily: "Outfit",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    // letterSpacing: -0.3,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                                Text(
                                  // "${jobsCustomersCompleteModel.message!.job!.startTime}",
                                  '15:30',
                                  style: TextStyle(
                                    color: Color(0xffA7A9B7),
                                    fontFamily: "Outfit",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    // letterSpacing: -0.3,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02,),
                      GestureDetector(onTap: (){
                        // Get.to(Customer_Rating(
                        //   jobName: "${jobsCustomersCompleteModel.message?.job?.name}",
                        //   totalPrice:  "${jobsCustomersCompleteModel.message?.job?.totalPrice}",
                        //   address:  "${jobsCustomersCompleteModel.message?.job?.location}",
                        //   jobId:  "${jobsCustomersCompleteModel.message?.job?.jobsId}",
                        //   completeJobTime:  "${jobsCustomersCompleteModel.message?.job?.dateAdded}",
                        //   description:  "${jobsCustomersCompleteModel.message?.job?.description}",
                        //   status:  "${jobsCustomersCompleteModel.message?.job?.status}",
                        //   customerId: "${jobsCustomersCompleteModel.message?.customer?.usersCustomersId}",
                        //   employeeId: "${jobsCustomersCompleteModel.message?.employee?.usersCustomersId}",
                        // ));
                      },child: mainButton("Add Ratings", Color(0xff2B65EC), context)),
                    ],
                  ),
                ),
                Positioned(
                    top: -48,
                    child: Container(
                      width: Get.width , //106,
                      height: Get.height * 0.13, //106,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffFF9900),
                      ),
                      child: Icon(
                        Icons.check,
                        size: 40,
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
          ),
        );
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntent = null;

      }).onError((error, stackTrace){
        print('Error is:--->$error $stackTrace');
      });


    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
      print('$e');
    }
  }

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent('10', 'USD');
      //Payment Sheet
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent?['client_secret'],
              // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
              // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
              style: ThemeMode.dark,
              merchantDisplayName: 'Hammad')).then((value){
      });


      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("CustomerId, jobId, jobName ${widget.customerId} ${widget.jobId} ${widget.jobName}");
      Future.delayed(const Duration(seconds: 5), ()  {
        print("resultssss ${result?.code}");
      if(result?.code == "${widget.customerId} ${widget.jobId} ${widget.jobName}" ){

        controller?.pauseCamera();

        jobsExtraAmountWidget();
        // makePayment();

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
        bgcolor: Color(0xff000000),
        titlecolor: Colors.white,
        iconcolor: Colors.white,
      ),
      // backgroundColor: Colors.white,
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
          //               'Scanned Data: ${result!.code}', style: TextStyle(
          //             color: Color(0xff000000),
          //             fontFamily: "Outfit",
          //             fontSize: 12,
          //             fontWeight: FontWeight.w400,
          //           ),)
          //         else
          //           const Text('Scan a code'),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: <Widget>[
          //             Container(
          //               margin: const EdgeInsets.all(8),
          //               child: ElevatedButton(
          //                   onPressed: () async {
          //                     await controller?.toggleFlash();
          //                     setState(() {});
          //                   },
          //                   child: FutureBuilder(
          //                     future: controller?.getFlashStatus(),
          //                     builder: (context, snapshot) {
          //                       return Text('Flash: ${snapshot.data}');
          //                     },
          //                   )),
          //             ),
          //             Container(
          //               margin: const EdgeInsets.all(8),
          //               child: ElevatedButton(
          //                 onPressed: () async {
          //                   await controller?.pauseCamera();
          //                 },
          //                 child: const Text('pause',
          //                     style: TextStyle(fontSize: 20)),
          //               ),
          //             ),
          //             // Container(
          //             //   margin: const EdgeInsets.all(8),
          //             //   child: ElevatedButton(
          //             //       onPressed: () async {
          //             //         await controller?.flipCamera();
          //             //         setState(() {});
          //             //       },
          //             //       child: FutureBuilder(
          //             //         future: controller?.getCameraInfo(),
          //             //         builder: (context, snapshot) {
          //             //           if (snapshot.data != null) {
          //             //             return Text(
          //             //                 'Camera facing ${describeEnum(snapshot.data!)}');
          //             //           } else {
          //             //             return const Text('loading');
          //             //           }
          //             //         },
          //             //       )),
          //             // )
          //           ],
          //         ),
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



