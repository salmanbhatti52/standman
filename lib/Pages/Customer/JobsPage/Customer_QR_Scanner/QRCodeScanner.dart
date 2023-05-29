import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:StandMan/widgets/MyButton.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../../widgets/TopBar.dart';
import '../../HomePage/Paymeny_details.dart';
import 'package:http/http.dart' as http;

class CustomerQRCodeScanner extends StatefulWidget {

  CustomerQRCodeScanner({Key? key,}) : super(key: key);

  @override
  State<CustomerQRCodeScanner> createState() => _CustomerQRCodeScannerState();
}

class _CustomerQRCodeScannerState extends State<CustomerQRCodeScanner> {

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

// In order to get hot reload to work we need to pause the camera if the platform
// is android, or resume the camera if the platform is iOS.
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
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text(
                        'Barcode Data: ${result!.code}')
                  else
                    const Text('Scan a code'),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: <Widget>[
                  //     Container(
                  //       margin: const EdgeInsets.all(8),
                  //       child: ElevatedButton(
                  //           onPressed: () async {
                  //             await controller?.toggleFlash();
                  //             setState(() {});
                  //           },
                  //           child: FutureBuilder(
                  //             future: controller?.getFlashStatus(),
                  //             builder: (context, snapshot) {
                  //               return Text('Flash: ${snapshot.data}');
                  //             },
                  //           )),
                  //     ),
                  //     Container(
                  //       margin: const EdgeInsets.all(8),
                  //       child: ElevatedButton(
                  //           onPressed: () async {
                  //             await controller?.flipCamera();
                  //             setState(() {});
                  //           },
                  //           child: FutureBuilder(
                  //             future: controller?.getCameraInfo(),
                  //             builder: (context, snapshot) {
                  //               if (snapshot.data != null) {
                  //                 return Text(
                  //                     'Camera facing ${describeEnum(snapshot.data!)}');
                  //               } else {
                  //                 return const Text('loading');
                  //               }
                  //             },
                  //           )),
                  //     )
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: <Widget>[
                  //     Container(
                  //       margin: const EdgeInsets.all(8),
                  //       child: ElevatedButton(
                  //         onPressed: () async {
                  //           await controller?.pauseCamera();
                  //         },
                  //         child: const Text('pause',
                  //             style: TextStyle(fontSize: 20)),
                  //       ),
                  //     ),
                  //     Container(
                  //       margin: const EdgeInsets.all(8),
                  //       child: ElevatedButton(
                  //         onPressed: () async {
                  //           await controller?.resumeCamera();
                  //         },
                  //         child: const Text('resume',
                  //             style: TextStyle(fontSize: 20)),
                  //       ),
                  //     )
                  //   ],
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


Payment({
  BuildContext? ctx,
}) {
  int _selected = 0;
  return showFlexibleBottomSheet(
      isExpand: false,
      isDismissible: false,
      initHeight: 0.9,
      maxHeight: 0.9,
      bottomSheetColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.9),
      context: ctx!,
      builder: (context, controller, offset) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetterObject) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return Container(
            width: width, //390,
            height: height * 0.88, // 547,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Column(
                children: [
                  paymentBar(
                    "assets/images/left.svg",
                    Colors.black,
                    "Payment",
                    Colors.black,
                    "assets/images/info.svg",
                    () {
                      Get.back();
                    },
                    () {
                      Payment_Details(ctx: context);
                    },
                  ),
                  SizedBox(
                    height: Get.height * 0.035,
                  ),
                  Text(
                    // "\$${price}",
                    "\$47.11",
                    // "\$$price",
                    style: TextStyle(
                      color: Color(0xff2B65EC),
                      fontFamily: "Outfit",
                      fontWeight: FontWeight.w600,
                      fontSize: 32,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Previous Amount",
                        style: TextStyle(
                          color: Color(0xff000000),
                          fontFamily: "Outfit",
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.12,
                      ),
                      Text(
                        "\$21",
                        // "\$$amount",
                        // '\$$discountPrice',
                        style: TextStyle(
                          color: Color(0xff000000),
                          fontFamily: "Outfit",
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Extra Amount",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontFamily: "Outfit",
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.12,
                        ),
                        Text(
                          "\$15.75",
                          // "\$$chargers",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontFamily: "Outfit",
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Service Charges",
                        style: TextStyle(
                          color: Color(0xff000000),
                          fontFamily: "Outfit",
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.10,
                      ),
                      Text(
                        "\$7.50",
                        // "\$$amount",
                        // '\$$discountPrice',
                        style: TextStyle(
                          color: Color(0xff000000),
                          fontFamily: "Outfit",
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Tax",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontFamily: "Outfit",
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.3,
                        ),
                        Text(
                          "\$2.86",
                          // "\$$amount",
                          // '\$$discountPrice',
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontFamily: "Outfit",
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Booked time",
                        style: TextStyle(
                          color: Color(0xffC70000),
                          fontFamily: "Outfit",
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.15,
                      ),
                      Text(
                        "12:00-13:00",
                        // "\$$chargers",
                        style: TextStyle(
                          color: Color(0xffC70000),
                          fontFamily: "Outfit",
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Booked Closed",
                        style: TextStyle(
                          color: Color(0xffC70000),
                          fontFamily: "Outfit",
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.23,
                      ),
                      Text(
                        "13:45",
                        // "\$$amount",
                        // '\$$discountPrice',
                        style: TextStyle(
                          color: Color(0xffC70000),
                          fontFamily: "Outfit",
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Extra time",
                        style: TextStyle(
                          color: Color(0xffC70000),
                          fontFamily: "Outfit",
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.34,
                      ),
                      Text(
                        "45",
                        // "\$$amount",
                        // '\$$discountPrice',
                        style: TextStyle(
                          color: Color(0xffC70000),
                          fontFamily: "Outfit",
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.012,
                  ),
                  Text(
                    "Base rate - \$21/hour (0.35¢/minute)",
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontFamily: "Outfit",
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Text(
                      'Service fee - 10% from the "Customer" and "StandMan"',
                      style: TextStyle(
                        color: Color(0xff000000),
                        fontFamily: "Outfit",
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Text(
                    "Tax - 13%",
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontFamily: "Outfit",
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.023,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Choose payment method",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: "Outfit",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          // letterSpacing: -0.3,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     stateSetterObject(() {
                  //       // _saveData();
                  //       _selected = 1;
                  //     });
                  //   },
                  //   child: Container(
                  //     width: width * 0.9, // 350,
                  //     height: height * 0.09, // 70,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(12),
                  //       border: Border.all(
                  //           color: _selected == 1
                  //               ? Color(0xffFF9900)
                  //               : Color(0xffF3F3F3),
                  //           width: 1),
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Container(
                  //             width: 52,
                  //             height: 52,
                  //             decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(10),
                  //               color: Color(0xffF2F4F9),
                  //             ),
                  //             child: Center(
                  //                 child: SvgPicture.asset(
                  //               'assets/images/card.svg',
                  //             )),
                  //           ),
                  //           Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               const Text(
                  //                 "Mastercard",
                  //                 style: TextStyle(
                  //                   color: Color.fromRGBO(0, 0, 0, 1),
                  //                   fontFamily: "Outfit",
                  //                   fontSize: 14,
                  //                   fontWeight: FontWeight.w500,
                  //                   // letterSpacing: -0.3,
                  //                 ),
                  //                 textAlign: TextAlign.left,
                  //               ),
                  //               const Text(
                  //                 "6895 3526 8456 ****",
                  //                 style: TextStyle(
                  //                   color: Color(0xffA7A9B7),
                  //                   fontFamily: "Outfit",
                  //                   fontSize: 14,
                  //                   fontWeight: FontWeight.w300,
                  //                   // letterSpacing: -0.3,
                  //                 ),
                  //                 textAlign: TextAlign.left,
                  //               ),
                  //             ],
                  //           ),
                  //           SizedBox(
                  //             width: width * 0.2,
                  //           ),
                  //           SvgPicture.asset(
                  //             _selected == 1
                  //                 ? "assets/images/Ring.svg"
                  //                 : "assets/images/Ring2.svg",
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     stateSetterObject(() {
                  //       // _saveData();
                  //       _selected = 2;
                  //     });
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
                  //     child: Container(
                  //       width: width * 0.9, // 350,
                  //       height: height * 0.09, // 70,
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(12),
                  //         border: Border.all(
                  //             color: _selected == 2
                  //                 ? Color(0xffFF9900)
                  //                 : Color(0xffF3F3F3),
                  //             width: 1),
                  //       ),
                  //       child: Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Container(
                  //               width: 52,
                  //               height: 52,
                  //               decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(10),
                  //                 color: Color(0xffF2F4F9),
                  //               ),
                  //               child: Center(
                  //                   child: SvgPicture.asset(
                  //                 'assets/images/visa.svg',
                  //               )),
                  //             ),
                  //             Column(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 const Text(
                  //                   "Visa Pay",
                  //                   style: TextStyle(
                  //                     color: Color.fromRGBO(0, 0, 0, 1),
                  //                     fontFamily: "Outfit",
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.w500,
                  //                     // letterSpacing: -0.3,
                  //                   ),
                  //                   textAlign: TextAlign.left,
                  //                 ),
                  //                 const Text(
                  //                   "6895 3526 8456 ****",
                  //                   style: TextStyle(
                  //                     color: Color(0xffA7A9B7),
                  //                     fontFamily: "Outfit",
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.w300,
                  //                     // letterSpacing: -0.3,
                  //                   ),
                  //                   textAlign: TextAlign.left,
                  //                 ),
                  //               ],
                  //             ),
                  //             SizedBox(
                  //               width: width * 0.2,
                  //             ),
                  //             SvgPicture.asset(
                  //               _selected == 2
                  //                   ? "assets/images/Ring.svg"
                  //                   : "assets/images/Ring2.svg",
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: Container(
                  //     width: width * 0.9, // 350,
                  //     height: height * 0.06, // 70,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(12),
                  //       border: Border.all(color: Color(0xffF3F3F3), width: 1),
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         // SvgPicture.asset(
                  //         //   'assets/images/Addc.svg',
                  //         // ),
                  //         Padding(
                  //           padding:
                  //               const EdgeInsets.symmetric(horizontal: 10.0),
                  //           child: Container(
                  //             width: 20,
                  //             height: 20,
                  //             decoration: BoxDecoration(
                  //               shape: BoxShape.circle,
                  //               color: Color.fromRGBO(0, 53, 136, 1),
                  //             ),
                  //             child: Center(
                  //               child: Icon(
                  //                 Icons.add,
                  //                 color: Colors.white,
                  //                 size: 15,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         Text(
                  //           "Add New Payment Method",
                  //           style: TextStyle(
                  //             color: Color.fromRGBO(0, 0, 0, 1),
                  //             fontFamily: "Outfit",
                  //             fontSize: 14,
                  //             fontWeight: FontWeight.w500,
                  //             // letterSpacing: -0.3,
                  //           ),
                  //           textAlign: TextAlign.left,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  GestureDetector(onTap: ()async {
                    // final paymentMethod = await Stripe.instance.createPaymentMethod(
                    //     params: const PaymentMethodParams.card(
                    //         paymentMethodData: PaymentMethodData()));
                    await makePayment();
                  },child: mainButton("Pay With Stripe", Color(0xffF2F4F9), context)),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  GestureDetector(onTap: (){
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
                              width: width,//350,
                              height:  537,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFF),
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: height * 0.02,),
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
                                    width: width * 0.6 , //241,
                                    height: height * 0.095, // 70,
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
                                        const Text(
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
                                        const Text(
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
                                            const Text(
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
                                  SizedBox(height: height * 0.02,),
                                  mainButton("Add Ratings", Color(0xff2B65EC), context),
                                ],
                              ),
                            ),
                            Positioned(
                                top: -48,
                                child: Container(
                                  width: width , //106,
                                  height: height * 0.13, //106,
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
                  }
                      ,child: mainButton("Pay", Color(0xff2B65EC), context))
                ],
              ),
            ),
          );
        });
      });

}

Map<String, dynamic>? paymentIntentData;
Future<void> makePayment() async {
  try {
    paymentIntentData =
    await createPaymentIntent('20', 'USD'); //json.decode(response.body);
    // print('Response body==>${response.body.toString()}');
    await Stripe.instance
        .initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            setupIntentClientSecret: 'Your Secret Key',
            paymentIntentClientSecret:
            paymentIntentData!['client_secret'],
            //applePay: PaymentSheetApplePay.,
            //googlePay: true,
            //testEnv: true,
            customFlow: true,
            style: ThemeMode.dark,
            // merchantCountryCode: 'US',
            merchantDisplayName: 'Kashif'))
        .then((value) {});

    ///now finally display payment sheeet
    displayPaymentSheet();
  } catch (e, s) {
    print('Payment exception:$e$s');
  }
}

displayPaymentSheet() async {
  try {
    await Stripe.instance
        .presentPaymentSheet(
      //       parameters: PresentPaymentSheetParameters(
      // clientSecret: paymentIntentData!['client_secret'],
      // confirmPayment: true,
      // )
    )
        .then((newValue) {
      print('payment intent' + paymentIntentData!['id'].toString());
      print(
          'payment intent' + paymentIntentData!['client_secret'].toString());
      print('payment intent' + paymentIntentData!['amount'].toString());
      print('payment intent' + paymentIntentData.toString());
      //orderPlaceApi(paymentIntentData!['id'].toString());
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(const SnackBar(content: Text("paid successfully")));

      paymentIntentData = null;
    }).onError((error, stackTrace) {
      print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
    });
  } on StripeException catch (e) {
    print('Exception/DISPLAYPAYMENTSHEET==> $e');
    // showDialog(
    //     context: context,
    //     builder: (_) => const AlertDialog(
    //       content: Text("Cancelled "),
    //     ));
  } catch (e) {
    print('$e');
  }
}

//  Future<Map<String, dynamic>>
createPaymentIntent(String amount, String currency) async {
  try {
    Map<String, dynamic> body = {
      'amount': calculateAmount('20'),
      'currency': currency,
      'payment_method_types[]': 'card',
    };
    print(body);
    var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer ' + 'your token',
          'Content-Type': 'application/x-www-form-urlencoded'
        });
    print('Create Intent reponse ===> ${response.body.toString()}');
    return jsonDecode(response.body);
  } catch (err) {
    print('err charging user: ${err.toString()}');
  }
}

calculateAmount(String amount) {
  final a = (int.parse(amount)) * 100;
  return a.toString();
}
