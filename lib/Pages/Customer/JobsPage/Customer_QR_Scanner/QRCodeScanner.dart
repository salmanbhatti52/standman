import 'dart:io';
import 'package:StandMan/widgets/MyButton.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../widgets/TopBar.dart';
import '../../HomePage/Paymeny_details.dart';

class CustomerQRCodeScanner extends StatefulWidget {
  String qrresult;

  CustomerQRCodeScanner({Key? key, required this.qrresult}) : super(key: key);

  @override
  State<CustomerQRCodeScanner> createState() => _CustomerQRCodeScannerState();
}

class _CustomerQRCodeScannerState extends State<CustomerQRCodeScanner> {
  var getResult = 'QR Code Result';

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
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          mainButton(widget.qrresult, Color(0xff2B65EC), context),
        ],
      )),
    );
  }
}

// import 'package:StandMan/Pages/Customer/HomePage/HomePage.dart';
// import 'package:bottom_sheet/bottom_sheet.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// // import '../../../Models/jobs_create_Model.dart';
// // import '../../../Models/users_profilet_model.dart';
// // import '../../../Utils/api_urls.dart';
// // import '../../../widgets/MyButton.dart';
// // import '../../../widgets/ToastMessage.dart';
// // import '../../../widgets/TopBar.dart';
// // import '../../Bottombar.dart';
// import 'package:http/http.dart' as http;

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
                  GestureDetector(
                    onTap: () {
                      stateSetterObject(() {
                        // _saveData();
                        _selected = 1;
                      });
                    },
                    child: Container(
                      width: width * 0.9, // 350,
                      height: height * 0.09, // 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: _selected == 1
                                ? Color(0xffFF9900)
                                : Color(0xffF3F3F3),
                            width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffF2F4F9),
                              ),
                              child: Center(
                                  child: SvgPicture.asset(
                                'assets/images/card.svg',
                              )),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Mastercard",
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontFamily: "Outfit",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    // letterSpacing: -0.3,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                const Text(
                                  "6895 3526 8456 ****",
                                  style: TextStyle(
                                    color: Color(0xffA7A9B7),
                                    fontFamily: "Outfit",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    // letterSpacing: -0.3,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: width * 0.2,
                            ),
                            SvgPicture.asset(
                              _selected == 1
                                  ? "assets/images/Ring.svg"
                                  : "assets/images/Ring2.svg",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      stateSetterObject(() {
                        // _saveData();
                        _selected = 2;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        width: width * 0.9, // 350,
                        height: height * 0.09, // 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: _selected == 2
                                  ? Color(0xffFF9900)
                                  : Color(0xffF3F3F3),
                              width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xffF2F4F9),
                                ),
                                child: Center(
                                    child: SvgPicture.asset(
                                  'assets/images/visa.svg',
                                )),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Visa Pay",
                                    style: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontFamily: "Outfit",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      // letterSpacing: -0.3,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  const Text(
                                    "6895 3526 8456 ****",
                                    style: TextStyle(
                                      color: Color(0xffA7A9B7),
                                      fontFamily: "Outfit",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      // letterSpacing: -0.3,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: width * 0.2,
                              ),
                              SvgPicture.asset(
                                _selected == 2
                                    ? "assets/images/Ring.svg"
                                    : "assets/images/Ring2.svg",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: width * 0.9, // 350,
                      height: height * 0.06, // 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Color(0xffF3F3F3), width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // SvgPicture.asset(
                          //   'assets/images/Addc.svg',
                          // ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(0, 53, 136, 1),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Add New Payment Method",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: "Outfit",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              // letterSpacing: -0.3,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
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
