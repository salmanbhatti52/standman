import 'dart:convert';
import 'package:StandMan/Models/getpaymentMethodModels.dart';
import 'package:StandMan/Models/jobCreationPaymentModel.dart';
import 'package:StandMan/Pages/Customer/HomePage/HomePage.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
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

class SelectPaymentMethod extends StatefulWidget {
  final String? img;
  final String? randomNumbers;
  final String? jobName;
  final String? date;
  final String? long;
  final String? lat;
  final String? time;
  final String? endtime;
  final String? describe;
  final String? price;
  final String? amount;
  final String? chargers;
  final String? tax;
  final String? address;
  final String? totalPrice;
  final double? wallet;

  const SelectPaymentMethod(
      {super.key,
      this.img,
      this.randomNumbers,
      this.jobName,
      this.date,
      this.long,
      this.lat,
      this.time,
      this.endtime,
      this.describe,
      this.price,
      this.amount,
      this.chargers,
      this.tax,
      this.address,
      this.totalPrice,
      this.wallet});

  @override
  State<SelectPaymentMethod> createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends State<SelectPaymentMethod> {
  bool isLoading = false;

  GetPaymentModels getPaymentModels = GetPaymentModels();
  getpaymentlist() async {
    // try {

    String apiUrl = "https://admin.standman.ca/api/get_payment_gateways";
    print("api: $apiUrl");
    setState(() {
      isLoading = true;
    });
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
      },
    );
    final responseString = response.body;
    print("response getCountryListModels: $responseString");
    print("status Code getCountryListModels: ${response.statusCode}");
    print("in 200 getCountryListModels");
    if (response.statusCode == 200) {
      print("SuccessFull");
      getPaymentModels = getPaymentModelsFromJson(responseString);
      setState(() {
        isLoading = false;
      });
      print('getCountryListModels status: ${getPaymentModels.status}');
    }
  }

  JobsCreateModel jobsCreateModel = JobsCreateModel();

  jobCreated() async {
    print("working");
    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('usersCustomersId');
    print("userId in Prefs is = $usersCustomersId");
    String apiUrl = jobsCreateModelApiUrl;
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "users_customers_id": usersCustomersId,
        "name": widget.jobName != null ? widget.jobName : "",
        "location": widget.address,
        "longitude": widget.long,
        "lattitude": widget.lat,
        "start_date": widget.date,
        "start_time": widget.time,
        "end_time": widget.endtime,
        "description": widget.describe == "" ? "" : widget.describe,
        "price": widget.amount,
        "service_charges": widget.chargers,
        "tax": widget.tax,
        "image": widget.img != null ? widget.img : "",
        "job_date": "${widget.date}",
        "total_price": "${widget.price}",
        "payment_gateways_id": selectedPayment,
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
      print('jobCreationPayment status: ${jobsCreateModel}');
    }
  }

  // jobCreationPayment() async {
  //   String apiUrl = jobCreationPaymentApiUrl;
  //   print("working");

  //   final response = await http.post(
  //     Uri.parse(apiUrl),
  //     headers: {"Accept": "application/json"},
  //     body: {
  //       // "users_customers_id": jobsCreateModel.data?.usersCustomersId.toString(),
  //       "transaction_id": widget.randomNumbers.toString(),
  //       "jobs_id": jobsCreateModel.data?.jobsId.toString(),
  //       "payment_gateways_id": selectedPayment.toString(),
  //       "payment_status": "Paid",
  //     },
  //   );
  //   final responseString = response.body;
  //   print("jobCreationPayment: ${responseString}");
  //   if (response.statusCode == 200) {
  //     print('jobCreationPayment status: ${jobsCreateModel.status}');
  //   }
  // }
  JobCreationPaymentModel jobCreationPaymentModel = JobCreationPaymentModel();

  jobCreationPayment() async {
    String apiUrl = jobCreationPaymentApiUrl;
    print("working");

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        // "users_customers_id": jobsCreateModel.data?.usersCustomersId.toString(),
        "transaction_id": widget.randomNumbers.toString(),
        "jobs_id": jobsCreateModel.data?.jobsId.toString(),
        "payment_gateways_id": selectedPayment.toString(),
        "payment_status": "Paid",
      },
    );
    final responseString = response.body;
    print("jobsCreateModelApi: ${response.body}");
    print("status Code jobsCreateModel: ${response.statusCode}");
    print("in 200 jobsCreate");
    if (response.statusCode == 200) {
      jobCreationPaymentModel = jobCreationPaymentModelFromJson(responseString);
      // setState(() {});
      print('jobsCreateModel status: ${jobCreationPaymentModel.status}');
      print('jobCreationPayment status: ${jobCreationPaymentModel.data}');
    }
  }

  Map<String, dynamic>? paymentIntent;

  // calculateAmount(String amount) {
  //   amount = "${jobsCreateModel.data?.totalPrice}";
  //   final a = (int.parse(amount)) * 100;
  //   print("amount ${a}");
  //   final calculatedAmout = a;
  //   print("calculatedAmout ${calculatedAmout}");
  //   return calculatedAmout.toString();
  // }

  String calculateAmount(String amount) {
    try {
      final double numericAmount = double.parse(amount);
      final int amountInCents = (numericAmount * 100).toInt();
      print("Amount in cents: $amountInCents");
      return amountInCents.toString();
    } catch (e) {
      // Handle the case where parsing the numeric amount fails
      print('Error parsing the numeric amount: $e');
    }
    // Handle cases where the amount is null or not a valid numeric string
    return "0"; // Return a default value or handle it based on your application's logic.
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      print("hello");
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

  final DraggableScrollableController scrollController =
      DraggableScrollableController();

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent('${widget.price}', 'USD');
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
      await displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }


  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
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
                        width: Get.width * 0.9, //350,
                        height: Get.height * 0.3, // 321,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: Get.height * 0.05,
                            ),
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
                            SizedBox(
                              height: Get.height * 0.04,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Get.to(() => bottom_bar(
                                        currentIndex: 0,
                                      ));
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
                            width: Get.width,
                            //106,
                            height: Get.height * 0.13,
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
            context: context);

        paymentIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
        // print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ),
          context: context);
    } catch (e) {
      print('$e');
    }
  }

  String? selectedPayment;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getpaymentlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: StandManAppBar1(
          title: "Select Payment Mothods",
          bgcolor: Color(0xff2B65EC),
          titlecolor: Colors.white,
          iconcolor: Colors.white,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: DropdownButtonFormField<String>(
                iconDisabledColor: Colors.transparent,
                iconEnabledColor: Colors.transparent,
                value: selectedPayment,
                onChanged: (newValue) {
                  setState(() {
                    selectedPayment = newValue;
                    print(selectedPayment);
                  });
                },
                items: getPaymentModels.data?.map((payment) {
                      return DropdownMenuItem<String>(
                        value: payment.paymentGatewaysId.toString(),
                        child: Text(payment.name ?? ''),
                      );
                    }).toList() ??
                    [],
                decoration: InputDecoration(
                  suffixIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [Icon(Icons.arrow_drop_down_sharp)],
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xff2B65EC)),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  hintText: "Select Payment Method",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Color(0xFFF3F3F3),
                    ),
                  ),
                  hintStyle: const TextStyle(
                    color: Color(0xFFA7A9B7),
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    fontFamily: "Satoshi",
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      isInAsyncCall = true;
                    });
                    prefs = await SharedPreferences.getInstance();
                    usersCustomersId = prefs!.getString('usersCustomersId');
                    print("usersCustomersId: $usersCustomersId");
                    print("img: ${widget.img}");
                    print("randomNumbers: ${widget.randomNumbers}");
                    print("jobName: ${widget.jobName}");
                    print("date: ${widget.date}");
                    print("long: ${widget.long}");
                    print("lat: ${widget.lat}");
                    print("time: ${widget.time}");
                    print("endtime: ${widget.endtime}");
                    print("describe: ${widget.describe}");
                    print("price: ${widget.price}");
                    print("amount: ${widget.amount}");
                    print("chargers: ${widget.chargers}");
                    print("tax: ${widget.tax}");
                    print("address: ${widget.address}");
                    print("selectedPayment: $selectedPayment");

                    await jobCreated();

                    if (jobsCreateModel.status == "success") {
                      await jobCreationPayment();
                      if (jobCreationPaymentModel.status == "success") {
                        await makePayment();
                      } else {
                        toastFailedMessage("Something Went Wrong", Colors.red);
                      }
                    } else {
                      toastFailedMessage(jobsCreateModel.message, Colors.red);
                    }
                    setState(() {
                      isInAsyncCall = false;
                    });
                  },
                  child: isInAsyncCall
                      ? loadingBar(context)
                      : mainButton("Proceed", Color(0xff2B65EC), context)),
            ),
          ],
        ));
  }

  bool isInAsyncCall = false;
}

