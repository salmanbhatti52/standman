import 'package:StandMan/Pages/Authentication/Login_tab_class.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Models/users_profilet_model.dart';
import '../../../Utils/api_urls.dart';
import '../../Drawer.dart';
import '../HomePage/HomePage.dart';
import 'ChangePassword.dart';
import 'DeleteAccount.dart';
import 'EditProfile.dart';
import 'NotificationSettings.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedPrefs();
  }

  sharedPrefs() async {
    // loading = true;
    setState(() {});
    print('in LoginPage shared prefs');
    prefs = await SharedPreferences.getInstance();
    // userId = (prefs!.getString('userid'));
    userEmail = (prefs!.getString('user_email'));
    phoneNumber = (prefs!.getString('phoneNumber'));
    fullName = (prefs!.getString('fullName'));
    // profilePic1 = (prefs!.getString('profilePic'));
    password = (prefs!.getString('password'));
    usersCustomersId = prefs!.getString('usersCustomersId');
    print("userId in Prefs is = $usersCustomersId");
    print("oldpass = $password");
    getUserProfileWidget();
    // userFirstName = (prefs!.getString('user_first_name'));
    // userLastName = (prefs!.getString('user_last_name'));
    // print("userId in LoginPrefs is = $userId");
    print("userEmail in Profile is = $userEmail");
    print("userprofilePic in Profile is = $profilePic1");
    // print("userFirstName in LoginPrefs is = $userFirstName $userLastName");
  }

  UsersProfileModel usersProfileModel = UsersProfileModel();
  bool progress = false;
  bool isInAsyncCall = false;

  getUserProfileWidget() async {
    progress = true;
    setState(() {});
    try {
      String apiUrl = usersProfileApiUrl;
      print("getUserProfileApi: $apiUrl");
      final response = await http.post(Uri.parse(apiUrl),
          body: {
        "users_customers_id": usersCustomersId.toString(),
      }, headers: {
        'Accept': 'application/json'
      });
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("getUserProfileResponse: ${responseString.toString()}");
        usersProfileModel = usersProfileModelFromJson(responseString);
        print("getUserName: ${usersProfileModel.data!.lastName}");
        print("getUserEmail: ${usersProfileModel.data!.email}");
        print("getUserEmail: ${usersProfileModel.data!.email}");
        print("getUserNumber: ${usersProfileModel.data!.phone}");
        print("usersCustomersId: ${usersProfileModel.data!.usersCustomersId}");
        print(
            "getUserProfileImage: $baseUrlImage${usersProfileModel.data!.profilePic}");
      }
    } catch (e) {
      print('Error in getUserProfileWidget: ${e.toString()}');
    }
    progress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        toolbarHeight: height * 0.10,
        backgroundColor: Color(0xfffffff),
        elevation: 0,
        centerTitle: true,
        // leading: IconButton(
        //   icon: Icon(Icons.menu, color: Colors.black,),
        //   onPressed: () {
        //     // Do something
        //     // Get.to(MyDrawer());
        //   },
        // ),
        title: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Text(
            "Profile",
            style: TextStyle(
              color: Color(0xff000000),
              fontFamily: "Outfit",
              fontSize: 18,
              fontWeight: FontWeight.w500,
              // letterSpacing: -0.3,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0, top: 0.0),
            child: GestureDetector(
              onTap: () {
                Get.to(EditProfile(
                  email: usersProfileModel.data!.email.toString(),
                  phone: usersProfileModel.data!.phone.toString(),
                  firstname: "${usersProfileModel.data!.firstName}",
                  lastname: "${usersProfileModel.data!.lastName}",
                  profilePic: "$baseUrlImage${usersProfileModel.data!.profilePic.toString()}",
                ),
                );
              },
              child: SvgPicture.asset("assets/images/edit-2.svg"),
            ),
          ),
        ],
        // leading: SvgPicture.asset(
        //     "assets/images/menubl.svg",
        //   width: 20,
        //   height: 20,
        // ),
      ),
      // drawer: MyDrawer(),
      // backgroundColor: Colors.white,
      body:
      progress
          ? Center(child: CircularProgressIndicator(color: Colors.blueAccent))
          : usersProfileModel.status != "success"
              ? Center(
                  child: Text('no data found...',
                      style: TextStyle(fontWeight: FontWeight.bold)))
              :
      ModalProgressHUD(
        inAsyncCall: isInAsyncCall,
        opacity: 0.02,
        blur: 0.5,
        color: Colors.transparent,
        progressIndicator: CircularProgressIndicator(
          color: Colors.blue,
        ),
        child:
      SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Container(
                          width: width * 0.9, // 351,
                          height: height * 0.18, // 131,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xff2B65EC),
                          ),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: width * 0.05,
                              ),
                              // Image.asset("assets/images/person2.png", width: 99, height: 99,),
                              // CircleAvatar(
                              //   radius: 50,
                              //   backgroundColor: Colors.transparent,
                              //     backgroundImage: AssetImage("assets/images/person2.png"),
                              // ),

                              CircleAvatar(
                                  // radius: (screenWidth > 600) ? 90 : 70,
                                  radius: 50,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: usersProfileModel.data!.usersCustomersId.toString() == null
                                      ? Image.asset("assets/images/person2.png").image
                                      : NetworkImage(baseUrlImage+usersProfileModel.data!.profilePic.toString())
                                  // NetworkImage(baseUrlImage+ getUserProfileModelObject.data!.profilePic!)

                                  ),
                          // CachedNetworkImage(
                          //   imageUrl: (baseUrlImage + usersProfileModel.data!.profilePic.toString()),
                          //   imageBuilder: (context, imageProvider) => Container(
                          //     height: 171,
                          //     width: 171,
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(16),
                          //       color: Colors.black,
                          //       image: DecorationImage(
                          //         image: imageProvider,
                          //         fit: BoxFit.fill,
                          //       ),
                          //     ),
                          //   ),
                          //   placeholder: (context, url) => const CircularProgressIndicator(),
                          //   errorWidget: (context, url, error) => Container(
                          //     height: 171,
                          //     width: 171,
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(16),
                          //       color: Colors.black,
                          //       image: DecorationImage(
                          //         image: Image.asset("assets/images/person2.png").image,
                          //         fit: BoxFit.fill,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${usersProfileModel.data!.firstName} ${usersProfileModel.data!.lastName}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Outfit",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Row(
                                      // mainAxisAlignment:
                                          // MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/images/sms-tracking.svg",
                                          color: Colors.white,
                                        ),
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context).size.width * 0.45),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: AutoSizeText(
                                              "${usersProfileModel.data!.email}",
                                              style: TextStyle(fontSize: 16.0, color: Colors.white),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,

                                            ),
                                          ),
                                        ),
                                        // Text(
                                        //     "  ${usersProfileModel.data!.email}",
                                        //     style: TextStyle(
                                        //       color: Color(0xffffffff),
                                        //       fontFamily: "Outfit",
                                        //       fontWeight: FontWeight.w300,
                                        //       fontSize: 14,
                                        //     ),
                                        //   ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/images/call.svg",
                                        color: Colors.white,
                                        width: 16,
                                        height: 16,
                                      ),
                                      Text(
                                        "  ${usersProfileModel.data!.phone.toString()}",
                                        style: TextStyle(
                                          color: Color(0xffffffff),
                                          fontFamily: "Outfit",
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Row(
                            children: [
                              Text(
                                "Settings",
                                style: TextStyle(
                                  fontFamily: "Outfit",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            ChangePassword(context, userEmail, password);
                            print("useremail123 $userEmail");
                            print("oldpass123 $password");
                          },
                          child: Container(
                            width: width, //350,
                            height: height * 0.060, // 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 20,
                                    spreadRadius: 0,
                                    offset: Offset(0, 2),
                                    color: Color.fromRGBO(67, 169, 183, 0.1),
                                  ),
                                ]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/lock.svg",
                                    color: Color(0xff2B65EC),
                                  ),
                                  const Text(
                                    "Change password",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Outfit",
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.2,
                                  ),
                                  SvgPicture.asset(
                                    "assets/images/chevron-left.svg",
                                  ),
                                  // Svg
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {
                            NotificationSettings(context);
                          },
                          child: Container(
                            width: width, //350,
                            height: height * 0.060, // 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 20,
                                    spreadRadius: 0,
                                    offset: Offset(0, 2),
                                    color: Color.fromRGBO(67, 169, 183, 0.1),
                                  ),
                                ]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/notification.svg",
                                    color: Color(0xff2B65EC),
                                  ),
                                  const Text(
                                    "Notifications setting",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Outfit",
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.17,
                                  ),
                                  SvgPicture.asset(
                                    "assets/images/chevron-left.svg",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {
                            DeleteAccount(context);
                          },
                          child: Container(
                            width: width, //350,
                            height: height * 0.060, // 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 20,
                                    spreadRadius: 0,
                                    offset: Offset(0, 2),
                                    color: Color.fromRGBO(67, 169, 183, 0.1),
                                  ),
                                ]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/trash.svg",
                                    color: Color(0xff2B65EC),
                                  ),
                                  const Text(
                                    "Delete account",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Outfit",
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.24,
                                  ),
                                  SvgPicture.asset(
                                    "assets/images/chevron-left.svg",
                                  ),
                                  // Svg
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {
                            // removeDataFormSharedPreferences();
                            // setState(() {});
                            // Navigator.pushReplacement(context,
                            //     MaterialPageRoute(builder: (context) => LoginTabClass()));
                            showLogoutAlertDialog(context);
                          },
                          child: Container(
                            width: width, //350,
                            height: height * 0.060, // 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 20,
                                    spreadRadius: 0,
                                    offset: Offset(0, 2),
                                    color: Color.fromRGBO(67, 169, 183, 0.1),
                                  ),
                                ]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/logout.svg",
                                    color: Color(0xff2B65EC),
                                  ),
                                  SizedBox(
                                    width: width * 0.055,
                                  ),
                                  const Text(
                                    "Sign Out",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Outfit",
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16,
                                    ),
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
      ),
    );
  }

  showLogoutAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
      child: Text('Cancel'),
    );
    Widget continueButton = TextButton(
      child: Text('Yes, Continue'),
      onPressed: () {
        removeDataFormSharedPreferences();
        setState(() {});
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginTabClass(login: 0,)),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Sign Out"),
      content: Text("Are you sure you want to Sign Out ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  removeDataFormSharedPreferences() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {});
  }
}
