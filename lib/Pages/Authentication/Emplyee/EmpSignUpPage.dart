import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../Models/employee_signup_model.dart';
import '../../../Utils/api_urls.dart';
import '../../../widgets/MyButton.dart';
import '../../../widgets/ToastMessage.dart';
import '../../../widgets/social_button.dart';
import '../../TermConditions.dart';
import '../Login_tab_class.dart';
import 'Emp_UploadPhoto.dart';
import 'package:http/http.dart' as http;

class EmployeeSignUpPage extends StatefulWidget {
  const EmployeeSignUpPage({Key? key}) : super(key: key);

  @override
  State<EmployeeSignUpPage> createState() => _EmployeeSignUpPageState();
}

class _EmployeeSignUpPageState extends State<EmployeeSignUpPage> {
  final firstNameController = TextEditingController();
  final lastController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final key = GlobalKey<FormState>();
  bool isPasswordObscure = true;
  bool isPasswordConfirmObscure = true;
  bool isInAsyncCall = false;
  String countryCode = '';

  void onCountryChange(PhoneNumber number) {
    setState(() {
      countryCode = number.countryISOCode;
      print("countryCode ${countryCode}");
    });
  }



  final GlobalKey<FlutterPwValidatorState> validatorKey = GlobalKey<FlutterPwValidatorState>();
  bool required = false;

  // EmployeeSignupModel employeeSignupModel = EmployeeSignupModel();

