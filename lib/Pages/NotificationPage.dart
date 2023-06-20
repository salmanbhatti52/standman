import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../widgets/TopBar.dart';
import '../Models/notifications_Model.dart';
import '../Utils/api_urls.dart';
import 'Customer/HomePage/HomePage.dart';
import 'package:http/http.dart' as http;

class NotificationPage extends StatefulWidget {
   NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  NotificationsModel notificationsModel = NotificationsModel();
  bool loading = false;

  notificationApi() async {
    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('usersCustomersId');
    print("usersCustomersId = $usersCustomersId");
    String apiUrl = notificationsModelApiUrl;
    print("working");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "users_customers_id": usersCustomersId,
      },
    );
    final responseString = response.body;
    print("notificationsModelApiUrl: ${response.body}");
    print("status Code notificationsModel: ${response.statusCode}");
    print("in 200 notificationsModel");
    if (response.statusCode == 200) {
      notificationsModel = notificationsModelFromJson(responseString);
      // setState(() {});
      print('notificationsModel status: ${notificationsModel.status}');
      setState(() {});
      // print('notificationsModel message: ${notificationsModel.data?[0].message}');
    }

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationApi();
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: StandManAppBar1(
        title: "Notifications",
        bgcolor: Color(0xffffffff),
        titlecolor: Colors.black,
        iconcolor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: loading
          ? Center(child: CircularProgressIndicator(color: Colors.blueAccent))
          : notificationsModel.data?.length == null
              ? Center(child: Text("No history"))
              : ModalProgressHUD(
                  inAsyncCall: loading,
                  opacity: 0.02,
                  blur: 0.5,
                  color: Colors.transparent,
                  progressIndicator:
                      CircularProgressIndicator(color: Colors.blue),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "Today",
                                  style: TextStyle(
                                    fontFamily: "Outfit",
                                    color: Color(0xffA7A9B7),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 15),
                                child: Container(
                                  width: width,
                                  height: height * 0.8, //88,
                                  child: ListView.builder(
                                      physics: ScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: notificationsModel.data?.length,
                                      // itemCount: _separateData(),
                                      // messagesList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                // Get.to(MessagesDetails());
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                // crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  // Image.asset(
                                                  //   messagesList[index].image,
                                                  // ),
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        CircleAvatar(
                                                          // radius: (screenWidth > 600) ? 90 : 70,
                                                          //   radius: 50,
                                                            backgroundColor:
                                                            Colors.transparent,
                                                            backgroundImage: notificationsModel
                                                                .data?[
                                                            index]
                                                                .notificationSender
                                                                .toString() ==
                                                                null
                                                                ? Image.asset(
                                                                "assets/images/person2.png")
                                                                .image
                                                                : NetworkImage(baseUrlImage +
                                                                notificationsModel
                                                                    .data![
                                                                index]
                                                                    .notificationSender!
                                                                    .profilePic
                                                                    .toString())
                                                          // NetworkImage(baseUrlImage+ getUserProfileModelObject.data!.profilePic!)

                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Text(
                                                              // messagesList[index].title,
                                                              "${notificationsModel.data?[index].notificationSender?.firstName} ${notificationsModel.data?[index].notificationSender?.lastName}",
                                                              style:
                                                              const TextStyle(
                                                                color:
                                                                Color.fromRGBO(
                                                                    0, 0, 0, 1),
                                                                fontFamily:
                                                                "Outfit",
                                                                fontWeight:
                                                                FontWeight.w500,
                                                                fontSize: 14,
                                                              ),
                                                              textAlign:
                                                              TextAlign.center,
                                                            ),
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                  5.0),
                                                              child: Text(
                                                                // messagesList[index].subTitle,
                                                                "${notificationsModel.data?[index].message}",
                                                                style:
                                                                const TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(0,
                                                                      0, 0, 1),
                                                                  fontFamily:
                                                                  "Outfit",
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                                  fontSize: 12,
                                                                ),
                                                                textAlign: TextAlign
                                                                    .center,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 110,
                                                    child: AutoSizeText(
                                                      "${notificationsModel.data?[index].dateAdded}",
                                                      // '3:74 Pm',
                                                      style: TextStyle(
                                                        color: Color(
                                                            0xffA7A9B7),
                                                        fontFamily:
                                                            "Outfit",
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
// letterSpacing: -0.3,
                                                      ),
                                                      textAlign: TextAlign.right,
                                                      maxFontSize: 10,
                                                      minFontSize: 10,
                                                      maxLines: 1,
                                                      presetFontSizes: [10],
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              indent: 15,
                                              endIndent: 15,
                                            ),
                                          ],
                                        );
                                      }),
                                ),
                              ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 8.0),
