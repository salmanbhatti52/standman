import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widgets/MyButton.dart';
import '../../../widgets/ToastMessage.dart';
import '../../../widgets/TopBar.dart';
import '../../Bottombar.dart';
import '../../EmpBottombar.dart';
import 'EmpWorkProf.dart';

class EMp_UploadPhoto extends StatefulWidget {
  final String? profileimg;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? phonenumber;
  final String? password;
  // final String? confirmpassword;

  const EMp_UploadPhoto(
      {Key? key,
      this.email,
      this.profileimg,
      this.phonenumber,
      this.password, this.firstname, this.lastname,
      // this.confirmpassword
      })
      : super(key: key);

  @override
  State<EMp_UploadPhoto> createState() => _EMp_UploadPhotoState();
}

class _EMp_UploadPhotoState extends State<EMp_UploadPhoto> {
  final key = GlobalKey<FormState>();
  bool isInAsyncCall = false;

  void initState() {
    print("Profileimg: ${widget.profileimg}");
    print("name: ${widget.firstname}");
    print("name: ${widget.lastname}");
    print("email: ${widget.email}");
    print("number: ${widget.phonenumber}");
    print("pass: ${widget.password}");
    // print("confpass: ${widget.confirmpassword}");
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: StandManAppBar1(
        title: "Upload Photo ID",
        bgcolor: Color(0xfffffff),
        titlecolor: Colors.black,
        iconcolor: Colors.black,
      ),
      // drawer: MyDrawer(),
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
          child: Column(children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 0.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       GestureDetector(
            //           onTap: () {
            //             Get.back();
            //           },
            //           child: SvgPicture.asset("assets/images/left.svg")),
            //       // SizedBox(width: width * 0.3,),
            //       Text(
            //         "Upload Photo ID",
            //         style: TextStyle(
            //           fontFamily: "Outfit",
            //           fontWeight: FontWeight.w500,
            //           fontSize: 18,
            //         ),
            //         textAlign: TextAlign.center,
            //       ),
            //       Text("        "),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: height * 0.04,
            // ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Text(
                "List of Acceptable Identity Documents",
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  fontFamily: "Outfit",
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.left,
              ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0 ,),
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
                          padding: const EdgeInsets.only(left: 8.0, ),
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
                      ],
                    ),
                  ),
                  SizedBox(height: 3,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0 ,),
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
                          padding: const EdgeInsets.only(left: 8.0, ),
                          child: Text(
                            "PR Card",
                            style: TextStyle(
                                fontFamily: "Outfit",
                                fontSize: 16,
                                color: Color(0xff222222).withOpacity(0.5),
                                fontWeight: FontWeight.w300),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 3,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0 , ),
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
                          padding: const EdgeInsets.only(left: 8.0, ),
                          child: Text(
                            "Driver’s Licence",
                            style: TextStyle(
                                fontFamily: "Outfit",
                                fontSize: 16,
                                color: Color(0xff222222).withOpacity(0.5),
                                fontWeight: FontWeight.w300),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 3,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0 ,),
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
                          padding: const EdgeInsets.only(left: 8.0, ),
                          child: Text(
                            "Photo(ID) Card",
                            style: TextStyle(
                                fontFamily: "Outfit",
                                fontSize: 16,
                                color: Color(0xff222222).withOpacity(0.5),
                                fontWeight: FontWeight.w300),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 15),
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
                  //
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
                      child: uploadID == null
                          ? GestureDetector(
                              onTap: () {
                                pickUploadId();
                              },
                              child: Center(
                                  child: SvgPicture.asset(
                                "assets/images/upload.svg",
                                width: 75,
                                height: 52,
                              )))
                          : Image.file(uploadID!,
                              width: 75, height: 52, fit: BoxFit.fill),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  GestureDetector(
                      onTap: () {
                        if (key.currentState!.validate()) {
                          if (uploadID == null) {
                            toastFailedMessage('Image required', Colors.red);
                          } else {
                            // print("otp: ${widget.data}");
                            // print("otp: ${OTpCode}");
                            print("email: ${widget.email}");

                            // setState(() {
                            //   isInAsyncCall = true;
                            // });
                            if (uploadID != null) {
                              // Future.delayed(const Duration(seconds: 3), () {
                              //   toastSuccessMessage("success", Colors.green);
                                Get.to(WorkProof(
                                  profileimg: widget.profileimg,
                                  firstname: widget.firstname,
                                  lastname: widget.lastname,
                                  email: widget.email,
                                  phonenumber: widget.phonenumber,
                                  password: widget.password,
                                  uploadID: base64ID,
                                ));
                                // setState(() {
                                //   isInAsyncCall = false;
                                // });
                                // print("false: $isInAsyncCall");
                              // });
                            }
                          }
                        }
                      },
                      child: mainButton("Next", Color(0xff2B65EC), context)),
                  SizedBox(
                    height: height * 0.04,
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  File? uploadID;

  String? base64ID;

  Future pickUploadId() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? xFile = await _picker.pickImage(source: ImageSource.gallery);
      if (xFile == null) return;

      Uint8List imageByte = await xFile.readAsBytes();
      base64ID = base64.encode(imageByte);
      print("base64ID $base64ID");

      final imageTemporary = File(xFile.path);

      setState(() {
        uploadID = imageTemporary;
        print("newImage $uploadID");
      });
    } on PlatformException catch (e) {
      print('Failed to pick uploadID: ${e.toString()}');
    }
  }
}