  // employeeRegisterUser() async {
  //   // try {
  //   String apiUrl = employeeSignupApiUrl;
  //   final response = await http.post(
  //     Uri.parse(apiUrl),
  //     headers: {"Accept": "application/json"},
  //     body: {
  //       "one_signal_id": "123456",
  //       "users_customers_type": "Employee",
  //       "full_name": nameController.text,
  //       "phone": phoneController.text,
  //       "email": emailController.text,
  //       "password": passwordController.text,
  //       "account_type": "SignupWithApp",
  //       "profile_pic": "$imagePath",
  //       "company_name": "test Employee",
  //       "proof_document": "iVBORw",
  //       // "valid_document": "iVBORw0KGgoAAAANSUhEUgAABAAAAAQACAYAAAB/
  //     },
  //   );
  //   final responseString = response.body;
  //   print("responseSignUpApi: $responseString");
  //   print("status Code SignUp: ${response.statusCode}");
  //   print("in 200 signUp");
  //   if (response.statusCode == 200) {
  //     employeeSignupModel = employeeSignupModelFromJson(responseString);
  //     setState(() {});
  //     print('signUpModel status: ${employeeSignupModel.status}');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
          Form(
            key: key,
            child: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Fixed Container

              // Scrollable Container
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Center(
                              child: CircleAvatar(
                                radius: height * 0.08,
                                backgroundColor: Colors.transparent,
                                backgroundImage: imagePath == null
                                    ? AssetImage(
                                  "assets/images/fade_in_image.jpeg",
                                )
                                    : Image.file(
                                  imagePath!,
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.contain,
                                ).image,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: width * 0.37, //150,
                              child:GestureDetector(
                                onTap: () async {
                                  // pickCoverImage();
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        alignment: Alignment.topCenter,
                                        children: [
                                          Container(
                                            width: 350,
                                            height: height * 0.3, // 321,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  GestureDetector(onTap:(){
                                                    pickImageGallery();
                                                    Get.back();
                                                  } ,child: mainButton("PICK FROM GALLERY", Color(0xff2B65EC), context)),
                                                  SizedBox(height: height * 0.02,),
                                                  GestureDetector(onTap:(){
                                                    pickImageCamera();

                                                    Get.back();
                                                  } ,child: mainButton("PICK FROM CAMERA", Color(0xff2B65EC), context))
                                                ],
                                              ),
                                            ),
                                          ),
                                          // Positioned(
                                          //     top: -48,
                                          //     child: Container(
                                          //       width: width * 0.2,
                                          //       //106,
                                          //       height: height * 0.13,
                                          //       //106,
                                          //       decoration: BoxDecoration(
                                          //         shape: BoxShape.circle,
                                          //         color: Color(0xffFF9900),
                                          //       ),
                                          //       child: Icon(
                                          //         Icons.image,
                                          //         size: 60,
                                          //         color: Colors.white,
                                          //       ),
                                          //     ))
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    color: Color(0xff1D272F),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 1.5),
                                  ),
                                  child: Center(
                                      child: SvgPicture.asset("assets/images/camera.svg")),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: width,
                          // height: height * 0.55,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                ),
                                // Text(
                                //   "We will verify your account within 1-3 business days. Please note that this timeframe is an average and not a guarantee. Depending on the current volume, the verification process could be faster or slower.",
                                //   style: TextStyle(
                                //     color: Color(0xffC70000),
                                //     fontFamily: "Outfit",
                                //     fontSize: 12,
                                //     fontWeight: FontWeight.w300,
                                //   ),
                                //   textAlign: TextAlign.left,
                                // ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                const Text(
                                  "First Name",
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
                                TextFormField(
                                  controller: firstNameController,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: Color.fromRGBO(167, 169, 183, 1),
                                    fontFamily: "Outfit",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                  ),
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    // contentPadding: const EdgeInsets.only(top: 12.0),
                                    hintText: "Enter your first name",
                                    hintStyle: const TextStyle(
                                      color: Color.fromRGBO(167, 169, 183, 1),
                                      fontFamily: "Outfit",
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: SvgPicture.asset(
                                          "assets/images/profile.svg"),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(243, 243, 243, 1),
                                        width: 1.0,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(243, 243, 243, 1),
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
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
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                const Text(
                                  "Last Name",
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
                                TextFormField(
                                  controller: lastController,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: Color.fromRGBO(167, 169, 183, 1),
                                    fontFamily: "Outfit",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                  ),
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    // contentPadding: const EdgeInsets.only(top: 12.0),
                                    hintText: "Enter your last name",
                                    hintStyle: const TextStyle(
                                      color: Color.fromRGBO(167, 169, 183, 1),
                                      fontFamily: "Outfit",
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: SvgPicture.asset(
                                          "assets/images/profile.svg"),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(243, 243, 243, 1),
                                        width: 1.0,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(243, 243, 243, 1),
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
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
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Text(
                                  "*Must Match the Government-Issued ID",
                                  style: TextStyle(
                                    color: Color(0xffC70000),
                                    fontFamily: "Outfit",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0),
                                      child: const Text(
                                        "Phone Number",
                                        style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          fontFamily: "Outfit",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          // letterSpacing: -0.3,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    IntlPhoneField(
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Outfit",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                      controller: phoneController,
                                      initialCountryCode: 'US',
                                      onChanged: onCountryChange,
                                      decoration: InputDecoration(
                                        // contentPadding: const EdgeInsets.only(top: 12.0),
                                        hintText: "Enter your phone name",
                                        hintStyle: const TextStyle(
                                          color: Color.fromRGBO(167, 169, 183, 1),
                                          fontFamily: "Outfit",
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14,
                                        ),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: SvgPicture.asset(
                                              "assets/images/profile.svg"),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                            color: Color(0xff2B65EC),
                                            width: 1.0,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                            color: Color(0xff2B65EC),
                                            width: 1.0,
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                            color: Color(0xff2B65EC),
                                            width: 1.0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                            color: Color(0xff2B65EC),
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      // initialCountryCode: 'PK',
                                      // onCountryChanged: (country) {
                                      //   print('Country changed to: ' +
                                      //       country.name);
                                      // },
                                    ),
                                  ],
                                ),
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
                                TextFormField(
                                  controller: emailController,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: Color.fromRGBO(167, 169, 183, 1),
                                    fontFamily: "Outfit",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (val) {
                                    return RegExp(
                                                r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                            .hasMatch(val!)
                                        ? null
                                        : "Please enter correct Email";
                                  },
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
                                      child: SvgPicture.asset(
                                          "assets/images/email.svg"),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(243, 243, 243, 1),
                                        width: 1.0,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(243, 243, 243, 1),
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
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
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                const Text(
                                  "Password",
                                  style: TextStyle(
                                    color: Color.fromRGBO(25, 29, 49, 1),
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
                                  onTap: (){
                                    setState(() {
                                      required = true;
                                    });
                                  },
                                  style: const TextStyle(
                                    color: Color.fromRGBO(167, 169, 183, 1),
                                    fontFamily: "Outfit",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                  ),
                                  validator: (val) {
                                    return RegExp(
                                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                        .hasMatch(val!)
                                        ? null
                                        : "Password must be at least 8 characters and  Must have\n Atleast 1 uppercase & lowercase letter & 1 number";
                                  },
                                  obscureText: isPasswordObscure,
                                  obscuringCharacter: '*',
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: "Create Password",
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
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(243, 243, 243, 1),
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedErrorBorder:  OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(243, 243, 243, 1),
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                if(required == true)
                                  new FlutterPwValidator(
                                    defaultColor: Color(0xffEA4335),
                                    failureColor: Color(0xffEA4335),
                                    successColor: Color(0xff4267B2),
                                    key: validatorKey,
                                    controller: passwordController,
                                    minLength: 8,
                                    uppercaseCharCount: 1,
                                    numericCharCount: 1,
                                    specialCharCount: 1,
                                    normalCharCount: 1,
                                    width: 400,
                                    height: 160,
                                    onSuccess: () {
                                      print("MATCHED");
                                      // ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                                      //     content: new Text("Password is matched")));
                                    },
                                    onFail: () {
                                      print("NOT MATCHED");
                                    },
                                  ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                const Text(
                                  "Confirm Password",
                                  style: TextStyle(
                                    color: Color.fromRGBO(25, 29, 49, 1),
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
                                  controller: passwordConfirmController,
                                  style: const TextStyle(
                                    color: Color.fromRGBO(167, 169, 183, 1),
                                    fontFamily: "Outfit",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                  ),
                                  validator: (val){
                                    if(val!.isEmpty)
                                      return 'Please enter confirm password';
                                    if(val != passwordController.text)
                                      return "Password don't match";
                                  },
                                  obscureText: isPasswordConfirmObscure,
                                  obscuringCharacter: '*',
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: "Confirm Password",
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
                                          isPasswordConfirmObscure
                                              ? "assets/images/lock.svg"
                                              : "assets/images/lock.svg",
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          isPasswordConfirmObscure = !isPasswordConfirmObscure;
                                        });
                                      },
                                    ),
                                    suffixIcon: InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(
                                          isPasswordConfirmObscure
                                              ? "assets/images/eye.svg"
                                              : "assets/images/eye.svg",
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          isPasswordConfirmObscure = !isPasswordConfirmObscure;
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
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(243, 243, 243, 1),
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedErrorBorder:  OutlineInputBorder(
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
                        SizedBox(
                          height: height * 0.02,
                        ),
                        // Padding(
                        //   padding:
                        //       const EdgeInsets.only(left: 25.0, bottom: 15),
                        //   child: Row(
                        //     children: [
                        //       const Text(
                        //         "Upload ID",
                        //         style: TextStyle(
                        //           color: Color.fromRGBO(0, 0, 0, 1),
                        //           fontFamily: "Outfit",
                        //           fontSize: 16,
                        //           fontWeight: FontWeight.w400,
                        //           // letterSpacing: -0.3,
                        //         ),
                        //         textAlign: TextAlign.left,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   width: width * 0.9,
                        //   height: height * 0.2,
                        //   // width: 330,
                        //   // height: 139,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(12),
                        //     color: Color(0xffF3F3F3),
                        //   ),
                        //   child: uploadID == null
                        //       ? GestureDetector(
                        //           onTap: () {
                        //             pickUploadId();
                        //           },
                        //           child: Center(
                        //               child: SvgPicture.asset(
                        //             "assets/images/upload.svg",
                        //             width: 75,
                        //             height: 52,
                        //           )))
                        //       : Image.file(uploadID!,
                        //           width: 75, height: 52, fit: BoxFit.fill),
                        // ),
                        Padding(
                          padding: EdgeInsets.only(right: width * 0.15, top: 10),
                          child: GestureDetector(
                            onTap: (){
                              Get.to(TermsandConditions());
                            },
                            child: RichText(
                              text: const TextSpan(
                                  text: "By Clicking Next, you agree to our ",
                                  style: TextStyle(
                                      fontFamily: "Outfit",
                                      fontSize: 14,
                                      color: Color.fromRGBO(34, 34, 34, 0.5),
                                      fontWeight: FontWeight.w400),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Terms and\nPolicy",
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontFamily: "Outfit",
                                          fontSize: 14,
                                          color: Color(0xff2B65EC),
                                          fontWeight: FontWeight.w700),
                                    ),
                                    TextSpan(
                                      text: " that you have read.",
                                      style: TextStyle(
                                          fontFamily: "Outfit",
                                          fontSize: 14,
                                          color: Color.fromRGBO(34, 34, 34, 0.5),
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        GestureDetector(
                            onTap: () async {
                              if (key.currentState!.validate()) {
                                if (firstNameController.text.isEmpty) {
                                  toastFailedMessage(
                                      'First Name cannot be empty', Colors.red);
                                } else if (lastController.text.isEmpty) {
                                  toastFailedMessage(
                                      'Last Name cannot be empty', Colors.red);
                                } else if (phoneController.text.isEmpty) {
                                  toastFailedMessage(
                                      'phone number cannot be empty', Colors.red);
                                } else if (emailController.text.isEmpty) {
                                  toastFailedMessage(
                                      'email cannot be empty', Colors.red);
                                } else if (passwordController.text.length < 8) {
                                  toastFailedMessage(
                                      'password must be 8 digit', Colors.red);
                                } else if (passwordConfirmController.text.length < 8) {
                                  toastFailedMessage(
                                      'Confirm password must be 8 digit', Colors.red);
                                } else if (base64img == null) {
                                  toastFailedMessage(
                                      'Please provide a photo of yourself.', Colors.red);
                                } else {
                                  // setState(() {
                                  //   isInAsyncCall = true;
                                  // });
                                  // await employeeRegisterUser();

                                  // Get.to(EMp_UploadPhoto());

                                  // if (employeeSignupModel.status == "success") {
                                    Get.to(EMp_UploadPhoto(
                                      profileimg: base64img,
                                      firstname: firstNameController.text.toString(),
                                      lastname: lastController.text.toString(),
                                      email: emailController.text.toString(),
                                      phonenumber: phoneController.text.toString(),
                                      selectedCountryCode: countryCode.toString(),
                                      password: passwordController.text.toString(),
                                      // confirmpassword: passwordController.text.toString(),
                                    ),
                                    );
                                    // setState(() {
                                    //   isInAsyncCall = false;
                                    // });
                                    // if (employeeSignupModel.status == "error") {
                                    //   toastFailedMessage(
                                    //       employeeSignupModel.message, Colors.red);
                                    //   setState(() {
                                    //     isInAsyncCall = false;
                                    //   });
                                    // }
                                  // }
                                }
                              }
                              //
                            },
                            child: mainButton("Next",
                                Color.fromRGBO(43, 101, 236, 1), context)),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Text(
                            "OR",
                            style: TextStyle(
                                fontFamily: "Outfit",
                                fontSize: 14,
                                color: Color.fromRGBO(167, 169, 183, 1),
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        socialButton(context),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account?',
                                style: TextStyle(
                                  color: Color(0xffA7A9B7),
                                  fontFamily: "Outfit",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  // letterSpacing: -0.3,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  //   Navigator.pushReplacementNamed(context, '/registerType');
                                  // Get.to(SignUpTabClass());
                                  Get.to(LoginTabClass(login: 1,));
                                },
                                child: const Text(
                                  'Sign In here',
                                  style: TextStyle(
                                    color: Color(0xff2B65EC),
                                    fontFamily: "Outfit",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    // letterSpacing: -0.3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
        ),
      ),
          ),
      // ),
    );
  }

  File? imagePath;
  String? base64img;
  Future pickImageGallery() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? xFile = await _picker.pickImage(source: ImageSource.gallery);
      if (xFile == null) return;

      Uint8List imageByte = await xFile.readAsBytes();
      base64img = base64.encode(imageByte);
      print("base64img $base64img");

      final imageTemporary = File(xFile.path);

      setState(() {
        imagePath = imageTemporary;
        print("newImage $imagePath");
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: ${e.toString()}');
    }
  }


  Future pickImageCamera() async {

    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? xFile = await _picker.pickImage(source: ImageSource.camera);
      if (xFile == null) return;

      Uint8List imageByte = await xFile.readAsBytes();
      base64img = base64.encode(imageByte);
      print("base64img $base64img");

      final imageTemporary = File(xFile.path);

      setState(() {
        imagePath = imageTemporary;
        print("newImage $imagePath");
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: ${e.toString()}');
    }
  }

// File? uploadID;
// String? base64ID;
//
// Future pickUploadId() async {
//   try {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? xFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (xFile == null) return;
//
//     Uint8List imageByte = await xFile.readAsBytes();
//     base64ID = base64.encode(imageByte);
//     print("base64ID $base64ID");
//
//     final imageTemporary = File(xFile.path);
//
//     setState(() {
//       uploadID = imageTemporary;
//       print("newImage $uploadID");
//     });
//   } on PlatformException catch (e) {
//     print('Failed to pick uploadID: ${e.toString()}');
//   }
// }
}