// selectPayment(
//   String? img,
//   String? randomNumbers,
//   String? jobName,
//   String? date,
//   String? long,
//   String? lat,
//   String? time,
//   String? endtime,
//   String? describe,
//   String? price,
//   String? amount,
//   String? chargers,
//   String? tax,
//   String? address,
//   BuildContext ctx,
// ) {
//   int _selected = 0;
//   bool isInAsyncCall = false;

//   JobsCreateModel jobsCreateModel = JobsCreateModel();
//   jobCreationPayment() async {
//     String apiUrl = jobCreationPaymentApiUrl;
//     print("working");

//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {"Accept": "application/json"},
//       body: {
//         // "users_customers_id": jobsCreateModel.data?.usersCustomersId.toString(),
//         "transaction_id": randomNumbers.toString(),
//         "jobs_id": jobsCreateModel.data?.jobsId.toString(),
//         "payment_gateways_id": "1",
//         "payment_status": "Paid",
//       },
//     );
//     final responseString = response.body;
//     print("jobCreationPayment: ${responseString}");
//     if (response.statusCode == 200) {
//       print('jobCreationPayment status: ${jobsCreateModel.status}');
//     }
//   }

//   Map<String, dynamic>? paymentIntent;

//   calculateAmount(String amount) {
//     amount = "${jobsCreateModel.data?.totalPrice}";
//     print("amount ${amount}");
//     final a = (int.parse(amount)) * 100;
//     print("amount ${a}");
//     final calculatedAmout = a;
//     print("calculatedAmout ${calculatedAmout}");
//     return calculatedAmout.toString();
//   }

