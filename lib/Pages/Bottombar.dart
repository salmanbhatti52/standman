// ignore: camel_case_types
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/get_jobs_employees_Model.dart';
import '../Models/jobs_action_employees_Model.dart';
import '../Models/unreaded_messages_Model.dart';
import '../Utils/api_urls.dart';
import '../widgets/MyButton.dart';
import '../widgets/ToastMessage.dart';
import 'Authentication/Login_tab_class.dart';
import 'Customer/HomePage/HomePage.dart';
import 'Customer/JobsPage/Jobs_TabBar.dart';
import 'Customer/MessagePage/MessagePage.dart';
import 'Customer/ProfilePage/ProfilePage.dart';
import 'Customer/WalletPage/WalletPage.dart';
import 'Drawer.dart';

class bottom_bar extends StatefulWidget {
  int currentIndex;
   bottom_bar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<bottom_bar> createState() => _bottom_barState();
}

// ignore: camel_case_types
class _bottom_barState extends State<bottom_bar> {
  // int currentIndex = 0;
  DateTime? currentBackPressTime;
  bool _canExit = false;
  final PageController _pageController = PageController(initialPage: 0);

  static final List<Widget> _widgetOption = <Widget>[
    HomePage(),
    MessagePage(),
    WalletPage(),
    JobTabClass(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      widget.currentIndex = index;
    });
  }

  JobsActionEmployeesModel jobsActionEmployeesModel = JobsActionEmployeesModel();
  GetJobsEmployeesModel getJobsEmployeesModel = GetJobsEmployeesModel();
  late int index;


  sharepref() async {
    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('usersCustomersId');
    print("usersCustomersId: ${usersCustomersId}");
  }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   sharepref();
  //   if(jobsActionEmployeesModel.status == "Accepted" && usersCustomersId == getJobsEmployeesModel.data?[index].usersEmployeeData?[index].usersCustomersId){
  //     jobAccepted();
  //   } else
  //     // if(usersCustomersId == getJobsEmployeesModel.data?[index].usersCustomersData?.usersCustomersId)
  //     {
  //     return print("Helloerror");
  //   }
  // }


  UnreadedMessagesModel unreadedMessagesModel = UnreadedMessagesModel();

  unreadedMessages() async {
    // setState(() {
    //   loading = true;
    // });

    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('usersCustomersId');
    // print("usersCustomersId = $usersCustomersId");

    String apiUrl = unreadedMessagesModelApiUrl;
    // print("working");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "users_customers_id": usersCustomersId,
      },
    );
    final responseString = response.body;
    // print("unreadedMessagesModelApiUrl: ${response.body}");
    // print("status Code unreadedMessagesModel: ${response.statusCode}");
    // print("in 200 unreadedMessagesModel");
    if (response.statusCode == 200) {
      unreadedMessagesModel = unreadedMessagesModelFromJson(responseString);
      // setState(() {});
      // print('unreadedMessagesModel status: ${unreadedMessagesModel.status}');
      // print('unreadedMessagesModel data: ${unreadedMessagesModel.data}');
    }
    // setState(() {
    //   loading = false;
    // });
  }


  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is initialized
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      // Make your API call here
      unreadedMessages();
    });
  }

  @override
  void dispose() {
    super.dispose();
    // Cancel the timer when the widget is disposed
    _timer?.cancel();
  }

  bool _shouldExit = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
    onWillPop: () async {
      if (_shouldExit) {
        // Close the app when the back button is pressed again
        SystemNavigator.pop();
        return true;
      } else {
        // Show the "Tap again to exit" message and set a flag
        setState(() {
          _shouldExit = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tap again to exit'),
            duration: Duration(seconds: 2),
          ),
        );
        // Prevent the app from being closed immediately
        return false;
      }
    },
    child: Scaffold(
        drawer: MyDrawer(),
        extendBody: true,
        body: Container(
      child: _widgetOption[widget.currentIndex],
        ),
        bottomNavigationBar: Container(
      height: height * 0.11, //90,
      width: width, //390,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.02),
            spreadRadius: 0,
            blurRadius: 20,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: ClipRRect(
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(24.0),
        //   topRight: Radius.circular(24.0),
        // ),
        child: BottomNavigationBar(
            onTap: _onItemTapped,
            currentIndex: widget.currentIndex,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Color(0xffA7A9B7),
            selectedItemColor: Color(0xff000000),
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  widget.currentIndex == 0
                      ? 'assets/images/home-2.svg'
                      : 'assets/images/home.svg',
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Stack(
                    children: [
                      SvgPicture.asset(
                        widget.currentIndex == 1
                            ? 'assets/images/messages-2.svg'
                            : 'assets/images/messages.svg',
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.blueAccent,
                          ),
                          child: Center(child: Text(unreadedMessagesModel.data.toString() == 0 ? "0" : unreadedMessagesModel.data.toString(),style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,)),
                        ),
                      )
                    ],
                  ),
                  label: 'Messages'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    widget.currentIndex == 2
                        ? 'assets/images/wallet-2.svg'
                        : 'assets/images/wallet.svg',
                  ),
                  label: 'Wallet'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    widget.currentIndex == 3
                        ? 'assets/images/job-2.svg'
                        : 'assets/images/job.svg',
                  ),
                  label: 'My Jobs'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    widget.currentIndex  == 4
                        ? 'assets/images/profile-2.svg'
                        : 'assets/images/profile.svg',
                  ),
                  label: 'Profile'),
            ]),
      ),
        ),
      ),
    );
      // WillPopScope(
      // onWillPop: () async {
      //   if (_canExit) {
      //     return true;
      //   } else {
      //     // toastSuccessMessage("Click Again To Exit");
      //     toastSuccessMessage("Click Again To Exit", Colors.blueAccent);
      //     _canExit = true;
      //     Timer(Duration(seconds: 2), () {
      //       _canExit = false;
      //     });
      //     return false;
      //   }
      // },
      // child:

  }
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) =>
      new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit.'),
        actions: <Widget>[
          new TextButton(
            onPressed: () => Navigator.pop(context),
            child: new Text('No'),
          ),
          new TextButton(
            onPressed: () => Get.offAll(LoginTabClass(login: 0,)),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  jobAccepted(){
    return   showDialog(
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
              width: MediaQuery.of(context).size.width * 0.9, //350,
              height: MediaQuery.of(context).size.height * 0.4, // 321,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  const Text(
                    "Job Accepted",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontFamily: "Outfit",
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      // letterSpacing: -0.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    //241,
                    height: MediaQuery.of(context).size.height * 0.095,
                    // 70,
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(12),
                      color: Color(0xffF3F3F3),
                      border: Border.all(
                          color: Color(0xffF3F3F3),
                          width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      children: [
                        // CircleAvatar(
                        //   // radius: (screenWidth > 600) ? 90 : 70,
                        //   //   radius: 50,
                        //     backgroundColor: Colors.transparent,
                        //     backgroundImage: usersProfileModel.data!.usersCustomersId.toString() == null
                        //         ? Image.asset("assets/images/person2.png").image
                        //         : NetworkImage(baseUrlImage+usersProfileModel.data!.profilePic.toString())
                        //   // NetworkImage(baseUrlImage+ getUserProfileModelObject.data!.profilePic!)
                        //
                        // ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              "helloo",
                              // "${usersProfileModel.data!.fullName}",
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontFamily: "Outfit",
                                fontSize: 12,
                                fontWeight:
                                FontWeight.w500,
                                // letterSpacing: -0.3,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color:
                                  Color(0xffFFDF00),
                                ),
                                // Image.asset(
                                //     "assets/images/star.png", width: 50, height: 50,),
                                Text(
                                  ' 4.5',
                                  style: TextStyle(
                                    color:
                                    Color(0xff000000),
                                    fontFamily: "Outfit",
                                    fontSize: 12,
                                    fontWeight:
                                    FontWeight.w400,
                                    // letterSpacing: -0.3,
                                  ),
                                  textAlign:
                                  TextAlign.left,
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.to(bottom_bar(currentIndex: 0,));
                      },
                      child: mainButton("Go Back To Home",
                          Color(0xff2B65EC), context)),
                ],
              ),
            ),
            Positioned(
                top: -48,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  //106,
                  height: MediaQuery.of(context).size.height * 0.13,
                  //106,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffFF9900),
                  ),
                  child: Icon(
                    Icons.check,
                    size: 40,
                    color: Colors.white,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
