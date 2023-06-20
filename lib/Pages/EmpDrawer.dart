import 'package:StandMan/Pages/Authentication/Login_tab_class.dart';
import 'package:StandMan/Pages/EmpBottombar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/users_profilet_model.dart';
import '../Utils/api_urls.dart';
import 'Emp_notification.dart';
import 'Employee/HomePage/EmpHomePage.dart';
import 'PrivacyPolicy.dart';
import 'TermConditions.dart';
import 'package:http/http.dart' as http;

class EmpDrawer extends StatefulWidget {
  const EmpDrawer({Key? key}) : super(key: key);

  @override
  State<EmpDrawer> createState() => _EmpDrawerState();
}

class _EmpDrawerState extends State<EmpDrawer> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserProfileWidget();
  }

  UsersProfileModel usersProfileModel = UsersProfileModel();
  bool progress = false;
  bool isInAsyncCall = false;

  getUserProfileWidget() async {

    empPrefs = await SharedPreferences.getInstance();
    empUsersCustomersId = empPrefs!.getString('empUsersCustomersId');
    print("userId in empPrefs is = $empUsersCustomersId");
    // try {
      String apiUrl = usersProfileApiUrl;
      print("getUserProfileApi: $apiUrl");
      final response = await http.post(Uri.parse(apiUrl),
          body: {
            "users_customers_id": empUsersCustomersId,
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
        setState(() {});
        // print("getUserProfileImage: $baseUrlImage${usersProfileModel.data!.profilePic}");
      }
    // } catch (e) {
    //   print('Error in getUserProfileWidget: ${e.toString()}');
    // }
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
          width: MediaQuery.of(context).size.width*0.5,
          decoration: BoxDecoration(
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
              ),
          ),
        ),
      )
        : usersProfileModel.status != "success"
        ? Center(
        child: Text('no data found...',
            style: TextStyle(fontWeight: FontWeight.bold)))
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
                  CircleAvatar(
                    // radius: (screenWidth > 600) ? 90 : 70,
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      backgroundImage: usersProfileModel.data!.usersCustomersId.toString() == null
                          ? Image.asset("assets/images/person2.png").image
                          : NetworkImage(baseUrlImage+usersProfileModel.data!.profilePic.toString())
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
                Get.to(Empbottom_bar(currentIndex: 0,));
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
                Get.to(EmpNotificationPage());
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
            SizedBox(
              height: height * 0.2,
            ),
            GestureDetector(
              onTap: (){
                removeDataFormSharedPreferences();
                setState(() {});
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginTabClass(login: 1,),),);
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
    await prefs.clear();
    setState(() {});
  }

}
