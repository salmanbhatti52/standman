// ignore: camel_case_types
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/unreaded_messages_Model.dart';
import '../Utils/api_urls.dart';
import 'Customer/HomePage/HomePage.dart';
import 'Drawer.dart';
import 'Employee/HomePage/EmpHomePage.dart';
import 'Employee/JobsPage/Jobs_TabBar.dart';
import 'Employee/MessagePage/MessagePage.dart';
import 'Employee/ProfilePage/EmpProfile_TabBar.dart';
import 'Employee/WalletPage/EmpWalletPage.dart';
import 'package:http/http.dart' as http;

class Empbottom_bar extends StatefulWidget {
  int currentIndex;
   Empbottom_bar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<Empbottom_bar> createState() => _Empbottom_barState();
}

// ignore: camel_case_types
class _Empbottom_barState extends State<Empbottom_bar> {
  // int currentIndex = 0;
  static final List<Widget> _widgetOption = <Widget>[
    EmpHomePage(),
    EmpMessagePage(),
    EmpWalletPage(),
    EmpJobTabClass(),
    ProfileTabBar(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      widget.currentIndex = index;
    });
  }

  UnreadedMessagesModel unreadedMessagesModel = UnreadedMessagesModel();

  unreadedMessages() async {
    // setState(() {
    //   loading = true;
    // });

    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('empUsersCustomersId');
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
                          widget.currentIndex == 4
                         ? 'assets/images/profile-2.svg'
                         : 'assets/images/profile.svg',
                        ),
                        label: 'Profile'),
                  ]),
            ),
          )),
    );
  }
}
