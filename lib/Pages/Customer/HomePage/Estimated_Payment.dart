import 'package:StandMan/Pages/Customer/HomePage/HomePage.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Models/jobs_create_Model.dart';
import '../../../Utils/api_urls.dart';
import '../../../widgets/MyButton.dart';
import '../../../widgets/ToastMessage.dart';
import '../../../widgets/TopBar.dart';
import '../../Bottombar.dart';
import 'package:http/http.dart' as http;
import 'Paymeny_details.dart';

Estimated_PaymentMethod({
    String? img,
  String? jobName,
  String? date,
  String? long,
  String? lat,
  String? time,
  String? endtime,
  String? describe,
  BuildContext? ctx,
  String? price,
  String? amount,
  String? chargers,
  String? tax,
  String? address
}) {
  int _selected = 0;
  bool isInAsyncCall = false;

  JobsCreateModel jobsCreateModel = JobsCreateModel();

  jobCreated() async {
    print("working");
    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('usersCustomersId');
    print("userId in Prefs is = $usersCustomersId");

    String apiUrl = jobsCreateModelApiUrl;
    print("working");

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "users_customers_id": usersCustomersId,
        "name": jobName,
        "location": address,
        "longitude": long,
        "lattitude": lat,
        "start_date": date,
        "start_time": time,
        "end_time": endtime,
        "description": describe,
        "price": amount,
        "service_charges": chargers,
        "tax": tax,
        "payment_gateways_name": "GPay",
        "payment_status": "Paid",
        "image": img,
      },
    );
    final responseString = response.body;
    print("jobsCreateModelApi: ${response.body}");
    print("status Code jobsCreateModel: ${response.statusCode}");
    print("in 200 jobsCreate");
    if (response.statusCode == 200) {
      jobsCreateModel = jobsCreateModelFromJson(responseString);
      // setState(() {});
      print('jobsCreateModel status: ${jobsCreateModel.status}');
    }
  }


  return showFlexibleBottomSheet(
      isExpand: false,
      initHeight: 0.44,
      maxHeight: 0.44,
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
            height: height * 0.5, // 547,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    paymentBar(
                      "assets/images/left.svg",
                      Colors.black,
                      "Estimated Payment",
                      Colors.black,
                      "assets/images/info.svg",
                      () {
                        Get.back();
                      },
                      () {
                        Payment_Details(ctx: context);
                      },
                    ),
                    SizedBox(height: Get.height * 0.02,),
                    Text(
                      "\$${price}",
                      // "\$22.00",
                      // "\$$price",
                      style: TextStyle(
                        color: Color(0xff2B65EC),
                        fontFamily: "Outfit",
                        fontWeight: FontWeight.w600,
                        fontSize: 32,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Amount",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontFamily: "Outfit",
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: Get.width * 0.2,),
                        Text(
                          // "\$20",
                          "\$$amount",
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
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 3.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Text(
                    //         "Service Charges",
                    //         style: TextStyle(
                    //           color: Color(0xff000000),
                    //           fontFamily: "Outfit",
                    //           fontWeight: FontWeight.w300,
                    //           fontSize: 14,
                    //         ),
                    //       ),
                    //       SizedBox(width: Get.width * 0.1,),
                    //       Text(
                    //         // "\$2",
                    //         "\$$chargers",
                    //         style: TextStyle(
                    //           color: Color(0xff000000),
                    //           fontFamily: "Outfit",
                    //           fontWeight: FontWeight.w300,
                    //           fontSize: 14,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Row(
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
                        SizedBox(width: Get.width * 0.28,),
                        Text(
                          // "\$20",
                          "\$$tax",
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
                    SizedBox(height: Get.height * 0.012,),
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
                    SizedBox(height: Get.height * 0.02,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: GestureDetector(
                          onTap: () async {
                            print("users_customers_id: ${usersCustomersId}");
                            print("jobName: ${jobName}");
                            print("location: ${address}");
                            print("longitude: ${long}");
                            print("lattitude: ${lat}");
                            print("start_date: ${date}");
                            print("start_time: ${time}");
                            print("end_time: ${endtime}");
                            print("description: ${describe}");
                            print("price: ${price}");
                            print("service_charges: ${chargers}");
                            print("tax: ${tax}");
                            print("payment_gateways_name: gPay");
                            print("payment_status :Paid");
                            print("image: ${img}");

                            stateSetterObject(() {
                              isInAsyncCall = true;
                            });

                            await jobCreated();


                            if(jobsCreateModel.status == "success"){
                            Future.delayed(const Duration(seconds: 2), () {
                              toastSuccessMessage("Job Created Successfully", Colors.green);

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
                                        width: width * 0.9, //350,
                                        height: height * 0.3, // 321,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(height: Get.height * 0.05,),
                                            const Text(
                                              "Job Posted\nSuccessfully!",
                                              style: TextStyle(
                                                color: Color.fromRGBO(0, 0, 0, 1),
                                                fontFamily: "Outfit",
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                // letterSpacing: -0.3,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(height: Get.height * 0.04,),
                                            GestureDetector(
                                                onTap: () {
                                                  Get.to(bottom_bar(currentIndex: 0,));
                                                  // Get.back();
                                                },
                                                child: mainButton("Go Back To Home",
                                                    Color(0xff2B65EC), context)),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                          top: -48,
                                          child: Container(
                                            width: width,
                                            //106,
                                            height: height * 0.13,
                                            //106,
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

                              stateSetterObject(() {
                                isInAsyncCall = false;
                              });
                              print("false: $isInAsyncCall");
                            });
                            } else {
                              toastFailedMessage(jobsCreateModel.message, Colors.red);
                              stateSetterObject(() {
                                isInAsyncCall = false;
                              });
                            }
                          },
                          child: isInAsyncCall
                              ? loadingBar(context)
                              : mainButton(
                                  "Post Job", Color(0xff2B65EC), context)),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      });
}
