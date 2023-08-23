import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../Models/modifyPassworsd_model.dart';
import '../../../Utils/api_urls.dart';
import '../../../widgets/MyButton.dart';
import '../../../widgets/ToastMessage.dart';
import '../Login_tab_class.dart';
import 'AuthTextWidget.dart';
import 'package:http/http.dart' as http;

class NewPassword extends StatefulWidget {
  final int? data;
  final String? email;
   NewPassword({Key? key, this.data, this.email}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {

  final confirmpasswordController = TextEditingController();
  final passwordController = TextEditingController();
  ModifyPasswordModel modifyPasswordModel = ModifyPasswordModel();
  final key = GlobalKey<FormState>();
  bool isPasswordObscure = true;
  bool isPassworconfirmdObscure = true;
  bool isInAsyncCall = false;


  @override
  void initState() {
    print("otp: ${widget.data}");
    print("email: ${widget.email}");
    // TODO: implement initState
    super.initState();
  }


  modifyPassword() async {
    setState(() {
      isInAsyncCall = true;
    });
    String apiUrl = ModifyPasswordApiUrl;
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "email" :  widget.email.toString(),
        "otp" : widget.data.toString(),
        "password": passwordController.text.toString(),
        "confirm_password": confirmpasswordController.text.toString(),
      },
    );
    final responseString = response.body;
    print("responseForgotPasswordApi: $responseString");
    if (response.statusCode == 200) {
      modifyPasswordModel =
          modifyPasswordModelFromJson(responseString);
      setState(() {});
      print('ForgotPasswordModel status: ${modifyPasswordModel.status}');
      print("in 200 ForgotPassword");
      setState(() {
        isInAsyncCall = false;
      });
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
          child: SingleChildScrollView(
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
                        child: Authheadingtext(
                            "Create your new password", context),
                      ),
                      Authparatext("Please create your new password", context),
                      SizedBox(height: height * 0.05),
                      Form(
                        key: key,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Create new password",
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
                                  hintText: "Enter password",
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
                                      setState(() {
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
                                      setState(() {
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
                                  hintText: "Confirm password",
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
                                      setState(() {
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
                                      setState(() {
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
                        ),
                      ),
                      SizedBox(height: height * 0.05),
                      GestureDetector(
                          onTap: () async {
                            print("myEmail ${widget.email}");
                            print("myOTP ${widget.data}");
                            if (key.currentState!.validate()) {
                              if (passwordController.text.isEmpty) {
                                toastFailedMessage(
                                    'Password cannot be empty', Colors.red);
                              } else if (confirmpasswordController
                                  .text.isEmpty) {
                                toastFailedMessage(
                                    'Confirm Password cannot be empty',
                                    Colors.red);
                              } else {
                                setState(() {
                                  isInAsyncCall = true;
                                });
                                await modifyPassword();

                                Future.delayed(const Duration(seconds: 1),
                                      () {
                                    toastSuccessMessage(
                                        "Password Changed Successfully", Colors.green);
                                  // Get.to(LoginTabClass(login: 0,));
                                    Get.to(() => LoginTabClass(login: 0,),
                                      transition : Transition.downToUp,
                                      duration: Duration(milliseconds: 350), );
                                    setState(() {
                                      isInAsyncCall = false;
                                    });
                                    print("false: $isInAsyncCall");
                                  });
                                }
                              }
                            },
                          child: isInAsyncCall ? loadingBar(context): mainButton("Confirm",
                              Color.fromRGBO(43, 101, 236, 1), context)),
                      SizedBox(height: height * 0.05),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      // ),
    );
  }
}
