import 'dart:convert';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
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
import '../../../../widgets/TopBar.dart';
import '../../../Employee/HomePage/EmpHomePage.dart';
import '../../HomePage/HomePage.dart';
import '../../MessagePage/MessageDetails.dart';
import '../Customer_QR_Scanner/QRCodeScanner.dart';
import 'package:http/http.dart' as http;

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
   Customer_JobsDetails_Completed_with_QR({Key? key, this.image,
     this.jobName, this.totalPrice, this.address, this.jobId, this.employeeId,
     this.completeJobTime,  this.employee_name, this.employee_profilePic, this.description, this.customerId,
     this.profilePic, this.name, this.status}) : super(key: key);

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
      };
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
                                  child: ClipRRect(borderRadius: BorderRadius.circular(25),child: Image.network("${widget.profilePic}", fit: BoxFit.fill,)),
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
                                    Get.to(MessagesDetails(
                                      usersCustomersId: usersCustomersId,
                                      other_users_customers_id: widget.employeeId,
                                      img: widget.employee_profilePic.toString(),
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
                            onTap: ()  async {

                              DateTime buttonClickTime = DateTime.now();
                              String? formattedTime = DateFormat('HH:mm').format(buttonClickTime); // Format the time
                              print("buttonClickTime ${formattedTime}");
                               // scanQRCode();
                              // await makePayment();
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => QRScannerPage()),
                              // );
                               Get.to(

                                   CustomerQRCodeScanner(
                                 customerId: widget.customerId,
                                 employeeId: widget.employeeId,
                                 jobId: "${widget.jobId}",
                                 jobName: widget.jobName,
                                 buttonClickTime: "${formattedTime}",
                               ),
                                 // Payment(
                                 //   ctx: context
                                 // ),
                               );
                               // Future.delayed(const Duration(seconds: 3), () {
                               //   if(getResult == "${widget.employeeId}${widget.jobId}${widget.jobName}"){
                               //     toastSuccessMessage("Success scan QR Code.", Colors.red);
                               //     Payment(ctx: context);
                               //   } else {
                               //     toastFailedMessage("Failed to scan QR Code.", Colors.red);
                               //   }
                               // });
                            },
                            child: mainButton("Complete Job using QR",
                                Color(0xff2B65EC), context)),
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

class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (BuildContext context, Widget? child) { // Update the parameter type to Widget?
              return Positioned(
                top: MediaQuery.of(context).size.height * 0.5 +
                    (_animation.value * (MediaQuery.of(context).size.height * 0.15)),
                left: MediaQuery.of(context).size.height * 0.09 ,
                right: MediaQuery.of(context).size.height * 0.09 ,
                child: Container(
                  height: 2,
                  color: Colors.red,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) {
      // Handle the scanned QR code data here
      print(scanData);
    });
  }
}