//                                 child: Text(
//                                   "Yesterday",
//                                   style: TextStyle(
//                                     fontFamily: "Outfit",
//                                     color: Color(0xffA7A9B7),
//                                     fontWeight: FontWeight.w300,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               ),


//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 0, vertical: 15),
//                                 child: Container(
//                                   // height: MediaQuery.of(context).size.height * 0.16,
//                                   width: width,
//                                   height: height * 0.46, //88,
//                                   child: ListView.builder(
//                                       physics: NeverScrollableScrollPhysics(),
//                                       shrinkWrap: true,
//                                       scrollDirection: Axis.vertical,
//                                       itemCount: notificationsModel.data?.length,
//                                       // messagesList.length,
//                                       itemBuilder:
//                                           (BuildContext context, int index) {
//                                         return Column(
//                                           children: [
//                                             GestureDetector(
//                                               onTap: () {
//                                                 // Get.to(MessagesDetails());
//                                               },
//                                               child: Container(
//                                                 // padding: EdgeInsets.only(top: 20, left: 15),
//                                                 // width: 150,
//                                                 // height: height * 0.1,
//                                                 child: Row(
//                                                   children: [
//                                                     // Image.asset(
//                                                     //   messagesList[index].image,
//                                                     // ),
//                                                     CircleAvatar(
//                                                       // radius: (screenWidth > 600) ? 90 : 70,
//                                                       //   radius: 50,
//                                                         backgroundColor:
//                                                         Colors.transparent,
//                                                         backgroundImage: notificationsModel
//                                                             .data?[
//                                                         index]
//                                                             .notificationSender
//                                                             .toString() ==
//                                                             null
//                                                             ? Image.asset(
//                                                             "assets/images/person2.png")
//                                                             .image
//                                                             : NetworkImage(baseUrlImage +
//                                                             notificationsModel
//                                                                 .data![
//                                                             index]
//                                                                 .notificationSender!
//                                                                 .profilePic
//                                                                 .toString())
//                                                       // NetworkImage(baseUrlImage+ getUserProfileModelObject.data!.profilePic!)
//
//                                                     ),
//                                                     SizedBox(
//                                                       width: 10,
//                                                     ),
//                                                     Column(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         Text(
//                                                           // messagesList[index]
//                                                           //     .title,
//                                                           "${notificationsModel.data?[index].notificationSender?.firstName} ${notificationsModel.data?[index].notificationSender?.lastName}",
//                                                           style:
//                                                               const TextStyle(
//                                                             color:
//                                                                 Color.fromRGBO(
//                                                                     0, 0, 0, 1),
//                                                             fontFamily:
//                                                                 "Outfit",
//                                                             fontWeight:
//                                                                 FontWeight.w500,
//                                                             fontSize: 14,
//                                                           ),
//                                                           textAlign:
//                                                               TextAlign.center,
//                                                         ),
//                                                         Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                       .symmetric(
//                                                                   vertical:
//                                                                       5.0),
//                                                           child: Text(
//                                                             // messagesList[index]
//                                                             //     .subTitle,
//                                                             "${notificationsModel.data?[index].message}",
//                                                             style:
//                                                                 const TextStyle(
//                                                               color: Color
//                                                                   .fromRGBO(0,
//                                                                       0, 0, 1),
//                                                               fontFamily:
//                                                                   "Outfit",
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w400,
//                                                               fontSize: 12,
//                                                             ),
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     SizedBox(
//                                                       width: width * 0.08,
//                                                     ),
//                                                     Row(
//                                                       children: [
//                                                         Container(
//                                                           width: 100,
//                                                           child: AutoSizeText(
//                                                             "${notificationsModel.data?[index].dateAdded}",
//                                                             // '3:74 Pm',
//                                                             style: TextStyle(
//                                                               color: Color(
//                                                                   0xffA7A9B7),
//                                                               fontFamily:
//                                                               "Outfit",
//                                                               fontSize: 10,
//                                                               fontWeight:
//                                                               FontWeight.w400,
// // letterSpacing: -0.3,
//                                                             ),
//                                                             textAlign: TextAlign.right,
//                                                             maxFontSize: 10,
//                                                             minFontSize: 10,
//                                                             maxLines: 1,
//                                                             presetFontSizes: [10],
//                                                             overflow: TextOverflow.ellipsis,
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                             Divider(
//                                               indent: 15,
//                                               endIndent: 15,
//                                             ),
//                                           ],
//                                         );
//                                       }),
//                                 ),
//                               ),
                            ],
                          ),
                        ),
