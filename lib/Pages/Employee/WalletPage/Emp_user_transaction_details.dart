import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../widgets/TopBar.dart';

Emp_user_transaction_details({
  BuildContext? ctx,
}) {
  return showFlexibleBottomSheet(
      isExpand: false,
      isDismissible: false,
      initHeight: 0.45,
      maxHeight: 0.45,
      bottomSheetColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      context: ctx!,
      builder: (context, controller, offset) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetterObject) {
              var height = MediaQuery.of(context).size.height;
              var width = MediaQuery.of(context).size.width;
              return Container(
                width: width, //390,
                height: height * 0.45, // 547,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Bar("Kathryn Murphy", "assets/images/left.svg", Colors.black, Colors.black, (){Get.back();}),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0, right: 20),
                        child: Text(
                          // "\$${price}",
                          "Mar 03, 2023",
                          // "\$$price",
                          style: TextStyle(
                            color: Color(0xff9D9FAD),
                            fontFamily: "Outfit",
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                     Padding(
                       padding: const EdgeInsets.only(right: 35.0),
                       child: Column(
                         children: [
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
                           SizedBox(
                             height: Get.height * 0.02,
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
                             height: Get.height * 0.02,
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
                         ],
                       ),
                     )
                    ],
                  ),
                ),
              );
            });
      });
}