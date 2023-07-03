// Initial Selected Value
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Models/messages_permission_Model.dart';
import '../../../Models/notification_permission_Model.dart';
import '../../../Utils/api_urls.dart';
import '../../../widgets/MyButton.dart';
import '../../../widgets/TopBar.dart';
import '../../Customer/HomePage/HomePage.dart';
import 'package:http/http.dart' as http;
Future EmpNotificationSettings(BuildContext context) async {

  NotificationPermissionModel notificationPermissionModel = NotificationPermissionModel();
  // bool status = false;
  // bool status2 = false;

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool status = prefs.getBool('notificationStatus') ?? false;
  bool status2 = prefs.getBool('messagesStatus') ?? false;

  notificationPermissionApiYes() async {
    // try {
    // setState(() {
    //   loading = true;
    // });

    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('empUsersCustomersId');
    print("userId  = $usersCustomersId");

    try {
      String apiUrl = notificationPermissionModelApiUrl;
      print("notificationPermissionAPi: $apiUrl");
      final response = await http.post(Uri.parse(apiUrl),
          body: {
            "users_customers_id": usersCustomersId,
            "notifications":"Yes"
          }, headers: {
            'Accept': 'application/json'
          });
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("notificationPermissionResponse: ${responseString.toString()}");
        notificationPermissionModel = notificationPermissionModelFromJson(responseString);
        print("usersCustomersId: ${notificationPermissionModel.data?[0].usersCustomersId}");
        status = true;
        prefs.setBool('notificationStatus', status);
      }
    } catch (e) {
      print('Error in notificationPermissionModel: ${e.toString()}');
    }
  }

  notificationPermissionApiYNo() async {
    // try {
    // setState(() {
    //   loading = true;
    // });

    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('empUsersCustomersId');
    print("userId  = $usersCustomersId");

    try {
      String apiUrl = notificationPermissionModelApiUrl;
      print("notificationPermissionAPi: $apiUrl");
      final response = await http.post(Uri.parse(apiUrl),
          body: {
            "users_customers_id": usersCustomersId,
            "notifications":"No"
          }, headers: {
            'Accept': 'application/json'
          });
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("notificationPermissionResponse: ${responseString.toString()}");
        notificationPermissionModel = notificationPermissionModelFromJson(responseString);
        print("usersCustomersId: ${notificationPermissionModel.data?[0].usersCustomersId}");
        status = false;
        prefs.setBool('notificationStatus', status);
      }
    } catch (e) {
      print('Error in notificationPermissionModel: ${e.toString()}');
    }
  }

  MessagesPermissionModel messagesPermissionModel = MessagesPermissionModel();

  messagesPermissionApiYes() async {
    // try {
    // setState(() {
    //   loading = true;
    // });

    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('empUsersCustomersId');
    print("userId  = $usersCustomersId");

    try {
      String apiUrl = messagesPermissionModelApiUrl;
      print("messagesPermissionAPi: $apiUrl");
      final response = await http.post(Uri.parse(apiUrl),
          body: {
            "users_customers_id": usersCustomersId,
            "messages":"Yes"
          }, headers: {
            'Accept': 'application/json'
          });
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("messagesPermissionResponse: ${responseString.toString()}");
        messagesPermissionModel = messagesPermissionModelFromJson(responseString);
        print("usersCustomersId: ${messagesPermissionModel.data?[0].usersCustomersId}");
        status2 = true;
        prefs.setBool('messagesStatus', status2);
      }
    } catch (e) {
      print('Error in messagesPermissionModel: ${e.toString()}');
    }
  }

  messagesPermissionApiNo() async {
    //   // try {
    //   // setState(() {
    //   //   loading = true;
    //   // });
    //
    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('empUsersCustomersId');
    print("userId  = $usersCustomersId");

    try {
      String apiUrl = messagesPermissionModelApiUrl;
      print("messagesPermissionAPi: $apiUrl");
      final response = await http.post(Uri.parse(apiUrl),
          body: {
            "users_customers_id": usersCustomersId,
            "messages":"No"
          }, headers: {
            'Accept': 'application/json'
          });
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("messagesPermissionResponse: ${responseString.toString()}");
        messagesPermissionModel = messagesPermissionModelFromJson(responseString);
        print("usersCustomersId: ${messagesPermissionModel.data?[0].usersCustomersId}");
        status2 = false;
        prefs.setBool('messagesStatus', status2);
      }
    } catch (e) {
      print('Error in messagesPermissionModel: ${e.toString()}');
    }
  }

  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
  return showMaterialModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => SingleChildScrollView(
      controller: ModalScrollController.of(context),
      child: StatefulBuilder(
          builder: (BuildContext context, StateSetter stateSetterObject) {
            return SafeArea(
              child: Container(
                width: width, //390,
                height: height * 0.5, // 515,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:25.0),
                  child: Column(
                    children: [
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: height * 0.02),
                        child: Bar(
                          "Notification settings ",
                          'assets/images/arrow-back.svg',
                          Colors.black,
                          Colors.black,
                              () {
                            Get.back();
                          },
                        ),
                      ),
                      Container(
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
                              Container(
                                child: FlutterSwitch(
                                  width: 36.0,
                                  height: 20.0,
                                  // valueFontSize: 25.0,
                                  toggleSize: 14.0,
                                  value: status,
                                  borderRadius: 30.0,
                                  // padding: 8.0,
                                  showOnOff: false,
                                  onToggle: (val) {
                                    stateSetterObject(() {
                                      status = val;
                                      print("val $val");
                                    });
                                    if(val == true){
                                      notificationPermissionApiYes();
                                    } else if (val == false) {
                                      notificationPermissionApiYNo();
                                    } else{
                                      return print("Error ");
                                    }
                                  },
                                ),
                              ),
                              // Svg
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
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
                              const Text(
                                "Messages Notifications ",
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
                              Container(
                                child: FlutterSwitch(
                                  width: 36.0,
                                  height: 20.0,
                                  // valueFontSize: 25.0,
                                  toggleSize: 14.0,
                                  value: status2,
                                  borderRadius: 30.0,
                                  // padding: 8.0,
                                  showOnOff: false,
                                  onToggle: (val2) {
                                    stateSetterObject(() {
                                      status2 = val2;
                                      print("val2 $val2");
                                    });
                                    if(val2 == true){
                                      messagesPermissionApiYes();
                                    } else if (val2 == false) {
                                      messagesPermissionApiNo();
                                    } else{
                                      return print("Error2 ");
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.1,
                      ),
                      GestureDetector(onTap: (){
                        Get.back();
                      },child: mainButton("Save", Color(0xff2B65EC), context)),
                    ],
                  ),
                ),
              ),
            );
          }),
    ),
  );
}
