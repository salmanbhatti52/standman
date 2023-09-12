// Initial Selected Value
import 'package:StandMan/Pages/EmpBottombar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Models/delete_account_model.dart';
import '../../../Utils/api_urls.dart';
import '../../../widgets/MyButton.dart';
import '../../../widgets/ToastMessage.dart';
import '../../../widgets/TopBar.dart';
import '../../Authentication/Login_tab_class.dart';
import '../../Customer/HomePage/HomePage.dart';
import 'package:http/http.dart' as http;

Future EMpDeleteAccount(BuildContext context) {


  DeleteAccountModel deleteAccountModel = DeleteAccountModel();


  deleteAccount() async {
    // try {
    print('empUser_email ');
    prefs = await SharedPreferences.getInstance();
    userEmail = (prefs!.getString('empUser_email'));
    print('empUser_email $userEmail');
    String apiUrl = deleteAccountApiUrl;
    final response = await http.post(Uri.parse(apiUrl), headers: {
      "Accept": "application/json"
    }, body: {
      "user_email" : userEmail,
      "delete_reason" : "test delete",
      "comments" : "Hello"
    },
    );
    final responseString = response.body;
    print("responsedeleteAccountApi: $responseString");
    print("status Code deleteAccount: ${response.statusCode}");
    print("in 200 deleteAccount");
    if (response.statusCode == 200) {
      deleteAccountModel = deleteAccountModelFromJson(responseString);
      // stateSetterObject(() {});
      print('deleteAccount status: ${deleteAccountModel.status}');
    }
  }

  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
  bool isInAsyncCall = false;
  return showMaterialModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => SingleChildScrollView(
      controller: ModalScrollController.of(context),
      child: StatefulBuilder(
          builder: (BuildContext context, StateSetter stateSetterObject) {
            return SafeArea(
              child: Container(
                width: width, //390,
                height: height * 0.7, // 515,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:25.0),
                  child: Column(
                    children: [
                      // Padding(
                      //   padding:  EdgeInsets.symmetric(vertical: height * 0.02),
                      //   child: Bar(
                      //     "Confirm to delete account?",
                      //     'assets/images/arrow-back.svg',
                      //     Colors.black,
                      //     Colors.black,
                      //         () {
                      //       Get.back();
                      //     },
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: height * 0.04,
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Get.back();
                              },
                              child: SvgPicture.asset(
                                'assets/images/left.svg',
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "Confirm to delete account?",
                              style: TextStyle(
                                fontFamily: "Outfit",
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                          ],
                        ),
                      ),
                      Image.asset('assets/images/delete.png'),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      const Text(
                        "Are your sure to\ndelete your account?",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Outfit",
                          fontWeight: FontWeight.w300,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      GestureDetector(
                        onTap: () async {
                          stateSetterObject(() {
                            isInAsyncCall = true;
                          });

                          await deleteAccount();

                          if (deleteAccountModel.status == "success"){
                            Future.delayed(const Duration(seconds: 3), () {
                              toastSuccessMessage(deleteAccountModel.message, Colors.green);
                              // toastOTPMessage("${signUpModel.data![0].verifyCode}", Colors.green);
                              Get.to( () => Empbottom_bar(currentIndex: 0,));

                              stateSetterObject(() {
                                isInAsyncCall = false;
                              });
                              print("false: $isInAsyncCall");
                            });
                          }
                          if (deleteAccountModel.status != "success") {
                            toastFailedMessage(
                                deleteAccountModel.message, Colors.red);
                            stateSetterObject(() {
                              isInAsyncCall = false;
                            });
                          }
                        },
                        child: isInAsyncCall
                            ?  loadingBar(context)
                            : mainButton("Yes, I want to Delete My Account  ",
                            const  Color(0xff2B65EC),  context),),
                      GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.07,
                            // height: 48,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              // color: Color(0xff4DA0E6),
                              //   color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Color(0xff2B65EC), width: 1),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 0,
                                      blurRadius: 15,
                                      offset: Offset(1 , 10),
                                      color: Color.fromRGBO(7, 1, 87, 0.1)
                                  ),
                                ]
                            ),
                            child:  Center(
                              child: Text("No, I do not want to Delete my account",
                                style: TextStyle(
                                    fontFamily: "Outfit",
                                    fontSize: 14,
                                    color: Color(0xff2B65EC),
                                    fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
                            ),

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    ),
  );
}
