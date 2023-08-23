import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../Models/customer_forgot_password_model.dart';
import '../../../Utils/api_urls.dart';
import '../../../widgets/MyButton.dart';
import '../../../widgets/ToastMessage.dart';
import 'AuthTextWidget.dart';
import 'OTPPage.dart';
import 'package:http/http.dart' as http;

class CustomerForgotPassword extends StatefulWidget {
  const CustomerForgotPassword({Key? key}) : super(key: key);

  @override
  State<CustomerForgotPassword> createState() => _CustomerForgotPasswordState();
}

class _CustomerForgotPasswordState extends State<CustomerForgotPassword> {

  bool isInAsyncCall = false;
  ForgotPasswordModel forgotPasswordModel = ForgotPasswordModel();
  TextEditingController _emailController = TextEditingController();
  GlobalKey<FormState> form = GlobalKey();

  ForgotPassword() async {
    String apiUrl = ForgotPasswordApiUrl;
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "email": _emailController.text.toString(),
      },
    );
    final responseString = response.body;
    print("responseForgotPasswordApi: $responseString");
    print("status Code ForgotPassword: ${response.statusCode}");
    print("in 200 ForgotPassword");
    if (response.statusCode == 200) {
      forgotPasswordModel =
          ForgotPasswordModelFromJson(responseString);
      setState(() {});
      print('ForgotPasswordModel status: ${forgotPasswordModel.status}');
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      // ModalProgressHUD(
      //   inAsyncCall: isInAsyncCall,
      //   opacity: 0.02,
      //   blur: 0.5,
      //   color: Colors.transparent,
      //   progressIndicator: CircularProgressIndicator(
      //     color: Colors.blue,
      //   ),
      //   child:
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(height: height * 0.03),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: SvgPicture.asset("assets/images/left.svg")),
                          SvgPicture.asset("assets/images/logo.svg"),
                          Text("        "),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Authheadingtext("Lost your password?", context),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Authparatext(
                            "Please enter your registered email. You will get 4-digit OTP code to reset password.",
                            context)),
                    SizedBox(height: height * 0.05),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Email Address",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: "Outfit",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              // letterSpacing: -0.3,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Form(
                            key: form,
                            child: TextFormField(
                            controller: _emailController,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Color.fromRGBO(167, 169, 183, 1),
                              fontFamily: "Outfit",
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              // contentPadding: const EdgeInsets.only(top: 12.0),
                              hintText: "Enter your email address",
                              hintStyle: const TextStyle(
                                color: Color.fromRGBO(167, 169, 183, 1),
                                fontFamily: "Outfit",
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child:
                                SvgPicture.asset("assets/images/email.svg"),
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
                          ),)
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.05),
                    GestureDetector(
                        onTap: () async {
                          print("myEmail ${_emailController.text}");
                          if(form.currentState!.validate()){
                            if (_emailController.text.isEmpty) {
                              toastFailedMessage('email required', Colors.red);
                            } else {
                              setState(() {
                                isInAsyncCall = true;
                              });

                              await ForgotPassword();

                              if(forgotPasswordModel.status == "success"){
                                Future.delayed(const Duration(seconds: 1), () {
                               // Get.to(OTPPage(data: forgotPasswordModel.data!.otp, email:  _emailController.text.toString()
                               //        ,));
                                  Get.to(() => OTPPage(data: forgotPasswordModel.data!.otp, email:  _emailController.text.toString()),
                                    transition : Transition.rightToLeftWithFade,
                                    duration: Duration(milliseconds: 250),
                                  );
                                  toastSuccessMessage(forgotPasswordModel.data?.message, Colors.green);
                                  setState(() {
                                    isInAsyncCall = false;
                                  });
                                  print("false: $isInAsyncCall");
                                });
                              }
                              if(forgotPasswordModel.status != "success"){
                                toastFailedMessage(forgotPasswordModel.message, Colors.red);
                                setState(() {
                                  isInAsyncCall = false;
                                });
                              }
                            }
                          }
                        },
                        child: isInAsyncCall ? loadingBar(context) : mainButton("Send OTP",
                            Color.fromRGBO(43, 101, 236, 1), context)),

                  ],
                ),
              ),
            ],
          ),
        ),
      // ),
    );
  }
}
