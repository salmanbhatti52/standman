import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../widgets/MyButton.dart';
import '../../../widgets/ToastMessage.dart';
import 'AuthTextWidget.dart';
import 'Newpassword.dart';

class OTPPage extends StatefulWidget {
  final int? data;
  final String? email;
  OTPPage({Key? key,   this.data, this.email}) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final OTpCode = TextEditingController();
  final key = GlobalKey<FormState>();
  bool isInAsyncCall = false;

  @override
  void initState() {
    print("otp: ${widget.data}");
    print("otp: ${widget.email}");
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
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
                        // SizedBox(width: width * 0.3,),
                        SvgPicture.asset("assets/images/logo.svg"),
                        Text("        "),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Authheadingtext("Enter 4-digit OTP code", context),
                  ),
                  Authparatext(
                      "Please enter 4-digit OTP code here, after\nconfirmation you can create new password.",
                      context),
                  SizedBox(height: height * 0.05),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: key,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 70),
                          child: PinCodeTextField(
                            controller: OTpCode,
                            appContext: context,
                            length: 4,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.number,
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontFamily: "Outfit",
                              fontWeight: FontWeight.w300,
                              color: Color(0xffA7A9B7),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              fieldWidth: width * 0.1,
                              //48,
                              fieldHeight: height * 0.06,
                              //48,
                              activeColor: const Color(0xffF3F3F3),
                              inactiveColor: const Color(0xffF3F3F3),
                              selectedColor: const Color(0xffF3F3F3),
                              borderWidth: 1,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            onChanged: (String value) {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.05),
                  GestureDetector(
                      onTap: () {
                        if (key.currentState!.validate()) {
                          if (OTpCode.text.isEmpty) {
                            toastFailedMessage('OTp required', Colors.red);
                          } else {
                            print("otp: ${widget.data}");
                            print("otp: ${OTpCode}");
                            print("otp: ${widget.email}");

                            setState(() {
                              isInAsyncCall = true;
                            });
                            if (widget.data.toString() == OTpCode.text ) {

                              Future.delayed(const Duration(seconds: 3), () {
                                toastSuccessMessage("success", Colors.green);
                                Get.to(NewPassword(data: widget.data, email: widget.email,));
                                setState(() {
                                  isInAsyncCall = false;
                                });
                                print("false: $isInAsyncCall");
                              });
                            }
                            if (widget.data.toString() != OTpCode.text) {
                              toastFailedMessage(
                                  "Enter Correct OTp", Colors.red);
                              setState(() {
                                isInAsyncCall = false;
                              });
                            }
                          }
                        }
                      },
                      child: mainButton(
                          "Confirm", Color.fromRGBO(43, 101, 236, 1), context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
