import 'package:StandMan/Models/jobs_action_employees_Model.dart';
import 'package:StandMan/Pages/Customer/MessagePage/NotificationPage.dart';
import 'package:StandMan/Pages/NotificationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../Models/jobs_action_employees_Model.dart';
import '../../../Models/users_profilet_model.dart';
import '../../../Utils/api_urls.dart';
import '../../../widgets/MyButton.dart';
import '../../Drawer.dart';
import '../../Employee/HomePage/EmpHomePage.dart';
import 'FindPlace.dart';
import 'HeadRow.dart';
import 'RecentJobs.dart';
import 'package:http/http.dart' as http;

String? userEmail;
String? password;
String? fullName;
String? phoneNumber;
String? profilePic1;
String? usersCustomersId;
String? longitude;
String? lattitude;
SharedPreferences? prefs;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
    progress = true;
    setState(() {});

    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('usersCustomersId');
    // longitude =  prefs!.getDouble('longitude');
    // lattitude =  prefs!.getDouble('latitude');
    print("usersCustomersId = $usersCustomersId");
    print("longitude1: ${longitude}");
    print("lattitude1: ${lattitude}");

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
        print("getUserName: ${usersProfileModel.data!.firstName}");
        print("getUserName: ${usersProfileModel.data!.lastName}");
        print("getUserEmail: ${usersProfileModel.data!.email}");
        print("getUserNumber: ${usersProfileModel.data!.phone}");
        print("usersCustomersId: ${usersProfileModel.data!.usersCustomersId}");
        print(
            "getUserProfileImage: $baseUrlImage${usersProfileModel.data!.profilePic}");
      }
    } catch (e) {
      print('Error in getUserProfileWidget: ${e.toString()}');
    }
    setState(() {
      progress = false;
    });
  }

  // sharedPrefs() async {
  //   setState(() {});
  //   print('LoginPage shared prefs');
  //   prefs = await SharedPreferences.getInstance();
  //   userEmail = (prefs!.getString('user_email'));
  //   // userFirstName = (prefs!.getString('user_first_name'));
  //   // userLastName = (prefs!.getString('user_last_name'));
  //   // print("userId in LoginPrefs is = $userId");
  //   print("userEmail in LoginPrefs is = $userEmail");
  //   // print("userFirstName in LoginPrefs is = $userFirstName $userLastName");
  //   setState(() {});
  //   print('in LoginPage shared prefs');
  //   prefs = await SharedPreferences.getInstance();
  //   // userId = (prefs!.getString('userid'));
  //   userEmail = (prefs!.getString('user_email'));
  //   phoneNumber = (prefs!.getString('phoneNumber'));
  //   fullName = (prefs!.getString('fullName'));
  //   profilePic1 = (prefs!.getString('profilePic'));
  //   password = (prefs!.getString('password'));
  //   usersCustomersId = prefs!.getString('usersCustomersId');
  //   print("userId in Prefs is = $usersCustomersId");
  //   print("oldpass = $password");
  //   print("userEmail in Profile is = $userEmail");
  //   print("userprofilePic in Profile is = $profilePic1");
  //   getUserProfileResponse();
  // }

  DateTime currentBackPressTime = DateTime.now();

  Future<bool> _onWillPop() async {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: 'Tap Again to Exit'); // you can use snackbar too here
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Color(0xff2B65EC),
        drawer: MyDrawer(),
        appBar: AppBar(
          toolbarHeight: height * 0.10,
          backgroundColor: Color(0xff2B65EC),
          elevation: 0,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Text(
              "Home",
              style: TextStyle(
                color: Color(0xffffffff),
                fontFamily: "Outfit",
                fontSize: 18,
                fontWeight: FontWeight.w500,
                // letterSpacing: -0.3,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: (){
                Get.to(NotificationPage());
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0, top: 0.0),
                child: SvgPicture.asset(
                  'assets/images/notification.svg',
                ),
              ),
            ),
          ],
        ),
        body:
        // progress
        //     ? Center(child: CircularProgressIndicator(color: Colors.blueAccent))
        //     : usersProfileModel.status != "success"
        //     ? Center(
        //     child: Text('no data found...',
        //         style: TextStyle(fontWeight: FontWeight.bold)))
        //     :
        SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.only(bottom: height* 0.02,) ,// 20.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18, bottom: 0),
                        child: GestureDetector(
                            onTap: (){
                              // showDialog(
                              //   context: context,
                              //   builder: (BuildContext context) => Dialog(
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(30.0),
                              //     ),
                              //     child: Stack(
                              //       clipBehavior: Clip.none,
                              //       alignment: Alignment.topCenter,
                              //       children: [
                              //         Container(
                              //           width: width,//350,
                              //           height:  537,
                              //           decoration: BoxDecoration(
                              //             color: const Color(0xFFFFFF),
                              //             borderRadius: BorderRadius.circular(32),
                              //           ),
                              //           child: Column(
                              //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //             crossAxisAlignment: CrossAxisAlignment.center,
                              //             children: [
                              //               SizedBox(height: height * 0.02,),
                              //               const Text(
                              //                 "Job Completed, Amount Paid",
                              //                 style: TextStyle(
                              //                   color: Color.fromRGBO(0, 0, 0, 1),
                              //                   fontFamily: "Outfit",
                              //                   fontSize: 20,
                              //                   fontWeight: FontWeight.w500,
                              //                   // letterSpacing: -0.3,
                              //                 ),
                              //                 textAlign: TextAlign.center,
                              //               ),
                              //               Container(
                              //                 width: width * 0.6 , //241,
                              //                 height: height * 0.095, // 70,
                              //                 decoration: BoxDecoration(
                              //                   borderRadius: BorderRadius.circular(12),
                              //                   color: Color(0xffF3F3F3),
                              //                   border: Border.all(color: Color(0xffF3F3F3), width: 1),
                              //                 ),
                              //                 child:  Column(
                              //                   mainAxisAlignment: MainAxisAlignment.center,
                              //                   crossAxisAlignment: CrossAxisAlignment.center,
                              //                   children: [
                              //                     SizedBox(width: 5,),
                              //                     Column(
                              //                       mainAxisAlignment: MainAxisAlignment.center,
                              //                       crossAxisAlignment: CrossAxisAlignment.center,
                              //                       children: [
                              //                         Row(
                              //                           mainAxisAlignment: MainAxisAlignment.center,
                              //                           crossAxisAlignment: CrossAxisAlignment.center,
                              //                           children: [
                              //                             Text(
                              //                               '\$',
                              //                               style: TextStyle(
                              //                                 color: Color(0xff21335B),
                              //                                 fontFamily: "Outfit",
                              //                                 fontSize: 18,
                              //                                 fontWeight: FontWeight.w400,
                              //                                 // letterSpacing: -0.3,
                              //                               ),
                              //                               textAlign: TextAlign.left,
                              //                             ),
                              //                             Text(
                              //                               ' 22.00',
                              //                               style: TextStyle(
                              //                                 color: Color(0xff2B65EC),
                              //                                 fontFamily: "Outfit",
                              //                                 fontSize: 36,
                              //                                 fontWeight: FontWeight.w600,
                              //                                 // letterSpacing: -0.3,
                              //                               ),
                              //                               textAlign: TextAlign.center,
                              //                             ),
                              //                           ],
                              //                         ),
                              //                         Text(
                              //                           'you paid',
                              //                           style: TextStyle(
                              //                             color: Color(0xffA7A9B7),
                              //                             fontFamily: "Outfit",
                              //                             fontSize: 12,
                              //                             fontWeight: FontWeight.w500,
                              //                             // letterSpacing: -0.3,
                              //                           ),
                              //                           textAlign: TextAlign.center,
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //               Padding(
                              //                 padding: const EdgeInsets.symmetric(horizontal: 40.0),
                              //                 child: Row(
                              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //                   children: [
                              //                     const Text(
                              //                       "From",
                              //                       style: TextStyle(
                              //                         color: Color(0xff2B65EC),
                              //                         fontFamily: "Outfit",
                              //                         fontSize: 14,
                              //                         fontWeight: FontWeight.w600,
                              //                         // letterSpacing: -0.3,
                              //                       ),
                              //                       textAlign: TextAlign.left,
                              //                     ),
                              //                     const Text(
                              //                       "Beby Jovanca",
                              //                       style: TextStyle(
                              //                         color: Color.fromRGBO(0, 0, 0, 1),
                              //                         fontFamily: "Outfit",
                              //                         fontSize: 14,
                              //                         fontWeight: FontWeight.w400,
                              //                         // letterSpacing: -0.3,
                              //                       ),
                              //                       textAlign: TextAlign.right,
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //               Divider(
                              //                 color: Color(0xffF3F3F3),
                              //                 height: 1,
                              //                 indent: 40,
                              //                 endIndent: 40,
                              //                 thickness: 1,
                              //               ),
                              //               Padding(
                              //                 padding: const EdgeInsets.symmetric(horizontal: 40.0),
                              //                 child: Row(
                              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //                   children: [
                              //                     const Text(
                              //                       "To",
                              //                       style: TextStyle(
                              //                         color: Color(0xff2B65EC),
                              //                         fontFamily: "Outfit",
                              //                         fontSize: 14,
                              //                         fontWeight: FontWeight.w600,
                              //                         // letterSpacing: -0.3,
                              //                       ),
                              //                       textAlign: TextAlign.left,
                              //                     ),
                              //                     const Text(
                              //                       "Annette Black",
                              //                       style: TextStyle(
                              //                         color: Color.fromRGBO(0, 0, 0, 1),
                              //                         fontFamily: "Outfit",
                              //                         fontSize: 14,
                              //                         fontWeight: FontWeight.w400,
                              //                         // letterSpacing: -0.3,
                              //                       ),
                              //                       textAlign: TextAlign.right,
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //               Divider(
                              //                 color: Color(0xffF3F3F3),
                              //                 height: 1,
                              //                 indent: 40,
                              //                 endIndent: 40,
                              //                 thickness: 1,
                              //               ),
                              //               Padding(
                              //                 padding: const EdgeInsets.symmetric(horizontal: 40.0),
                              //                 child: Row(
                              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //                   children: [
                              //                     const Text(
                              //                       "Date",
                              //                       style: TextStyle(
                              //                         color: Color(0xff2B65EC),
                              //                         fontFamily: "Outfit",
                              //                         fontSize: 14,
                              //                         fontWeight: FontWeight.w600,
                              //                         // letterSpacing: -0.3,
                              //                       ),
                              //                       textAlign: TextAlign.left,
                              //                     ),
                              //                     Column(
                              //                       mainAxisAlignment: MainAxisAlignment.end,
                              //                       crossAxisAlignment: CrossAxisAlignment.end,
                              //                       children: [
                              //                         const Text(
                              //                           "24 Jul 2020",
                              //                           style: TextStyle(
                              //                             color: Color.fromRGBO(0, 0, 0, 1),
                              //                             fontFamily: "Outfit",
                              //                             fontSize: 14,
                              //                             fontWeight: FontWeight.w400,
                              //                             // letterSpacing: -0.3,
                              //                           ),
                              //                           textAlign: TextAlign.right,
                              //                         ),
                              //                         Text(
                              //                           '15:30',
                              //                           style: TextStyle(
                              //                             color: Color(0xffA7A9B7),
                              //                             fontFamily: "Outfit",
                              //                             fontSize: 14,
                              //                             fontWeight: FontWeight.w400,
                              //                             // letterSpacing: -0.3,
                              //                           ),
                              //                           textAlign: TextAlign.right,
                              //                         ),
                              //                       ],
                              //                     )
                              //                   ],
                              //                 ),
                              //               ),
                              //               SizedBox(height: height * 0.02,),
                              //               mainButton("Add Ratings", Color(0xff2B65EC), context),
                              //             ],
                              //           ),
                              //         ),
                              //         Positioned(
                              //             top: -48,
                              //             child: Container(
                              //               width: width , //106,
                              //               height: height * 0.13, //106,
                              //               decoration: BoxDecoration(
                              //                 shape: BoxShape.circle,
                              //                 color: Color(0xffFF9900),
                              //               ),
                              //               child: Icon(
                              //                 Icons.check,
                              //                 size: 40,
                              //                 color: Colors.white,
                              //               ),
                              //             ))
                              //       ],
                              //     ),
                              //   ),
                              // );
                            },
                            child:
                            Container(
                              child: progress
                                  ? CircleAvatar(
                                radius: 35,
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Text('',),),)
                                    : usersProfileModel.status != "success"
                                  ? Center(
                                  child: Text('',
                                      style: TextStyle(fontWeight: FontWeight.bold)))
                                  : CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:  usersProfileModel.data!.usersCustomersId.toString() == null
                                      ? Image.asset("assets/images/person2.png").image
                                      : NetworkImage(baseUrlImage+usersProfileModel.data!.profilePic.toString())

                              ),
                            ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Hello..!",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Outfit",
                              fontWeight: FontWeight.w500,
                              fontSize: 32,
                            ),
                            textAlign: TextAlign.left,
                          ),
                           Container(
                             child: usersProfileModel.status != "success" ? Text("") : Text(
                               "${usersProfileModel.data?.firstName} ${usersProfileModel.data?.lastName}",
                               // "${usersProfileModel.data!.firstName "$+" usersProfileModel.data.lastName}",
                               // "Marvis Ighedosa",
                               style: TextStyle(
                                 color: Colors.white,
                                 fontFamily: "Outfit",
                                 fontWeight: FontWeight.w400,
                                 fontSize: 18,
                               ),
                               textAlign: TextAlign.left,
                             ),
                           )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width,
                  height: height * 0.76,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * 0.02,
                        ),
                        SvgPicture.asset("assets/images/homepic.svg", height: 200,),
                        Padding(
                          padding: const EdgeInsets.only(right: 60.0, top: 10, bottom: 10),
                          child: const Text(
                            "Where you want\nto reserve place..?",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Outfit",
                              fontWeight: FontWeight.w500,
                              fontSize: 32,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      GestureDetector(
                        onTap: (){
                          Get.to(() => FindPlace());
                        },
                          child: mainButton("Create Job", Color.fromRGBO(43, 101, 236, 1), context)),
                        Heading("Recent Jobs", "", context),
                        RecentJobs(),
                        SizedBox(
                          height: height * 0.12,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


}