//   createPaymentIntent(String amount, String currency) async {
//     try {
//       print("hello");
//       Map<String, dynamic> body = {
//         'amount': calculateAmount(amount),
//         'currency': currency,
//         'payment_method_types[]': 'card'
//       };

//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization':
//               'Bearer sk_test_51MV6RqJ1o3iGht9r8pNwA1f92pJOs9vweMCsMA6HJuTQtCiy0HTlPIAXFiI57ffEiu7EmmmfU0IHbjBGw4k5IliP0017I4MuHw',
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//         body: body,
//       );
//       // ignore: avoid_print
//       print('Payment Intent Body->>> ${response.body.toString()}');
//       return jsonDecode(response.body);
//     } catch (err) {
//       // ignore: avoid_print
//       print('err charging user: ${err.toString()}');
//     }
//   }

//   displayPaymentSheet() async {
//     try {
//       await Stripe.instance.presentPaymentSheet().then((value) {
//         showDialog(
//           context: ctx,
//           barrierDismissible: false,
//           builder: (BuildContext context) => Dialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(30.0),
//             ),
//             child: Stack(
//               clipBehavior: Clip.none,
//               alignment: Alignment.topCenter,
//               children: [
//                 Container(
//                   width: Get.width * 0.9, //350,
//                   height: Get.height * 0.3, // 321,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         height: Get.height * 0.05,
//                       ),
//                       const Text(
//                         "Job Posted\nSuccessfully!",
//                         style: TextStyle(
//                           color: Color.fromRGBO(0, 0, 0, 1),
//                           fontFamily: "Outfit",
//                           fontSize: 20,
//                           fontWeight: FontWeight.w500,
//                           // letterSpacing: -0.3,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(
//                         height: Get.height * 0.04,
//                       ),
//                       GestureDetector(
//                           onTap: () {
//                             Get.to(() => bottom_bar(
//                                   currentIndex: 0,
//                                 ));
//                             // Get.back();
//                           },
//                           child: mainButton(
//                               "Go Back To Home", Color(0xff2B65EC), context)),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                     top: -48,
//                     child: Container(
//                       width: Get.width,
//                       //106,
//                       height: Get.height * 0.13,
//                       //106,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Color(0xffFF9900),
//                       ),
//                       child: Icon(
//                         Icons.check,
//                         size: 40,
//                         color: Colors.white,
//                       ),
//                     ))
//               ],
//             ),
//           ),
//         );

//         paymentIntent = null;
//       }).onError((error, stackTrace) {
//         print('Error is:--->$error $stackTrace');
//       });
//     } on StripeException catch (e) {
//       print('Error is:---> $e');
//       showDialog(
//           context: ctx,
//           builder: (_) => const AlertDialog(
//                 content: Text("Cancelled "),
//               ));
//     } catch (e) {
//       print('$e');
//     }
//   }

//   Future<void> makePayment() async {
//     try {
//       paymentIntent = await createPaymentIntent('20', 'USD');
//       //Payment Sheet
//       await Stripe.instance
//           .initPaymentSheet(
//               paymentSheetParameters: SetupPaymentSheetParameters(
//                   paymentIntentClientSecret: paymentIntent?['client_secret'],
//                   // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
//                   // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
//                   style: ThemeMode.dark,
//                   merchantDisplayName: 'Hammad'))
//           .then((value) {});

//       ///now finally display payment sheeet
//       displayPaymentSheet();
//     } catch (e, s) {
//       print('exception:$e$s');
//     }
//   }

//   return showFlexibleBottomSheet(
//       isExpand: false,
//       initHeight: 0.44,
//       maxHeight: 0.44,
//       bottomSheetColor: Colors.transparent,
//       barrierColor: Colors.black.withOpacity(0.1),
//       context: ctx,
//       builder: (context, controller, offset) {
//         return StatefulBuilder(
//             builder: (BuildContext context, StateSetter stateSetterObject) {
//           var height = MediaQuery.of(context).size.height;
//           var width = MediaQuery.of(context).size.width;
//           return Container(
//             width: width, //390,
//             height: height * 0.5, // 547,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: const BorderRadius.only(
//                 topRight: Radius.circular(30),
//                 topLeft: Radius.circular(30),
//               ),
//             ),
//             child: SingleChildScrollView(
//               child: Padding(
//                   padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             "Payment Method",
//                             style: TextStyle(
//                               color: Color.fromRGBO(0, 0, 0, 1),
//                               fontFamily: "Outfit",
//                               fontSize: 20,
//                               fontWeight: FontWeight.w500,
//                               // letterSpacing: -0.3,
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                             child: const Icon(
//                               Icons.close,
//                               color: Colors.black,
//                             ),
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: Get.height * 0.02,
//                       ),
//                     ],
//                   )),
//             ),
//           );
//         });
//       });
// }
