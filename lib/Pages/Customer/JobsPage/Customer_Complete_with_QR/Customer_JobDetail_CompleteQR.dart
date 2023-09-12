import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Models/chat_start_user_Model.dart';
import '../../../../Utils/api_urls.dart';
import '../../../../widgets/MyButton.dart';
import '../../../../widgets/ToastMessage.dart';
import '../../../../widgets/TopBar.dart';
import '../../../Employee/HomePage/EmpHomePage.dart';
import '../../HomePage/HomePage.dart';
import '../../MessagePage/MessageDetails.dart';
import '../Customer_QR_Scanner/QRCodeScanner.dart';
import 'package:http/http.dart' as http;

import '../Customer_Rating/Customer_JobDetails_Rating.dart';
import '../Payment_Sheet/Customer_Payment_Sheet.dart';

class Customer_JobsDetails_Completed_with_QR extends StatefulWidget {
  String? image;
  String? jobName;
  String? totalPrice;
  String? address;
  String? completeJobTime;
  String? description;
  String? profilePic;
  String? employee_profilePic;
  String? name;
  String? employee_name;
  String? status;
  String? customerId;
  String? employeeId;
  String? jobId;
  String? oneSignalId;
  Customer_JobsDetails_Completed_with_QR(
      {Key? key,
      this.image,
      this.oneSignalId,
      this.jobName,
      this.totalPrice,
      this.address,
      this.jobId,
      this.employeeId,
      this.completeJobTime,
      this.employee_name,
      this.employee_profilePic,
      this.description,
      this.customerId,
      this.profilePic,
      this.name,
      this.status})
      : super(key: key);

  @override
  State<Customer_JobsDetails_Completed_with_QR> createState() =>
      _Customer_JobsDetails_Completed_with_QRState();
}

