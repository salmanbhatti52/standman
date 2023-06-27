import 'dart:convert';

import 'package:StandMan/Pages/Authentication/Customer/login_page.dart';
import 'package:StandMan/Pages/Authentication/Login_tab_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/ChatStartwithAdminModel.dart';
import '../Models/chat_start_user_Model.dart';
import '../Models/users_profilet_model.dart';
import '../Utils/api_urls.dart';
import '../widgets/MyButton.dart';
import 'Bottombar.dart';
import 'Customer/Customer_Services/Chat_with_Admin.dart';
import 'Customer/HomePage/HomePage.dart';
import 'NotificationPage.dart';
import 'PrivacyPolicy.dart';
import 'TermConditions.dart';
import 'package:http/http.dart' as http;

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   sharedPrefs();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserProfileWidget();
    sharedPrefs();
  }


  sharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    adminID = prefs!.getString('adminID');
    print("get_admin = $adminID");
  }

  UsersProfileModel usersProfileModel = UsersProfileModel();

  bool progress = false;
  bool isInAsyncCall = false;

  getUserProfileWidget() async {
    // try {
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
        progress = false;
        setState(() {});
      }
    // } catch (e) {
    //   print('Error in getUserProfileWidget: ${e.toString()}');
    // }
  }

  ChatStartwithAdminModel chatStartwithAdminModel = ChatStartwithAdminModel();

  chatStartUser() async {
    prefs = await SharedPreferences.getInstance();
    adminID = prefs!.getString('adminID');
    usersCustomersId = prefs!.getString('usersCustomersId');
    print("usersCustomersId = $usersCustomersId");
    print("getAdmin = $adminID");

    // try {
    String apiUrl = userChatLiveApiUrl;
    print("userChatLiveApiUrl: $apiUrl");
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        "requestType": "startChat",
        "users_customers_id": usersCustomersId,
        "other_users_customers_id": adminID,
      },
      headers: {'Accept': 'application/json'},
    );
    print('${response.statusCode}');
    print(response);
    print("userChatLive: $response");
    print("status Code chat: ${response.statusCode}");
    if (response.statusCode == 200) {
      final responseString = response.body;
      print("userChatResponse: ${responseString.toString()}");
      chatStartwithAdminModel = chatStartwithAdminModelFromJson(responseString);
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return
      progress
          ? Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              height: MediaQuery.of(context).size.height*0.06,
              // height: 48,
              width: MediaQuery.of(context).size.width*0.5,
              decoration: BoxDecoration(
                // color: Color(0xff4DA0E6),
                  color: Color.fromRGBO(43, 101, 236, 1),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 0,
                        blurRadius: 15,
                        offset: Offset(1 , 10),
                        color: Color.fromRGBO(7, 1, 87, 0.1)
                    ),
                  ]
              ),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.white,),
                  SizedBox(width: 10,),
                  Text(
                    "loading",
                    style: TextStyle(
                        fontFamily: "Outfit",
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
                ],
              )),
            ),
          )
          : usersProfileModel.status != "success"
          ? Center(
          child: Text('',
              style: TextStyle(fontWeight: FontWeight.bold),),)
          :
      Drawer(
      width: width * 0.7,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25.0 , right: 20),
                    child: SvgPicture.asset("assets/images/menubl.svg",),
                  ),
                ),
                // Center(child: Image.asset("assets/images/person2.png")),
                Center(
                  child:
                  // CircleAvatar(
                  //   // radius: (screenWidth > 600) ? 90 : 70,
                  //     radius: 50,
                  //     backgroundColor: Colors.transparent,
                  //     backgroundImage: profilePic1 == null
                  //         ? Image.asset("assets/images/person2.png").image
                  //         : NetworkImage(baseUrlImage + profilePic1!)
                  //   // NetworkImage(baseUrlImage+ getUserProfileModelObject.data!.profilePic!)
                  //
                  // ),
                  // CircleAvatar(
                  //   // radius: (screenWidth > 600) ? 90 : 70,
                  //     radius: 50,
                  //     backgroundColor: Colors.transparent,
                  //     backgroundImage: usersProfileModel.data!.usersCustomersId.toString() == null
                  //         ? Image.asset("assets/images/person2.png").image
                  //         : NetworkImage(baseUrlImage+usersProfileModel.data!.profilePic.toString())
                  //   // NetworkImage(baseUrlImage+ getUserProfileModelObject.data!.profilePic!)
                  //
                  // ),
                  CircleAvatar(
                      // progress
                      //     ? Center(child: CircularProgressIndicator(color: Colors.transparent))
                      //     : usersProfileModel.status != "success"
                      //     ? Center(
                      //     child: Text('no data found...',
                      //         style: TextStyle(fontWeight: FontWeight.bold)))
                      //     :
                    // radius: (screenWidth > 600) ? 90 : 70,
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      backgroundImage: usersProfileModel.data!.usersCustomersId.toString() == null
                          ? Image.asset("assets/images/person2.png").image
                          : NetworkImage(
                          baseUrlImage+usersProfileModel.data!.profilePic.toString())
                    // NetworkImage(baseUrlImage+ getUserProfileModelObject.data!.profilePic!)

                  ),
                ),
                SizedBox(height: 10,),
                Center(
                  child:  Text(
                    "${usersProfileModel.data!.firstName} ${usersProfileModel.data!.lastName}",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Outfit",
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/images/sms-tracking.svg"),
                     Text(
                       "${usersProfileModel.data!.email}",
                      style: TextStyle(
                        color: Color(0xffA7A9B7),
                        fontFamily: "Outfit",
                        fontWeight: FontWeight.w300,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: height * 0.04,
            ),
            GestureDetector(
              onTap: (){
                Get.to(bottom_bar(currentIndex: 0,));
                // Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: SvgPicture.asset("assets/images/home.svg"),
                  title: Text(
                    "Home",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Outfit",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Get.to(NotificationPage());
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: SvgPicture.asset("assets/images/Notification2.svg"),
                  title: Text(
                    "Notifications",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Outfit",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Get.to(PrivacyPolicy());
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: SvgPicture.asset("assets/images/Security.svg"),
                  title: Text(
                    "Privacy Policy",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Outfit",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Get.to(TermsandConditions());
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: SvgPicture.asset("assets/images/Security.svg"),
                  title: Text(
                    "Terms & Conditions",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Outfit",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await chatStartUser();
                Get.to(ChatWithAdmin());
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: Image.asset("assets/images/customer.png", color: Colors.grey, width: 30,),
                  title: Text(
                    "Customer Services",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Outfit",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.18,
            ),
            GestureDetector(
              onTap: (){
                removeDataFormSharedPreferences();
                setState(() {});
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginTabClass(login: 0,)));
                // Get.to(LoginTabClass());
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: SvgPicture.asset("assets/images/logout.svg"),
                  title: Text(
                    "Sign Out",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Outfit",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  removeDataFormSharedPreferences() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    // await usersCustomersId.clear();
    await prefs.clear();
    setState(() {});
  }
}
