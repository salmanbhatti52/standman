import 'dart:convert';
import 'dart:io';
import 'package:StandMan/Pages/EmpBottombar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../Models/update_profile_employee_Model.dart';
import '../../../Utils/api_urls.dart';
import '../../../widgets/MyButton.dart';
import '../../../widgets/ToastMessage.dart';
import '../../../widgets/TopBar.dart';
import '../../Customer/HomePage/HomePage.dart';
class EmpEditProfile extends StatefulWidget {
  final String? email, firstname, lastname, phone, profilePic;
   EmpEditProfile({Key? key, this.email, this.firstname,
    this.lastname, this.phone, this.profilePic}) : super(key: key);

  @override
  State<EmpEditProfile> createState() => _EmpEditProfileState();
}

class _EmpEditProfileState extends State<EmpEditProfile> {

  int _selected = 0;

  _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('value', _selected);
  }

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? count = prefs.getInt("value");
    return count;
  }


  checkvalue() async {
    int count = await _getData() ?? 0;
    setState(() {
      _selected = count;
    });
  }

  UpdateProfileEmployeeModel updateProfileEmployeeModel =
  UpdateProfileEmployeeModel();
  final key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isInAsyncCall = false;
  bool progress = false;

  // sharedPrefs() async {
  //   // loading = true;
  //   setState(() {});
  //   print('in LoginPage shared prefs');
  //   prefs = await SharedPreferences.getInstance();
  //   userEmail = (prefs!.getString('empUser_email'));
  //   phoneNumber = (prefs!.getString('empPhoneNumber'));
  //   fullName = (prefs!.getString('empFullName'));
  //   profilePic1 = (prefs!.getString('empProfilePic'));
  //   usersCustomersId = prefs?.getString('empUsersCustomersId');
  //   print("userId in Prefs is = $usersCustomersId");
  //   print("userEmail in Profile is = $userEmail");
  //
  //   SharedPreferences sharedPref = await SharedPreferences.getInstance();
  //   await sharedPref.setString('_selectedC', "${_selected}");
  //   _selected = "${(prefs!.getString('_selectedC'))}" as int;
  // }


  setData() {
    nameController.text = "${widget.firstname}${widget.lastname}";
    emailController.text = "${widget.email}";
    phoneController.text = "${widget.phone}";

    print("firstName ${nameController.text}");
    print("email ${emailController.text}");
    print("phone ${phoneController.text}");
  }

  editUserProfileWidget() async {
    progress = true;
    setState(() {});
    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs?.getString('empUsersCustomersId');
    print("userId in Prefs is = $usersCustomersId");
    // try {
    String apiUrl = updateEmployeeProfileApiUrl;
    print("editUserProfileApi: $apiUrl");
    print("usersCustomersId: $usersCustomersId");
    print("nameController: ${nameController.text}");
    print("emailController: ${emailController.text}");
    print("phoneController: ${phoneController.text}");
    print("baseProfileImage: ${base64img ?? ""}");

    final response = await http.post(Uri.parse(apiUrl), body: {
      "users_customers_id": usersCustomersId,
      "company_name": "Test Company",
      "first_name": widget.firstname,
      "last_name": widget.lastname,
      "phone": phoneController.text,
      "email": emailController.text,
      "notifications": "Yes",
      "profile_pic": " ",
    }, headers: {
      'Accept': 'application/json'
    });
    print('${response.statusCode}');
    print(response);
    if (response.statusCode == 200) {
      final responseString = response.body;
      print("editUserProfileResponse: ${responseString.toString()}");
      updateProfileEmployeeModel =
          updateProfileEmployeeModelFromJson(responseString);
      progress = false;
      setState(() {});
    }
  }

    @override
    void initState() {
      print("name: ${widget.firstname}${widget.lastname}");
      print("email: ${widget.email}");
      print("phone: ${widget.phone}");
      print("profilePic: ${widget.profilePic}");
      // TODO: implement initState
      super.initState();
      checkvalue();
      setData();
    }


    @override
    Widget build(BuildContext context) {
      var height = MediaQuery
          .of(context)
          .size
          .height;
      var width = MediaQuery
          .of(context)
          .size
          .width;
      return Scaffold(
        appBar: StandManAppBar1(title: "Edit Profile",
          bgcolor: Color(0xfffffff),
          titlecolor: Colors.black,
          iconcolor: Colors.black,),
        body:
        // ModalProgressHUD(
        //   inAsyncCall: progress,
        //   opacity: 0.02,
        //   blur: 0.5,
        //   color: Colors.transparent,
        //   progressIndicator: CircularProgressIndicator(
        //       color: Colors.blueAccent),
        //   child:
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                child: CircleAvatar(
                                  radius: height * 0.08,
                                  backgroundColor:
                                  Colors.transparent,
                                  backgroundImage: imagePath == null
                                      ? NetworkImage(
                                      widget.profilePic.toString())
                                      : Image
                                      .file(
                                    imagePath!,
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.contain,
                                  )
                                      .image,
                                ),
                              ),
                              Positioned(
                                // top: 80,
                                right: 1,
                                bottom: 0,
                                child: GestureDetector(
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
                                              width: 360,
                                              height: height * 0.22, // 321,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      "Photo cannot be edited. Please\ncontact us if you want to update your photo.",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(0, 0, 0, 1),
                                                        fontFamily: "Outfit",
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w500,
                                                        // letterSpacing: -0.3,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    SizedBox(height: height * 0.02,),
                                                    GestureDetector(onTap:(){
                                                      Get.back();
                                                    } ,child: smallButton("OK", Color(0xff2B65EC), context))
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // Positioned(
                                            //     top: -48,
                                            //     child: Container(
                                            //       // width: width,
                                            //       //106,
                                            //       height: height * 0.13,
                                            //       //106,
                                            //       decoration: BoxDecoration(
                                            //         shape: BoxShape.circle,
                                            //         color: Color(0xffFF9900),
                                            //       ),
                                            //       child: Icon(
                                            //         Icons.add_alert,
                                            //         size: 40,
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
                                      border: Border.all(
                                          color: Colors.white, width: 1.5),
                                    ),
                                    child: Center(
                                        child:
                                        SvgPicture.asset(
                                            "assets/images/camera.svg")),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Form(
                            key: key,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: const Text(
                                    "Full Name",
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
                                TextFormField(
                                  controller: nameController,
                                  readOnly: true,
                                  onTap: (){
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
                                              height: height * 0.2, // 321,
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
                                                    const Text(
                                                      "Please contact support to edit your legal name.",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(0, 0, 0, 1),
                                                        fontFamily: "Outfit",
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w500,
                                                        // letterSpacing: -0.3,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    SizedBox(height: height * 0.02,),
                                                    GestureDetector(onTap:(){
                                                      Get.back();
                                                    } ,child: smallButton("OK", Color(0xff2B65EC), context))
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // Positioned(
                                            //     top: -48,
                                            //     child: Container(
                                            //       // width: width,
                                            //       //106,
                                            //       height: height * 0.13,
                                            //       //106,
                                            //       decoration: BoxDecoration(
                                            //         shape: BoxShape.circle,
                                            //         color: Color(0xffFF9900),
                                            //       ),
                                            //       child: Icon(
                                            //         Icons.add_alert,
                                            //         size: 40,
                                            //         color: Colors.white,
                                            //       ),
                                            //     ))
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: Color(0xff000000),
                                    fontFamily: "Outfit",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                  ),
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    // contentPadding: const EdgeInsets.only(top: 12.0),
                                    hintText: "${widget.firstname}${widget.lastname}",
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Outfit",
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16,
                                    ),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child:
                                      SvgPicture.asset(
                                          "assets/images/profile-2.svg"),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0),
                                child: const Text(
                                  "Email",
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
                              TextFormField(
                                controller: emailController,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Color(0xff000000),
                                  fontFamily: "Outfit",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                ),
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                      top: 12.0),
                                  hintText: "${widget.email}",
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Outfit",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                  ),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SvgPicture.asset(
                                        "assets/images/wallet-2.svg"),
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
                                  color: Color(0xffBFBFBF),
                                  fontFamily: "Outfit",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                                decoration: InputDecoration(
                                  hintText: "${widget.phone}",
                                  contentPadding: EdgeInsets.only(top: 12.0),
                                  hintStyle: TextStyle(
                                    fontFamily: "Outfit",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                    color: Color(0xff000000),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Color(0xff2B65EC),
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Color(0xffBFBFBF),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                // initialCountryCode: 'IN',
                                onChanged: (phone) {
                                  print(phone.completeNumber);
                                },
                                // onCountryChanged: (country) {
                                //   print('Country changed to: ' + country.name);
                                // },
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0),
                                child: const Text(
                                  "Gender",
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                children: <Widget>[
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _saveData();
                                          _selected = 1;
                                        });
                                      },
                                      child: Container(
                                          width: 82,
                                          height: 52,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                12.0),
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Color(0xffF3F3F3),),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: [
                                              SvgPicture.asset(
                                                _selected == 1
                                                    ? "assets/images/Ring.svg"
                                                    : "assets/images/Ring2.svg",
                                              ),
                                              const Text(
                                                "   Male",
                                                style: TextStyle(
                                                  color: Color(0xffA7A9B7),
                                                  fontFamily: "Outfit",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300,
                                                  // letterSpacing: -0.3,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _saveData();
                                          _selected = 2;
                                        });
                                      },
                                      child: Container(
                                          width: 82,
                                          height: 52,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                12.0),
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Color(0xffF3F3F3),),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: [
                                              SvgPicture.asset(
                                                _selected == 2
                                                    ? "assets/images/Ring.svg"
                                                    : "assets/images/Ring2.svg",
                                              ),
                                              const Text(
                                                "   Female",
                                                style: TextStyle(
                                                  color: Color(0xffA7A9B7),
                                                  fontFamily: "Outfit",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300,
                                                  // letterSpacing: -0.3,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _saveData();
                                          _selected = 3;
                                        });
                                      },
                                      child: Container(
                                          width: 82,
                                          height: 52,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                12.0),
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Color(0xffF3F3F3),),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: [
                                              SvgPicture.asset(
                                                _selected == 3
                                                    ? "assets/images/Ring.svg"
                                                    : "assets/images/Ring2.svg",
                                              ),
                                              const Text(
                                                "   Other",
                                                style: TextStyle(
                                                  color: Color(0xffA7A9B7),
                                                  fontFamily: "Outfit",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300,
                                                  // letterSpacing: -0.3,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.1,
                          ),
                          GestureDetector(
                            onTap: () async {
                              fullName = nameController.text;
                              print("fullName $fullName");
                              setState(() {
                                isInAsyncCall = true;
                              });
                              await editUserProfileWidget();

                              if (updateProfileEmployeeModel.status ==
                                  "success") {
                                Future.delayed(const Duration(seconds: 3), () {
                                  toastSuccessMessage("success", Colors.green);
                                  Get.to(Empbottom_bar(currentIndex: 0,));
                                  setState(() {
                                    isInAsyncCall = false;
                                  });
                                  print("false: $isInAsyncCall");
                                });
                              }
                              if (updateProfileEmployeeModel.status !=
                                  "success") {
                                toastFailedMessage(
                                    updateProfileEmployeeModel.message,
                                    Colors.red);
                                setState(() {
                                  isInAsyncCall = false;
                                });
                              }
                            },
                            child:isInAsyncCall
                                ?  loadingBar(context)
                                : mainButton(
                                "Update Profile", Color(0xff2B65EC), context),
                          ),
                          SizedBox(height: height * 0.04,),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        // ),
      );
    }
  File? imagePath;
  String? base64img;

  Future pickCoverImage() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? xFile = await _picker.pickImage(
          source: ImageSource.gallery);
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
}