class _Customer_JobsDetails_Completed_with_QRState
    extends State<Customer_JobsDetails_Completed_with_QR> {
  ChatStartUserModel chatStartUserModel = ChatStartUserModel();

  bool progress = false;
  bool isInAsyncCall = false;
  var getResult = 'QR Code Result';

  chatStartUser() async {
    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('usersCustomersId');
    empUsersCustomersId = empPrefs?.getString('empUsersCustomersId');
    print("usersCustomersId = $usersCustomersId");
    print("empUsersCustomersId = $empUsersCustomersId");

    // try {
    String apiUrl = userChatApiUrl;
    print("userChatApiUrl: $apiUrl");
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        "requestType": "startChat",
        "users_customers_id": usersCustomersId,
        "other_users_customers_id": widget.customerId,
      },
      headers: {'Accept': 'application/json'},
    );
    print('${response.statusCode}');
    print(response);
    print("responseStartChat: $response");
    print("status Code chat: ${response.statusCode}");
    print("in 200 chat");
    if (response.statusCode == 200) {
      final responseString = response.body;
      print("userChatResponse: ${responseString.toString()}");
      chatStartUserModel = chatStartUserModelFromJson(responseString);
      setState(() {});
    }
    ;
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: StandManAppBar1(
        title: "Job Details",
        bgcolor: Color(0xff2B65EC),
        titlecolor: Colors.white,
        iconcolor: Colors.white,
      ),
      backgroundColor: Color(0xff2B65EC),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                width: width,
                height: height * 0.9,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: height * 0.03,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network("${widget.image}")),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Container(
                                margin: EdgeInsets.only(top: 40, left: 2),
                                width: 73,
                                height: 19,
                                decoration: BoxDecoration(
                                  color: Color(0xffFFDACC),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    "${widget.status}",
                                    style: TextStyle(
                                      color: Color(0xffFF4700),
                                      fontFamily: "Outfit",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
// letterSpacing: -0.3,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${widget.jobName}",
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontFamily: "Outfit",
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                // letterSpacing: -0.3,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              "\$${widget.totalPrice}",
                              style: TextStyle(
                                color: Color(0xff2B65EC),
                                fontFamily: "Outfit",
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                // letterSpacing: -0.3,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/locationfill.svg',
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: width * 0.8,
                                  child: AutoSizeText(
                                    "${widget.address}",
                                    style: const TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontFamily: "Outfit",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                    maxLines: 2,
                                    minFontSize: 12,
                                    presetFontSizes: [12],
                                    maxFontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  "${widget.completeJobTime}",
                                  style: const TextStyle(
                                    color: Color.fromRGBO(167, 169, 183, 1),
                                    fontFamily: "Outfit",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${widget.description}",
                                // "Donec dictum tristique porta. Etiam convallis lorem lobortis nulla molestie, nec tincidunt ex ullamcorper. Quisque ultrices lobortis elit sed euismod. Duis in ultrices dolor, ac rhoncus odio. Suspendisse tempor sollicitudin dui sed lacinia. Nulla quis enim posuere, congue libero quis, commodo purus. Cras iaculis massa ut elit.",
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: "Outfit",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  // letterSpacing: -0.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Job Taken by",
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
                          height: height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image.network(
                                        "${widget.profilePic}",
                                        fit: BoxFit.fill,
                                      )),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${widget.name}",
                                        style: TextStyle(
                                          color: Color(0xff000000),
                                          fontFamily: "Outfit",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
// letterSpacing: -0.3,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Color(0xffFFDF00),
                                            size: 15,
                                          ),
                                          Text(
                                            '--',
                                            style: TextStyle(
                                              color: Color(0xff000000),
                                              fontFamily: "Outfit",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
// letterSpacing: -0.3,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            GestureDetector(
                                onTap: () async {
                                  await chatStartUser();
                                  Get.to(  () =>
                                    MessagesDetails(
                                      usersCustomersId: usersCustomersId,
                                      oneSignalID: widget.oneSignalId,
                                      other_users_customers_id:
                                          widget.employeeId,
                                      img:
                                          widget.employee_profilePic.toString(),
                                      name: widget.employee_name.toString(),
                                    ),
                                  );
                                },
                                child: smallButton(
                                    "Chat", Color(0xff2B65EC), context)),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        GestureDetector(
                            onTap: () async {
                              // DateTime buttonClickTime = DateTime.now();
                              Get.to(  () => CustomerWithoutExtraTime(
                                employeeId: widget.employeeId,
                                customerId: widget.customerId,
                                completeJobTime: widget.completeJobTime,
                                description: widget.description,
                                jobId: widget.jobId,
                                address: widget.address,
                                totalPrice: widget.totalPrice,
                                jobName: widget.jobName,
                              ));


                              // String? formattedTime = DateFormat('HH:mm').format(buttonClickTime); // Format the time
                              // print("buttonClickTime ${formattedTime}");
                              //  // scanQRCode();
                              // // await makePayment();
                              // // Navigator.push(
                              // //   context,
                              // //   MaterialPageRoute(builder: (context) => QRScannerPage()),
                              // // );
                              //  Get.to(
                              //
                              //      CustomerQRCodeScanner(
                              //    customerId: widget.customerId,
                              //    employeeId: widget.employeeId,
                              //    jobId: "${widget.jobId}",
                              //    jobName: widget.jobName,
                              //    buttonClickTime: "${formattedTime}",
                              //  ),
                              // Payment(
                              //   ctx: context
                              // ),
                              // );
                              // Future.delayed(const Duration(seconds: 3), () {
                              //   if(getResult == "${widget.employeeId}${widget.jobId}${widget.jobName}"){
                              //     toastSuccessMessage("Success scan QR Code.", Colors.red);
                              //     Payment(ctx: context);
                              //   } else {
                              //     toastFailedMessage("Failed to scan QR Code.", Colors.red);
                              //   }
                              // });
                            },
                            child: progress ? loadingBar(context): mainButton(
                                "Complete Job", Color(0xff2B65EC), context)),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 20),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.07,
                            // height: 48,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                // color: Color(0xff4DA0E6),
                                //   color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: Color(0xffC70000), width: 1),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 0,
                                      blurRadius: 15,
                                      offset: Offset(1, 10),
                                      color: Color.fromRGBO(7, 1, 87, 0.1)),
                                ]),
                            child: Center(
                              child: Text(
                                "Cancel Job",
                                style: TextStyle(
                                    fontFamily: "Outfit",
                                    fontSize: 14,
                                    color: Color(0xffC70000),
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomerWithoutExtraTime extends StatefulWidget {
  String? customerId;
  String? employeeId;
  String? jobId;
  String? jobName;
  String? totalPrice;
  String? completeJobTime;
  String? description;
  String? address;
   CustomerWithoutExtraTime({Key? key, this.address, this.description, this.completeJobTime, this.totalPrice,  this.customerId ,this.jobName, this.employeeId, this.jobId,}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomerWithoutExtraTimeState();
}

class _CustomerWithoutExtraTimeState extends State<CustomerWithoutExtraTime> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("CustomerId, jobId, jobName ${widget.customerId} ${widget.jobId} ${widget.jobName}");
    Future.delayed(const Duration(seconds: 4), () {
      print("resultssss ${result?.code}");
      if(result?.code == "${widget.customerId} ${widget.jobId} ${widget.jobName}" ){

        controller?.pauseCamera();

        checkJobStatus();
        // makePayment();

      } else if(result?.code != "${widget.customerId} ${widget.jobId} ${widget.jobName}" ){
        toastFailedMessage("Invalid Scan", Colors.red);
      }else {
        toastFailedMessage("Failed to Scan", Colors.red);
      }
    }
    );
  }

  bool progress = false;
  List checkJobsTime = [];

  checkJobStatus() async {
    setState(() {
      progress = true;
    });

    String apiUrl = checkJobsExtraTime;
    print("Url $apiUrl");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "users_customers_id": widget.customerId.toString(),
        "employee_users_customers_id": widget.employeeId.toString(),
        "jobs_id": widget.jobId,
      },
    );

    if (mounted) {
      setState(
            () {
          if (response.statusCode == 200) {
            var jsonResponse = json.decode(response.body);

            if (jsonResponse['status'] == "success") {
              // Display the success message
              // String successMessage = jsonResponse['message'];
              print("Success Message");
              // toastSuccessMessage(jsonResponse['message'], Colors.green);
              Get.to(  () => Customer_Rating(
                jobName: "${widget.jobName}",
                totalPrice: "${widget.totalPrice}",
                address: "${widget.address}",
                jobId: "${widget.jobId}",
                completeJobTime: "${widget.completeJobTime}",
                description: "${widget.description != null ? {widget.description} : ""}",
                status: "Completed",
                customerId: "${widget.customerId}",
                employeeId: "${widget.employeeId}",
              ));

              // If there's additional data that you need to process, you can do it here
              if (jsonResponse['data'] != null &&
                  jsonResponse['data'] is List<dynamic>) {
                checkJobsExtraTime = jsonResponse['data'];
                print("checkJobsExtraTime: $checkJobsExtraTime");
                progress = false;
              } else {
                print("Invalid 'data' value");
                progress = false;
              }
            } else if (jsonResponse['status'] == "error") {
              // Handle error status if needed
              // String errorMessage = jsonResponse['message'];
              print("Error Message");
              progress = false;
              DateTime buttonClickTime = DateTime.now();
              String? formattedTime = DateFormat('HH:mm')
                  .format(buttonClickTime); // Format the time
              print("buttonClickTime ${formattedTime}");
              Get.to(  () =>
                CustomerQRCodeScanner(
                  customerId: widget.customerId,
                  employeeId: widget.employeeId,
                  jobId: "${widget.jobId}",
                  jobName: widget.jobName,
                  buttonClickTime: "${formattedTime}",
                ),
              );
              // Get.to())}
            } else {
              print("Response Body :: ${response.body}");
              progress = false;
            }
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          //               'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
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
          //                   onPressed: () async {
          //                     await controller?.flipCamera();
          //                     setState(() {});
          //                   },
          //                   child: FutureBuilder(
          //                     future: controller?.getCameraInfo(),
          //                     builder: (context, snapshot) {
          //                       if (snapshot.data != null) {
          //                         return Text(
          //                             'Camera facing ${describeEnum(snapshot.data!)}');
          //                       } else {
          //                         return const Text('loading');
          //                       }
          //                     },
          //                   )),
          //             )
          //           ],
          //         ),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: <Widget>[
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
          //             Container(
          //               margin: const EdgeInsets.all(8),
          //               child: ElevatedButton(
          //                 onPressed: () async {
          //                   await controller?.resumeCamera();
          //                 },
          //                 child: const Text('resume',
          //                     style: TextStyle(fontSize: 20)),
          //               ),
          //             )
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
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

}