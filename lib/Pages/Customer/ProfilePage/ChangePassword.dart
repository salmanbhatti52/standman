// Initial Selected Value
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Models/change_my_password_model.dart';
import '../../../Utils/api_urls.dart';
import '../../../widgets/MyButton.dart';
import 'package:http/http.dart' as http;
import '../../../widgets/ToastMessage.dart';
import '../HomePage/HomePage.dart';

Future ChangePassword(BuildContext context, useremail, oldpassword) {

  ChangeMyPasswordModel changeMyPasswordModel = ChangeMyPasswordModel();

  final oldpasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final key = GlobalKey<FormState>();
  bool progress = false;
  bool isInAsyncCall = false;

  changePasswordFromProfile() async {
    progress = true;
    // setState(() {});
    // try {
    String apiUrl = changePasswordFromProfileApiUrl;
    print("changePasswordFromProfileApiUrl: $apiUrl");
    print("userEmail: ${userEmail.toString()}");
    print("oldpasswordController: ${oldpasswordController.text}");
    print("oldss: ${oldpassword}");

    print("passwordController: ${passwordController.text}");
    print("confirmpasswordController: ${confirmpasswordController.text}");
    final response = await http.post(Uri.parse(apiUrl),
        body: {
      "email": useremail,
      "old_password": oldpasswordController.text,
      "password": passwordController.text,
      "confirm_password": confirmpasswordController.text,
    }, headers: {
      'Accept': 'application/json'
    }
    );
    final responseString = response.body;
    print("responseSignInApi: $responseString");
    print("status Code SignIn: ${response.statusCode}");
    print("in 200 SignIn");
    if (response.statusCode == 200) {
      changeMyPasswordModel = changeMyPasswordModelFromJson(responseString);
      // st(() {});
      print('signUpModel status: ${changeMyPasswordModel.status}');
    }
    // }
    // catch (e) {
    //   print('Error in getUserProfileWidget: ${e.toString()}');
    // }
    progress = false;
    // StateSetter(() {});
  }

  // sharedPrefs() async {
  //   // loading = true;
  //   // setState(() {});
  //   print('in changepassword shared prefs');
  //   prefs = await SharedPreferences.getInstance();
  //   // userId = (prefs!.getString('userid'));
  //   // userEmail = (prefs!.getString('user_email'));
  //   password = (prefs!.getString('password'));
  //   changePasswordFromProfile();
  //   print("userEmail in Profile is = $userEmail");
  //   print("userpassword in Profile is = $password");
  // }

  // @override
  // void initState() {
  //   // super.initState();
  //   sharedPrefs();
  // }


  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
  bool isPasswordObscure = true;
  bool isoldPasswordObscure = true;
  bool isPassworconfirmdObscure = true;
  return showFlexibleBottomSheet<void>(
    isExpand: false,
      initHeight: 0.7,
      maxHeight: 0.7,
      bottomSheetColor: Colors.transparent,
    barrierColor: Colors.black.withOpacity(0.1),
    context: context,
    builder: (context, controller, offset) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter stateSetterObject) {
            return SafeArea(
                          child: Container(
                            width: width, //390,
                            height: height * 0.6, // 515,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(30),
                                topLeft: Radius.circular(30),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    // Padding(
                                    //   padding:  EdgeInsets.symmetric(vertical: height * 0.02),
                                    //   child: Bar(
                                    //     "Change Password",
                                    //     'assets/images/arrow-back.svg',
                                    //     Colors.black,
                                    //     Colors.black,
                                    //         () {
                                    //       Get.back();
                                    //     },
                                    //   ),
                                    // ),

                                    // Container(
                                    //   child: StandManAppBar1(
                                    //     title: "Change Password",
                                    //     bgcolor: Color(0xffffffff),
                                    //     titlecolor: Colors.black,
                                    //     iconcolor: Colors.black,
                                    //   ),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: SvgPicture.asset(
                                              'assets/images/left.svg',
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            "Change Password",
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
                                    Form(
                                      key: key,
                                      child: Column(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Current Password",
                                                style: TextStyle(
                                                  color: Color.fromRGBO(0, 0, 0, 1),
                                                  fontFamily: "Outfit",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300,
                                                  // letterSpacing: -0.3,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              SizedBox(
                                                height: height * 0.02,
                                              ),
                                              TextFormField(
                                                controller: oldpasswordController,
                                                style: const TextStyle(
                                                  color: Color.fromRGBO(167, 169, 183, 1),
                                                  fontFamily: "Outfit",
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 14,
                                                ),
                                                obscureText: isoldPasswordObscure,
                                                obscuringCharacter: '*',
                                                keyboardType: TextInputType.text,
                                                decoration: InputDecoration(
                                                  hintText: "Enter your current password",
                                                  // contentPadding: const EdgeInsets.only(top: 12.0),
                                                  hintStyle: const TextStyle(
                                                    color: Color.fromRGBO(167, 169, 183, 1),
                                                    fontFamily: "Outfit",
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 14,
                                                  ),
                                                  prefixIcon: InkWell(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: SvgPicture.asset(
                                                        isPasswordObscure
                                                            ? "assets/images/lock.svg"
                                                            : "assets/images/lock.svg",
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      stateSetterObject(() {
                                                        isoldPasswordObscure = !isoldPasswordObscure;
                                                      });
                                                    },
                                                  ),
                                                  suffixIcon: InkWell(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: SvgPicture.asset(
                                                        isPasswordObscure
                                                            ? "assets/images/eye.svg"
                                                            : "assets/images/eye.svg",
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      stateSetterObject(() {
                                                        isoldPasswordObscure = !isoldPasswordObscure;
                                                      });
                                                    },
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(12),
                                                    borderSide: const BorderSide(
                                                      color: Color.fromRGBO(243, 243, 243, 1),
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(12),
                                                    borderSide: const BorderSide(
                                                      color: Color.fromRGBO(243, 243, 243, 1),
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // Row(
                                              //   mainAxisAlignment: MainAxisAlignment.end,
                                              //   children: [
                                              //     Padding(
                                              //       padding: const EdgeInsets.only(right: 5.0),
                                              //       child: TextButton(
                                              //         onPressed: () {
                                              //           Get.to(CustomerForgotPassword());
                                              //         },
                                              //         child: const Text(
                                              //           "Forgot password?",
                                              //           style: TextStyle(
                                              //               fontFamily: "Outfit",
                                              //               fontSize: 14,
                                              //               color: Color.fromRGBO(167, 169, 183, 1),
                                              //               fontWeight: FontWeight.w300),
                                              //         ),
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: height * 0.02,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "New Password",
                                                style: TextStyle(
                                                  color: Color(0xff191D31),
                                                  fontFamily: "Outfit",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300,
                                                  // letterSpacing: -0.3,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              TextFormField(
                                                validator: (val){
                                                  if(val!.isEmpty)
                                                    return 'Empty';
                                                  return null;
                                                },
                                                controller: passwordController,
                                                style: const TextStyle(
                                                  color: Color.fromRGBO(167, 169, 183, 1),
                                                  fontFamily: "Outfit",
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 14,
                                                ),
                                                obscureText: isPasswordObscure,
                                                obscuringCharacter: '*',
                                                keyboardType: TextInputType.text,
                                                decoration: InputDecoration(
                                                  hintText: "Create new password",
                                                  // contentPadding: const EdgeInsets.only(top: 12.0),
                                                  hintStyle: const TextStyle(
                                                    color: Color.fromRGBO(167, 169, 183, 1),
                                                    fontFamily: "Outfit",
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 14,
                                                  ),
                                                  prefixIcon: InkWell(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: SvgPicture.asset(
                                                        isPasswordObscure
                                                            ? "assets/images/lock.svg"
                                                            : "assets/images/lock.svg",
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      stateSetterObject(() {
                                                        isPasswordObscure = !isPasswordObscure;
                                                      });
                                                    },
                                                  ),
                                                  suffixIcon: InkWell(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: SvgPicture.asset(
                                                        isPasswordObscure
                                                            ? "assets/images/eye.svg"
                                                            : "assets/images/eye.svg",
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      stateSetterObject(() {
                                                        isPasswordObscure = !isPasswordObscure;
                                                      });
                                                    },
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(12),
                                                    borderSide: const BorderSide(
                                                      color: Color.fromRGBO(243, 243, 243, 1),
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(12),
                                                    borderSide: const BorderSide(
                                                      color: Color.fromRGBO(243, 243, 243, 1),
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              const Text(
                                                "Confirm new password",
                                                style: TextStyle(
                                                  color: Color(0xff191D31),
                                                  fontFamily: "Outfit",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300,
                                                  // letterSpacing: -0.3,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              TextFormField(
                                                validator: (val){
                                                  if(val!.isEmpty)
                                                    return 'Empty';
                                                  if(val != passwordController.text)
                                                    return "not match";
                                                },
                                                controller: confirmpasswordController,
                                                style: const TextStyle(
                                                  color: Color.fromRGBO(167, 169, 183, 1),
                                                  fontFamily: "Outfit",
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 14,
                                                ),
                                                obscureText: isPassworconfirmdObscure,
                                                obscuringCharacter: '*',
                                                keyboardType: TextInputType.text,
                                                decoration: InputDecoration(
                                                  hintText: "Confirm new password",
                                                  // contentPadding: const EdgeInsets.only(top: 12.0),
                                                  hintStyle: const TextStyle(
                                                    color: Color.fromRGBO(167, 169, 183, 1),
                                                    fontFamily: "Outfit",
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 14,
                                                  ),
                                                  prefixIcon: InkWell(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: SvgPicture.asset(
                                                        isPassworconfirmdObscure
                                                            ? "assets/images/lock.svg"
                                                            : "assets/images/lock.svg",
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      stateSetterObject(() {
                                                        isPassworconfirmdObscure =
                                                            !isPassworconfirmdObscure;
                                                      });
                                                    },
                                                  ),
                                                  suffixIcon: InkWell(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: SvgPicture.asset(
                                                        isPassworconfirmdObscure
                                                            ? "assets/images/eye.svg"
                                                            : "assets/images/eye.svg",
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      stateSetterObject(() {
                                                        isPassworconfirmdObscure =
                                                            !isPassworconfirmdObscure;
                                                      });
                                                    },
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(12),
                                                    borderSide: const BorderSide(
                                                      color: Color.fromRGBO(243, 243, 243, 1),
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(12),
                                                    borderSide: const BorderSide(
                                                      color: Color.fromRGBO(243, 243, 243, 1),
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: height * 0.04,
                                          ),
                                          GestureDetector(
                                              onTap: () async {
                                                print("myEmail ${useremail.toString()}");
                                                print("oldpass123 ${oldpassword}");
                                                print("oldpass ${oldpasswordController.text}");
                                                // print("myOTP ${widget.data}");
                                                if (key.currentState!.validate()) {
                                                  if (oldpasswordController.text.isEmpty) {
                                                    toastFailedMessage(
                                                        'Old Password cannot be empty', Colors.red);
                                                  } else if (passwordController.text.isEmpty) {
                                                    toastFailedMessage(
                                                        'New Password cannot be empty', Colors.red);
                                                  } else if (confirmpasswordController.text.isEmpty) {
                                                    toastFailedMessage(
                                                        'Confirm Password cannot be empty',
                                                        Colors.red);
                                                  }  else {
                                                    stateSetterObject(() {
                                                      isInAsyncCall = true;
                                                    });
                                                    await changePasswordFromProfile();

                                                    if(changeMyPasswordModel.status == "success"){
                                                      Future.delayed(const Duration(seconds: 3), (){
                                                        toastSuccessMessage("Changed password successfully", Colors.green);
                                                            Get.back();
                                                        stateSetterObject(() {
                                                          isInAsyncCall = false;
                                                        });
                                                        print("false: $isInAsyncCall");
                                                      }
                                                      );
                                                    }
                                                    if(changeMyPasswordModel.status != "success"){
                                                      toastFailedMessage(
                                                          changeMyPasswordModel.message, Colors.red);
                                                      stateSetterObject(() {
                                                        isInAsyncCall = false;
                                                      });
                                                    }
                                                  }
                                                }
                                              },
                                              child: mainButton("Update Password", Color(0xff2B65EC), context)),
                                          // SizedBox(
                                          //   height: height * 0.02,
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      );
                    });
          },);

}
