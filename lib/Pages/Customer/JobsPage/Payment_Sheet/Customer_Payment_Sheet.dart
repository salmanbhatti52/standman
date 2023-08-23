import 'dart:convert';
import 'package:StandMan/Pages/Customer/JobsPage/Customer_Rating/Customer_JobDetails_Rating.dart';
import 'package:StandMan/widgets/MyButton.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Models/jobs_customers_complete_Model.dart';
import '../../../../Utils/api_urls.dart';
import '../../../../widgets/ToastMessage.dart';
import '../../../../widgets/TopBar.dart';
import '../../HomePage/HomePage.dart';
import '../../HomePage/Paymeny_details.dart';
import 'package:http/http.dart' as http;

Payment({
  BuildContext? ctx,
  String? Price,
  String? PreviousAmount,
  String? ExtraAmount,
  String? ServiceCharges,
  String? Tax,
  String? BookedTime,
  String? BookedClosed,
  String? ExtraTime,
  String? jobId,
  String? userCustomerId,
  String? userEmployeeId,
}) {
  int _selected = 0;

  JobsCustomersCompleteModel jobsCustomersCompleteModel =
      JobsCustomersCompleteModel();

  bool progress = false;

  jobsCustomersCompleteWidget() async {
    progress = true;
    // setState(() {});

    print("userCustomerId = ${userCustomerId}");
    print("userEmployeeId ${userEmployeeId}");
    print("jobId ${jobId}");

    // try {
    String apiUrl = jobsCustomersCompleteModelApiUrl;
    print("jobsCustomersCompleteApi: $apiUrl");
    final response = await http.post(Uri.parse(apiUrl), body: {
      "users_customers_id": userCustomerId.toString(),
      "employee_users_customers_id": userEmployeeId.toString(),
      "jobs_id": jobId
    }, headers: {
      'Accept': 'application/json'
    });
    print('${response.statusCode}');
    print(response);
    if (response.statusCode == 200) {
      final responseString = response.body;
      print("jobsCustomersCompleteResponse: ${responseString.toString()}");
      jobsCustomersCompleteModel =
          jobsCustomersCompleteModelFromJson(responseString);
      // print("uusersCustomersId ${jobsExtraAmount.message?.usersCustomersId}");
      // print("employeeUsersCustomersId ${jobsExtraAmount.message?.employeeUsersCustomersId}");
      // print("jobsId ${jobsExtraAmount.message?.jobsId}");
    }
    // } catch (e) {
    //   print('Error in jobsExtraAmountWidget: ${e.toString()}');
    // }
    // setState(() {});
    progress = false;
  }

  Map<String, dynamic>? paymentIntent;

  calculateAmount(String amount) {
    amount = "${jobsCustomersCompleteModel.data?.job?.totalPrice}";
    final a = (int.parse(amount)) * 100;
    print("amount ${a}");
    final calculatedAmout = a;
    print("calculatedAmout ${calculatedAmout}");
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
          'Authorization':
              'Bearer sk_test_51MV6RqJ1o3iGht9r8pNwA1f92pJOs9vweMCsMA6HJuTQtCiy0HTlPIAXFiI57ffEiu7EmmmfU0IHbjBGw4k5IliP0017I4MuHw',
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
      await Stripe.instance.presentPaymentSheet().then((value) {
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
          context: ctx!,
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
                  width: Get.width, //350,
                  height: 537,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFF),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
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
                        width: Get.width * 0.6, //241,
                        height: Get.height * 0.095, // 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xffF3F3F3),
                          border:
                              Border.all(color: Color(0xffF3F3F3), width: 1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
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
                                      jobsCustomersCompleteModel
                                          .data!.job!.totalPrice
                                          .toString(),
                                      // ' 22.00',
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
                              "${jobsCustomersCompleteModel.data!.customer!.firstName} ${jobsCustomersCompleteModel.data!.customer!.lastName}",
                              // "Beby Jovanca",
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
                              "${jobsCustomersCompleteModel.data!.employee!.firstName} ${jobsCustomersCompleteModel.data!.employee!.lastName}",
                              // "Annette Black",
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
                                  "${jobsCustomersCompleteModel.data?.job?.dateAdded}",
                                  // "24 Jul 2020",
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
                                  "${jobsCustomersCompleteModel.data?.job?.startTime}",
                                  // '15:30',
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
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      GestureDetector(
                          onTap: () {
                            Get.to(Customer_Rating(
                              jobName:
                                  "${jobsCustomersCompleteModel.data?.job?.name}",
                              totalPrice:
                                  "${jobsCustomersCompleteModel.data?.job?.totalPrice}",
                              address:
                                  "${jobsCustomersCompleteModel.data?.job?.location}",
                              jobId:
                                  "${jobsCustomersCompleteModel.data?.job?.jobsId}",
                              completeJobTime:
                                  "${jobsCustomersCompleteModel.data?.job?.dateAdded}",
                              description: "${jobsCustomersCompleteModel.data?.job?.description != null ? {jobsCustomersCompleteModel.data?.job?.description} : ""}",
                              status:
                                  "${jobsCustomersCompleteModel.data?.job?.status}",
                              customerId:
                                  "${jobsCustomersCompleteModel.data?.customer?.usersCustomersId}",
                              employeeId:
                                  "${jobsCustomersCompleteModel.data?.employee?.usersCustomersId}",
                            ));
                          },
                          child: mainButton(
                              "Add Ratings", Color(0xff2B65EC), context)),
                    ],
                  ),
                ),
                Positioned(
                    top: -48,
                    child: Container(
                      width: Get.width, //106,
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
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: ctx!,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent('20', 'USD');
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent?['client_secret'],
                  // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
                  // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Hammad'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

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
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
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
                    // "\$47.11",
                    "\$$Price",
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
                        "\$$PreviousAmount",
                        style: TextStyle(
                          color: Color(0xff000000),
                          fontFamily: "Outfit",
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 1,
                    child: "$ExtraAmount" == 0
                        ? Container(
                            height: 1,
                          )
                        : Padding(
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
                                  "\$$ExtraAmount",
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
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 2.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         "Extra Amount",
                  //         style: TextStyle(
                  //           color: Color(0xff000000),
                  //           fontFamily: "Outfit",
                  //           fontWeight: FontWeight.w300,
                  //           fontSize: 14,
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: Get.width * 0.12,
                  //       ),
                  //       Text(
                  //         "\$$ExtraAmount",
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
                        "\$$ServiceCharges",
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
                          "\$$Tax",
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
                        // "12:00-13:00",
                        "$BookedTime",
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
                        // "13:45",
                        "$BookedClosed",
                        style: TextStyle(
                          color: Color(0xffC70000),
                          fontFamily: "Outfit",
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 1,
                    child: "$ExtraTime" == 0
                        ? Container(
                            height: 1,
                          )
                        : Row(
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
                                // "45",
                                "$ExtraTime",
                                style: TextStyle(
                                  color: Color(0xffC70000),
                                  fontFamily: "Outfit",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
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
                      'Service fee - 10%',
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
                  // GestureDetector(onTap: ()async {
                  //   // final paymentMethod = await Stripe.instance.createPaymentMethod(
                  //   //     params: const PaymentMethodParams.card(
                  //   //         paymentMethodData: PaymentMethodData()));
                  //   await makePayment();
                  // },child: mainButton("Pay With Stripe", Colors.blueAccent, context)),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  GestureDetector(
                    onTap: () async {

                      stateSetterObject(() {
                        progress = true;
                      });

                      await jobsCustomersCompleteWidget();
                      await makePayment();

                      if (jobsCustomersCompleteModel.status == "success") {
                        Future.delayed(const Duration(seconds: 0), () {
                          stateSetterObject(() {
                            progress = false;
                          });
                          print("false: $progress");
                        });
                      } else {
                        toastFailedMessage(
                            jobsCustomersCompleteModel.message, Colors.red);
                        stateSetterObject(() {
                          progress = false;
                        });
                      }
                    },
                    child: progress
                        ? loadingBar(context)
                        : mainButton("Pay", Color(0xff2B65EC), context),
                  ),
                ],
              ),
            ),
          );
        });
      });
}
