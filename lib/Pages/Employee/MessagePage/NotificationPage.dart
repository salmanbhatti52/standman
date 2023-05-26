// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import '../../../widgets/TopBar.dart';
// import '../../Customer/MessagePage/MessageDetails.dart';
// import 'MessageList.dart';
//
// class NotificationPage extends StatelessWidget {
//   const NotificationPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 25.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: height * 0.01,
//               ),
//               TopBar(text: "Notifications ", imagePath: "assets/images/arrow-left.svg",
//                 onTap: (){
//                   Get.back();
//                 },
//               ),
//               SizedBox(
//                 height: height * 0.02,
//               ),
//               Text(
//                 "Today",
//                 style: TextStyle(
//                   fontFamily: "Outfit",
//                   color: Color(0xffA7A9B7),
//                   fontWeight: FontWeight.w300,
//                   fontSize: 12,
//                 ),
//               ),
//           Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
//                 child: Container(
//                   // height: MediaQuery.of(context).size.height * 0.16,
//                   width: width,
//                   height: height * 0.28, //88,
//                   child: ListView.builder(
//                       shrinkWrap: true,
//                       scrollDirection: Axis.vertical,
//                       itemCount: 4,
//                       // messagesList.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Column(
//                           children: [
//                             GestureDetector(
//                               onTap: (){
//                                 Get.to(MessagesDetails());
//                               },
//                               child: Container(
//                                // padding: EdgeInsets.only(top: 20, left: 15),
//                                 // width: 150,
//                                 // height: height * 0.1,
//                                 child: Row(
//                                   children: [
//                                     Image.asset(
//                                       messagesList[index].image,
//                                     ),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           messagesList[index].title,
//                                           style: const TextStyle(
//                                             color: Color.fromRGBO(0, 0, 0, 1),
//                                             fontFamily: "Outfit",
//                                             fontWeight: FontWeight.w500,
//                                             fontSize: 14,
//                                           ),
//                                           textAlign: TextAlign.center,
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(vertical: 5.0),
//                                           child: Text(
//                                             messagesList[index].subTitle,
//                                             style: const TextStyle(
//                                               color: Color.fromRGBO(0, 0, 0, 1),
//                                               fontFamily: "Outfit",
//                                               fontWeight: FontWeight.w400,
//                                               fontSize: 12,
//                                             ),
//                                             textAlign: TextAlign.center,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       width: width * 0.20,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           '3:74 Pm',
//                                           style: TextStyle(
//                                             color: Color(0xffA7A9B7),
//                                             fontFamily: "Outfit",
//                                             fontSize: 10,
//                                             fontWeight: FontWeight.w400,
// // letterSpacing: -0.3,
//                                           ),
//                                           textAlign: TextAlign.right,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Divider(
//                               indent: 15,
//                               endIndent: 15,
//                             ),
//                           ],
//                         );
//                       }
//                   ),
//                 ),
//               ),
//             ],
//           ),
//               Text(
//                 "Yesterday",
//                 style: TextStyle(
//                   fontFamily: "Outfit",
//                   color: Color(0xffA7A9B7),
//                   fontWeight: FontWeight.w300,
//                   fontSize: 12,
//                 ),
//               ),
//               Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
//                     child: Container(
//                       // height: MediaQuery.of(context).size.height * 0.16,
//                       width: width,
//                       height: height * 0.45, //88,
//                       child: ListView.builder(
//                           shrinkWrap: true,
//                           scrollDirection: Axis.vertical,
//                           itemCount:
//                           messagesList.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             return Column(
//                               children: [
//                                 GestureDetector(
//                                   onTap: (){
//                                     Get.to(MessagesDetails());
//                                   },
//                                   child: Container(
//                                     // padding: EdgeInsets.only(top: 20, left: 15),
//                                     // width: 150,
//                                     // height: height * 0.1,
//                                     child: Row(
//                                       children: [
//                                         Image.asset(
//                                           messagesList[index].image,
//                                         ),
//                                         SizedBox(
//                                           width: 10,
//                                         ),
//                                         Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               messagesList[index].title,
//                                               style: const TextStyle(
//                                                 color: Color.fromRGBO(0, 0, 0, 1),
//                                                 fontFamily: "Outfit",
//                                                 fontWeight: FontWeight.w500,
//                                                 fontSize: 14,
//                                               ),
//                                               textAlign: TextAlign.center,
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.symmetric(vertical: 5.0),
//                                               child: Text(
//                                                 messagesList[index].subTitle,
//                                                 style: const TextStyle(
//                                                   color: Color.fromRGBO(0, 0, 0, 1),
//                                                   fontFamily: "Outfit",
//                                                   fontWeight: FontWeight.w400,
//                                                   fontSize: 12,
//                                                 ),
//                                                 textAlign: TextAlign.center,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         SizedBox(
//                                           width: width * 0.20,
//                                         ),
//                                         Row(
//                                           children: [
//                                             Text(
//                                               '3:74 Pm',
//                                               style: TextStyle(
//                                                 color: Color(0xffA7A9B7),
//                                                 fontFamily: "Outfit",
//                                                 fontSize: 10,
//                                                 fontWeight: FontWeight.w400,
// // letterSpacing: -0.3,
//                                               ),
//                                               textAlign: TextAlign.right,
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Divider(
//                                   indent: 15,
//                                   endIndent: 15,
//                                 ),
//                               ],
//                             );
//                           }
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               // MessagesLists(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// List messagesList = [
//   _messagesList("assets/images/g2.png", "Maddy Lin", 'Hai Rizal, I’m on the way to your...', Colors.grey),
//   _messagesList("assets/images/g2.png", "Maddy Lin", 'Hai Rizal, I’m on the way to your...', Colors.grey),
//   _messagesList("assets/images/g2.png", "Maddy Lin", 'Hai Rizal, I’m on the way to your...', Colors.grey),
//   _messagesList("assets/images/g2.png", "Maddy Lin", 'Hai Rizal, I’m on the way to your...', Colors.grey),
//   _messagesList("assets/images/g2.png", "Maddy Lin", 'Hai Rizal, I’m on the way to your...', Colors.grey),
//   _messagesList("assets/images/g2.png", "Maddy Lin", 'Hai Rizal, I’m on the way to your...', Colors.grey),
//   _messagesList("assets/images/g2.png", "Maddy Lin", 'Hai Rizal, I’m on the way to your...', Colors.grey),
//   _messagesList("assets/images/g2.png", "Maddy Lin", 'Hai Rizal, I’m on the way to your...', Colors.grey),
//   _messagesList("assets/images/g2.png", "Maddy Lin", 'Hai Rizal, I’m on the way to your...', Colors.grey),
//   _messagesList("assets/images/g2.png", "Maddy Lin", 'Hai Rizal, I’m on the way to your...', Colors.grey),
// ];
//
// class _messagesList {
//   final String image;
//   final String title;
//   final String subTitle;
//   final Color color;
//
//   _messagesList(this.image, this.title, this.subTitle, this.color);
// }