//             Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                   child: Container(
//                     // height: MediaQuery.of(context).size.height * 0.16,
//                     width: width,
//                     height: height * 0.45, //88,
//                     child: ListView.builder(
//                         shrinkWrap: true,
//                         scrollDirection: Axis.vertical,
//                         itemCount:
//                         messagesList.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return Column(
//                             children: [
//                               GestureDetector(
//                                 onTap: (){
//                                   // Get.to(MessagesDetails());
//                                 },
//                                 child: Container(
//                                   // padding: EdgeInsets.only(top: 20, left: 15),
//                                   // width: 150,
//                                   // height: height * 0.1,
//                                   child: Row(
//                                     children: [
//                                       Image.asset(
//                                         messagesList[index].image,
//                                       ),
//                                       SizedBox(
//                                         width: 10,
//                                       ),
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             messagesList[index].title,
//                                             style: const TextStyle(
//                                               color: Color.fromRGBO(0, 0, 0, 1),
//                                               fontFamily: "Outfit",
//                                               fontWeight: FontWeight.w500,
//                                               fontSize: 14,
//                                             ),
//                                             textAlign: TextAlign.center,
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.symmetric(vertical: 5.0),
//                                             child: Text(
//                                               messagesList[index].subTitle,
//                                               style: const TextStyle(
//                                                 color: Color.fromRGBO(0, 0, 0, 1),
//                                                 fontFamily: "Outfit",
//                                                 fontWeight: FontWeight.w400,
//                                                 fontSize: 12,
//                                               ),
//                                               textAlign: TextAlign.center,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         width: width * 0.20,
//                                       ),
//                                       Row(
//                                         children: [
//                                           Text(
//                                             '3:74 Pm',
//                                             style: TextStyle(
//                                               color: Color(0xffA7A9B7),
//                                               fontFamily: "Outfit",
//                                               fontSize: 10,
//                                               fontWeight: FontWeight.w400,
// // letterSpacing: -0.3,
//                                             ),
//                                             textAlign: TextAlign.right,
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Divider(
//                                 indent: 15,
//                                 endIndent: 15,
//                               ),
//                             ],
//                           );
//                         }
//                     ),
//                   ),
//                 ),
//               ],
//             ),
                        // MessagesLists(),
                      ],
                    ),
                  ),
                ),
    );
  }
}

List messagesList = [
  _messagesList("assets/images/g2.png", "Maddy Lin",
      'Hai Rizal, I’m on the way to your...', Colors.grey),
  _messagesList("assets/images/g2.png", "Maddy Lin",
      'Hai Rizal, I’m on the way to your...', Colors.grey),
  _messagesList("assets/images/g2.png", "Maddy Lin",
      'Hai Rizal, I’m on the way to your...', Colors.grey),
  _messagesList("assets/images/g2.png", "Maddy Lin",
      'Hai Rizal, I’m on the way to your...', Colors.grey),
  _messagesList("assets/images/g2.png", "Maddy Lin",
      'Hai Rizal, I’m on the way to your...', Colors.grey),
  _messagesList("assets/images/g2.png", "Maddy Lin",
      'Hai Rizal, I’m on the way to your...', Colors.grey),
  _messagesList("assets/images/g2.png", "Maddy Lin",
      'Hai Rizal, I’m on the way to your...', Colors.grey),
  _messagesList("assets/images/g2.png", "Maddy Lin",
      'Hai Rizal, I’m on the way to your...', Colors.grey),
  _messagesList("assets/images/g2.png", "Maddy Lin",
      'Hai Rizal, I’m on the way to your...', Colors.grey),
  _messagesList("assets/images/g2.png", "Maddy Lin",
      'Hai Rizal, I’m on the way to your...', Colors.grey),
];

class _messagesList {
  final String image;
  final String title;
  final String subTitle;
  final Color color;

  _messagesList(this.image, this.title, this.subTitle, this.color);
}
