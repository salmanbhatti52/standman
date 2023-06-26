import 'package:StandMan/Pages/Authentication/Login_tab_class.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../Models/users_profilet_model.dart';
import '../../../Utils/api_urls.dart';
import '../../Customer/HomePage/HomePage.dart';
import '../HomePage/EmpHomePage.dart';
import 'EMp_ChangePassword.dart';
import 'EMp_DeleteAccount.dart';
import 'EMp_NotificationSettings.dart';
import 'package:http/http.dart' as http;

class EmpProfilePage extends StatefulWidget {
  const EmpProfilePage({Key? key}) : super(key: key);

  @override
  State<EmpProfilePage> createState() => _EmpProfilePageState();
}

class _EmpProfilePageState extends State<EmpProfilePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserProfileWidget();
  }

  sharedPrefs() async {
    // loading = true;
    print('in LoginPage shared prefs');
    empPrefs = await SharedPreferences.getInstance();
    // userId = (prefs!.getString('userid'));
    empUserEmail = (empPrefs!.getString('empUser_email'));
    empPhoneNumber = (empPrefs!.getString('empPhoneNumber'));
    empFullName = (empPrefs!.getString('empFullName'));
    // profilePic1 = (prefs!.getString('profilePic'));
    empPassword = (empPrefs!.getString('empPassword'));
    empUsersCustomersId = empPrefs!.getString('empUsersCustomersId');
    print("userId in empPrefs is = $empUsersCustomersId");
    print("oldpass = $empPassword");
    getUserProfileWidget();
    // userFirstName = (prefs!.getString('user_first_name'));
    // userLastName = (prefs!.getString('user_last_name'));
    // print("userId in LoginPrefs is = $userId");
    print("userEmail in Profile is = $empUserEmail");
    print("userprofilePic in Profile is = $empProfilePic1");
    // print("userFirstName in LoginPrefs is = $userFirstName $userLastName");
  }

  UsersProfileModel usersProfileModel = UsersProfileModel();
  bool progress = false;
  bool isInAsyncCall = false;

  getUserProfileWidget() async {
    empPrefs = await SharedPreferences.getInstance();
    empUsersCustomersId = empPrefs!.getString('empUsersCustomersId');
    print("userId in empPrefs is = $empUsersCustomersId");
    try {
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
        print(
            "getUserProfileImage: $baseUrlImage${usersProfileModel.data!.profilePic}");
        setState(() {
        });

      }
    } catch (e) {
      print('Error in getUserProfileWidget: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      // drawer: MyDrawer(),
      backgroundColor: Colors.white,
      body:
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
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Column(
            children: [
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
                      width: width * 0.07,
                    ),
                    // Image.asset("assets/images/person2.png", width: 99, height: 99,),
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
                    Container(
                      child: progress
                          ? CircleAvatar(
                        radius: 50,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Text('',),),)
                          : usersProfileModel.status != "success"
                          ? Center(
                          child: Text('',
                              style: TextStyle(fontWeight: FontWeight.bold)))
                          : CircleAvatar(
                        // radius: (screenWidth > 600) ? 90 : 70,
                          radius: 50,
                          backgroundColor: Colors.transparent,
                          backgroundImage: usersProfileModel.data!.usersCustomersId.toString() == null
                              ? Image.asset("assets/images/person2.png").image
                              : NetworkImage(baseUrlImage+usersProfileModel.data!.profilePic.toString())
                        // NetworkImage(baseUrlImage+ getUserProfileModelObject.data!.profilePic!)

                      ),
                    ),
                    SizedBox(
                      width: width * 0.05,
                    ),
                   Expanded(
                     child: Container(
                       // width: 5,
                       height: 150,
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Container(
                             child:usersProfileModel.status != "success" ? Text(""): Text(
                               "${usersProfileModel.data!.firstName} ${usersProfileModel.data!.lastName}",
                               style: TextStyle(
                                 color: Colors.white,
                                 fontFamily: "Outfit",
                                 fontWeight: FontWeight.w400,
                                 fontSize: 18,
                               ),
                             ),
                           ),
                           Container(
                             child: usersProfileModel.status != "success" ? Text(""): Padding(
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
                                   usersProfileModel.status != "success" ? Text(""): ConstrainedBox(
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
                           ),
                           Container(
                             child:  usersProfileModel.status != "success" ? Text(""):Row(
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
                           ),
                           SizedBox(height: height * 0.01,),
                           Container(
                             child: usersProfileModel.status != "success" ? Text(""): Row(
                               // mainAxisAlignment: MainAxisAlignment.center,
                               // crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 RatingBar(
                                   initialRating: double.parse(usersProfileModel.data!.rating.toString()),
                                   direction: Axis.horizontal,
                                   allowHalfRating: true,
                                   itemSize: 20,
                                   itemCount: 5,
                                   ratingWidget: RatingWidget(
                                       full: const Icon(Icons.star, color: Color(0xffFFDF00),),
                                       half: const Icon(
                                         Icons.star_half,
                                         color: Color(0xffFFDF00),
                                       ),
                                       empty: const Icon(
                                         Icons.star_outline,
                                         color: Color(0xffA7A9B7),
                                       )), onRatingUpdate: (double value) { },
                                   // onRatingUpdate: (value) {
                                   //   setState(() {
                                   //     _ratingValue = value;
                                   //   });
                                   // }
                                 ),
                                  Text(
                                    "${usersProfileModel.data!.rating.toString() == 0.0 ? '0.0' : usersProfileModel.data!.rating.toString()}",
                                   style: TextStyle(
                                     color: Color(0xffffffff),
                                     fontFamily: "Outfit",
                                     fontWeight: FontWeight.w300,
                                     fontSize: 14,
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ],
                       ),
                     ),
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
                onTap: (){
                  EMpChangePassword(context, userEmail, password);
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
                        offset: Offset(0 , 2),
                        color: Color.fromRGBO(67, 169, 183, 0.1),
                      ),
                    ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset("assets/images/lock.svg", color:  Color(0xff2B65EC),),
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
                        SvgPicture.asset("assets/images/chevron-left.svg",),
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
                onTap: (){
                  EmpNotificationSettings(context);
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
                          offset: Offset(0 , 2),
                          color: Color.fromRGBO(67, 169, 183, 0.1),
                        ),
                      ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset("assets/images/notification.svg", color:  Color(0xff2B65EC),),
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
                        SvgPicture.asset("assets/images/chevron-left.svg",),
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
                onTap: (){
                  EMpDeleteAccount(context);
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
                          offset: Offset(0 , 2),
                          color: Color.fromRGBO(67, 169, 183, 0.1),
                        ),
                      ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset("assets/images/trash.svg", color:  Color(0xff2B65EC),),
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
                        SvgPicture.asset("assets/images/chevron-left.svg",),
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
                onTap: (){
                  showLogoutAlertDialog(context);
                  // setState(() {});
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) => LoginTabClass(login: 1,)));
                  // // Get.to(LoginTabClass());
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
                          offset: Offset(0 , 2),
                          color: Color.fromRGBO(67, 169, 183, 0.1),
                        ),
                      ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset("assets/images/logout.svg", color:  Color(0xff2B65EC),),
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
          MaterialPageRoute(builder: (context) => LoginTabClass(login: 1,)),
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
