import 'dart:convert';
import 'dart:io';
import 'package:StandMan/Pages/Authentication/Login_tab_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../../../Models/employee_signup_model.dart';
import '../../../Utils/api_urls.dart';
import '../../../widgets/MyButton.dart';
import '../../../widgets/ToastMessage.dart';
import '../../../widgets/TopBar.dart';
import 'package:http/http.dart' as http;

import 'Emp_Email_Verify.dart';

class WorkProof extends StatefulWidget {
  final String? profileimg;
  final String? uploadID;
  final String? firstname;
  final String? selectedCountryCode;
  final String? lastname;
  final String? email;
  final String? phonenumber;
  final String? password;

  const WorkProof(
      {Key? key,
      this.profileimg,
      this.email,
      this.phonenumber,
      this.selectedCountryCode,
      this.password,
      this.uploadID,
      this.firstname,
      this.lastname})
      : super(key: key);

  @override
  State<WorkProof> createState() => _WorkProofState();
}

class _WorkProofState extends State<WorkProof> {
  EmployeeSignupModel employeeSignupModel = EmployeeSignupModel();
  final key = GlobalKey<FormState>();
  bool isInAsyncCall = false;

  employeeRegisterUser() async {

    var status = await OneSignal.shared.getDeviceState();
    String tokenId = status!.userId!;
    print("OneSignal User ID: $tokenId");

    String apiUrl = employeeSignupApiUrl;
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "one_signal_id": tokenId,
        "users_customers_type": "Employee",
        "first_name": widget.firstname,
        "last_name": widget.lastname,
        "phone": widget.phonenumber,
        "country_code":"${widget.selectedCountryCode.toString()}",
        "email": widget.email,
        "password": widget.password,
        "account_type": "SignupWithApp",
        "profile_pic": widget.profileimg,
        "company_name": "test Employee",
        "proof_document": base64ProofID,
        "valid_document": widget.uploadID,
      },
    );
    final responseString = response.body;
    print("responseSignUpApi: $responseString");
    print("status Code SignUp: ${response.statusCode}");
    print("in 200 signUp");
    if (response.statusCode == 200) {
      employeeSignupModel = employeeSignupModelFromJson(responseString);
      setState(() {});
      print('signUpModel status: ${employeeSignupModel.status}');
    }
  }

  void initState() {
    print("Profileimg: ${widget.profileimg}");
    print("uploadIDImg: ${widget.uploadID}");
    print("name: ${widget.firstname}");
    print("name: ${widget.lastname}");
    print("email: ${widget.email}");
    print("number: ${widget.phonenumber}");
    print("pass: ${widget.password}");
    // TODO: implement initState
    super.initState();
  }

  final testData = [
    "Birth certificate",
    "Citizenship card, Passport",
    "Permanent PR card, Work permit",
    "Social Insurance Number",
    "Card or letter",
    "Study permit (if it declares the ability to work off-campus unrelated to program of study)",
    "Certificate of Indian Status",
    "Canadian Forces Identification Card"
  ];

  @override
  Widget build(BuildContext context) {
    final _markDownData =
        testData.map((x) => "- $x\n").reduce((x, y) => "$x$y");
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: StandManAppBar1(
        title: "Proof of\nWork Eligibility",
        bgcolor: Color(0xfffffff),
        titlecolor: Colors.black,
        iconcolor: Colors.black,
      ),
      body:
          SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "You can upload",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    fontFamily: "Outfit",
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xff222222).withOpacity(0.5),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                        ),
                        child: Text(
                          "Birth certificate",
                          style: TextStyle(
                              fontFamily: "Outfit",
                              fontSize: 16,
                              color: Color(0xff222222).withOpacity(0.5),
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Container(
                                  // width: width * 0.3,
                                  height: height * 0.36,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      Image.asset(
                                        "assets/example/birth_certificate.jpg",
                                        // fit: BoxFit.cover,
                                        // width: 230,
                                        // height: 230,
                                      ),
                                    ],
                                  )
                                ),
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, top: 3.0),
                          child: Image.asset(
                            "assets/example/example.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xff222222).withOpacity(0.5),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                        ),
                        child: Text(
                          "Citizenship card",
                          style: TextStyle(
                              fontFamily: "Outfit",
                              fontSize: 16,
                              color: Color(0xff222222).withOpacity(0.5),
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Container(
                                  // width: width * 0.3,
                                    height: height * 0.42,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        Image.asset(
                                          "assets/example/citizenship.jpg",
                                          // fit: BoxFit.cover,
                                          // width: 230,
                                          // height: 230,
                                        ),
                                      ],
                                    )
                                ),
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, top: 3.0),
                          child: Image.asset(
                            "assets/example/example.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xff222222).withOpacity(0.5),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                        ),
                        child: Text(
                          "Passport",
                          style: TextStyle(
                              fontFamily: "Outfit",
                              fontSize: 16,
                              color: Color(0xff222222).withOpacity(0.5),
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Container(
                                  // width: width * 0.3,
                                    height: height * 0.36,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        Image.asset(
                                          "assets/example/passport.jpg",
                                          // fit: BoxFit.cover,
                                          // width: 230,
                                          // height: 230,
                                        ),
                                      ],
                                    )
                                ),
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, top: 3.0),
                          child: Image.asset(
                            "assets/example/example.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xff222222).withOpacity(0.5),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                        ),
                        child: Text(
                          "Permanent PR card",
                          style: TextStyle(
                              fontFamily: "Outfit",
                              fontSize: 16,
                              color: Color(0xff222222).withOpacity(0.5),
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Container(
                                  // width: width * 0.3,
                                    height: height * 0.33,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        Image.asset(
                                          "assets/example/residency_card.jpg",
                                          // fit: BoxFit.cover,
                                          // width: 230,
                                          // height: 230,
                                        ),
                                      ],
                                    )
                                ),
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, top: 3.0),
                          child: Image.asset(
                            "assets/example/example.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xff222222).withOpacity(0.5),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                        ),
                        child: Text(
                          "Work permit",
                          style: TextStyle(
                              fontFamily: "Outfit",
                              fontSize: 16,
                              color: Color(0xff222222).withOpacity(0.5),
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Container(
                                  // width: width * 0.3,
                                    height: height * 0.6,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        Image.asset(
                                          "assets/example/work_permit.jpg",
                                          // fit: BoxFit.cover,
                                          // width: 230,
                                          // height: 230,
                                        ),
                                      ],
                                    )
                                ),
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, top: 3.0),
                          child: Image.asset(
                            "assets/example/example.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 3,
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 15.0,
                //   ),
                //   child: Row(
                //     children: [
                //       Container(
                //         width: 5,
                //         height: 5,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(12),
                //           color: Color(0xff222222).withOpacity(0.5),
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.only(
                //           left: 8.0,
                //         ),
                //         child: Text(
                //           "Social Insurance Number Card or letter",
                //           style: TextStyle(
                //               fontFamily: "Outfit",
                //               fontSize: 15,
                //               color: Color(0xff222222).withOpacity(0.5),
                //               fontWeight: FontWeight.w300),
                //           textAlign: TextAlign.left,
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.only(left: 5 , top: 3.0),
                //         child: Image.asset("assets/example/example.png" , width: 30, height: 30,),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 3,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 3
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        margin: EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xff222222).withOpacity(0.5),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                          ),
                          child: Text(
                            "Study permit (if it declares the ability to work off-campus unrelated to program of study)",
                            style: TextStyle(
                                fontFamily: "Outfit",
                                fontSize: 16,
                                color: Color(0xff222222).withOpacity(0.5),
                                fontWeight: FontWeight.w300),
                            // textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Container(
                                  // width: width * 0.3,
                                    height: height * 0.6,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        Image.asset(
                                          "assets/example/study_permit.jpg",
                                          // fit: BoxFit.cover,
                                          // width: 230,
                                          // height: 230,
                                        ),
                                      ],
                                    )
                                ),
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, top: 3.0),
                          child: Image.asset(
                            "assets/example/example.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xff222222).withOpacity(0.5),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                        ),
                        child: Text(
                          "Certificate of Indian Status",
                          style: TextStyle(
                              fontFamily: "Outfit",
                              fontSize: 16,
                              color: Color(0xff222222).withOpacity(0.5),
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Container(
                                  // width: width * 0.3,
                                    height: height * 0.36,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        Image.asset(
                                          "assets/example/indian_status.jpg",
                                          // fit: BoxFit.cover,
                                          // width: 230,
                                          // height: 230,
                                        ),
                                      ],
                                    )
                                ),
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, top: 3.0),
                          child: Image.asset(
                            "assets/example/example.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xff222222).withOpacity(0.5),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                        ),
                        child: Text(
                          "Canadian Forces Identification Card",
                          style: TextStyle(
                              fontFamily: "Outfit",
                              fontSize: 16,
                              color: Color(0xff222222).withOpacity(0.5),
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Container(
                                  // width: width * 0.3,
                                    height: height * 0.36,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        Image.asset(
                                          "assets/example/forces_id.png",
                                          // fit: BoxFit.cover,
                                          // width: 230,
                                          // height: 230,
                                        ),
                                      ],
                                    )
                                ),
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, top: 3.0),
                          child: Image.asset(
                            "assets/example/example.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  "If you are uploading a work permit extension letter, upload the extension letter and your work permit in the same photo"
                    "If you are waiting for your renewed PR card, upload a photo of your current PR card and PR card extension letter",
                  // "Please submit a photo or the original document. Scanned copies are not accepted. Make sure to avoid using flash so that your information is clear and readable. If you are uploading a work permit extension letter, upload the extension letter and your work permit in the same photo if you are waiting for your renewed PR card, upload a photo of your current PR card and PR card extension letter",
                  style: TextStyle(
                    color: Color(0xffC70000),
                    fontFamily: "Outfit",
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Row(
                    children: [
                      const Text(
                        "Upload",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: "Outfit",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          // letterSpacing: -0.3,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                Form(
                  key: key,
                  child: Container(
                    width: width * 0.9,
                    height: height * 0.2,
                    // width: 330,
                    // height: 139,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xffF3F3F3),
                    ),
                    child: uploadProofID == null
                        ? GestureDetector(
                            onTap: () {
                              pickUploadProofId();
                            },
                            child: Center(
                                child: SvgPicture.asset(
                              "assets/images/upload.svg",
                              width: 75,
                              height: 52,
                            )))
                        : Image.file(uploadProofID!,
                            width: 75, height: 52, fit: BoxFit.fill),
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                GestureDetector(
                    onTap: () async {
                      if (key.currentState!.validate()) {
                        if (uploadProofID == null) {
                          toastFailedMessage('ProofID required', Colors.red);
                        } else {
                          setState(() {
                            isInAsyncCall = true;
                          });

                          print("Profileimg: ${widget.profileimg}");
                          print("uploadIDImg: ${widget.uploadID}");
                          print("ProofIDImg: ${base64ProofID}");
                          print("name: ${widget.firstname}");
                          print("name: ${widget.lastname}");
                          print("email: ${widget.email}");
                          print("number: ${widget.phonenumber}");
                          print("pass: ${widget.password}");

                          await employeeRegisterUser();

                          if(employeeSignupModel.status == "success"){

                            // SharedPreferences sharedPref = await SharedPreferences.getInstance();
                            // await sharedPref.setString('user_email', "${customerSignupModel.data?.email.toString()}");
                            // await sharedPref.setString('phoneNumber', "${customerSignupModel.data?.phone.toString()}");
                            // await sharedPref.setString('firstName', "${customerSignupModel.data?.firstName.toString()}");
                            // await sharedPref.setString('lastName', "${customerSignupModel.data?.lastName.toString()}");
                            // await sharedPref.setString('profilePic', "${customerSignupModel.data?.profilePic.toString()}");
                            // await sharedPref.setString('usersCustomersId', "${customerSignupModel.data?.usersCustomersId.toString()}");
                            // await sharedPref.setString('password', "${customerSignupModel.data?.password.toString()}");

                            Future.delayed(const Duration(seconds: 2), () {
                              // Get.to(LoginTabClass(login: 0,));
                              Get.to(Emp_EmailVerification(otpVerify:  employeeSignupModel.data?.otpdetails?.otp,));
                              toastSuccessMessage("${employeeSignupModel.data?.message}", Colors.green);
                              setState(() {
                                isInAsyncCall = false;
                              });
                              print("false: $isInAsyncCall");
                            });
                          } else if  (employeeSignupModel.status != "success"){
                            toastFailedMessage("${employeeSignupModel.message}", Colors.red);
                            setState(() {
                              isInAsyncCall = false;
                            });
                          } else{
                            toastFailedMessage("${employeeSignupModel.message}",  Colors.red);
                          }
                        }
                      }
                    },
                    child: isInAsyncCall
                        ? loadingBar(context)
                        : mainButton("Sign Up", Color(0xff2B65EC), context)),
                SizedBox(
                  height: height * 0.04,
                ),
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }

  File? uploadProofID;
  String? base64ProofID;

  Future pickUploadProofId() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? xFile = await _picker.pickImage(source: ImageSource.gallery);
      if (xFile == null) return;

      Uint8List imageByte = await xFile.readAsBytes();
      base64ProofID = base64.encode(imageByte);
      print("base64ID $base64ProofID");

      final imageTemporary = File(xFile.path);

      setState(() {
        uploadProofID = imageTemporary;
        print("newImage $uploadProofID");
      });
    } on PlatformException catch (e) {
      print('Failed to pick uploadID: ${e.toString()}');
    }
  }
}
