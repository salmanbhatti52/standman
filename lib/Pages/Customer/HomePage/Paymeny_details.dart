import 'package:StandMan/Pages/Customer/HomePage/HomePage.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Models/jobs_create_Model.dart';
import '../../../Models/users_profilet_model.dart';
import '../../../Utils/api_urls.dart';
import '../../../widgets/MyButton.dart';
import '../../../widgets/ToastMessage.dart';
import '../../../widgets/TopBar.dart';
import '../../Bottombar.dart';
import 'package:http/http.dart' as http;

Payment_Details({
  BuildContext? ctx,
}) {
  return showFlexibleBottomSheet(
      isExpand: false,
      isDismissible: false,
      initHeight: 0.7,
      maxHeight: 0.7,
      bottomSheetColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.1),
      context: ctx!,
      builder: (context, controller, offset) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetterObject) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return Container(
            width: width, //390,
            height: height * 0.8, // 547,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 30, right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Bar("text", "assets/images/left.svg", Colors.black,
                      Colors.white, () {
                    Get.back();
                  }),
                  SizedBox(height: Get.height * 0.02,),
                  Container(
                    height: Get.height * 0.6,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            "- Customer books for less than an hour(60min) they still should be changed for (full 1hour-60min).",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontFamily: "Outfit",
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(height: Get.height * 0.01,),
                          Text(
                            "Example: Customer books (13:00-13:45) '45min', the customer will be charged for (full 1hour - 60min) because it's the minimum we charge, based on terms and regulations.",
                            style: TextStyle(
                              color: Color(0xffC70000),
                              fontFamily: "Outfit",
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(height: Get.height * 0.02,),
                          Text(
                            "- Customer books for more than an hour(60min) they will be charged for every minute after 1st hour(60min).",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontFamily: "Outfit",
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(height: Get.height * 0.01,),
                          Text(
                            'Example: Customer books (12:00-13.35) "95min", the Customer will be charged for (95min).',
                            style: TextStyle(
                              color: Color(0xffC70000),
                              fontFamily: "Outfit",
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(height: Get.height * 0.02,),
                          Text(
                            "- Customer books for more than an hour(60min) but they come later than booked time. They will be charged for the exact time until an order is complete by QR-code scanning or any other method.",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontFamily: "Outfit",
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(height: Get.height * 0.01,),
                          Text(
                            'Example: Customer books (12:00-13:45) "105min", but actually order is completed at (14:10)-additional "25min", the Customer will be charged for (130min).',
                            style: TextStyle(
                              color: Color(0xffC70000),
                              fontFamily: "Outfit",
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(height: Get.height * 0.02,),
                          Text(
                            '- Customer books for more than an hour(60min) but they come earlier than booked time. They will be charged for the exact time until an order is complete by QR-code scanning or any other method.NOTE: 1st hour(60min) RULE still applies, if a customer came earlier than 1st hour(60min) still full hour(60min) will be charged.',
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontFamily: "Outfit",
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(height: Get.height * 0.01,),
                          Text(
                            'Example: Customer books (12:00-13:15) "75min", but actually order is completed at (12:55)"55min", the Customer will be charged for (60min).',
                            style: TextStyle(
                              color: Color(0xffC70000),
                              fontFamily: "Outfit",
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(height: Get.height * 0.03,),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
      });
}
