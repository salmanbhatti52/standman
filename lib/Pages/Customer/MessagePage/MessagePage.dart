import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../widgets/AppBar.dart';
import '../../Drawer.dart';
import '../../Employee/MessagePage/MessageDetails.dart';
import '../../NotificationPage.dart';
import 'MessageList.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
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
            "Chat",
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
              Get.to(  () => NotificationPage());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 0.0),
              child: SvgPicture.asset(
                'assets/images/notificationalert.svg',
              ),
            ),
          ),
        ],
      ),
      body:  SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                child: Container(
                  width: width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: MessagesLists(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
//   allChatWidget(){
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return
//
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
//         child: Container(
//           // height: MediaQuery.of(context).size.height * 0.16,
//           width: width,
//           height: height * 0.80, //88,
//           child: ListView.builder(
//               shrinkWrap: true,
//               scrollDirection: Axis.vertical,
//               itemCount: 4,
//               // messagesList.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Column(
//                   children: [
//                     GestureDetector(
//                       onTap: (){
//                         Get.to(MessagesDetails());
//                       },
//                       child: Container(
//                         padding: EdgeInsets.only(top: 20, left: 15),
//                         // width: 150,
//                         // height: height * 0.1,
//                         child: Row(
//                           children: [
//                             Image.asset(
//                               messagesList[index].image,
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   messagesList[index].title,
//                                   style: const TextStyle(
//                                     color: Color.fromRGBO(0, 0, 0, 1),
//                                     fontFamily: "Outfit",
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 14,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(vertical: 5.0),
//                                   child: Text(
//                                     messagesList[index].subTitle,
//                                     style: const TextStyle(
//                                       color: Color.fromRGBO(0, 0, 0, 1),
//                                       fontFamily: "Outfit",
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 12,
//                                     ),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               width: width * 0.20,
//                             ),
//                             Row(
//                               children: [
//                                 Text(
//                                   '3:74 Pm',
//                                   style: TextStyle(
//                                     color: Color(0xffA7A9B7),
//                                     fontFamily: "Outfit",
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w400,
// // letterSpacing: -0.3,
//                                   ),
//                                   textAlign: TextAlign.right,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Divider(
//                       indent: 15,
//                       endIndent: 15,
//                     ),
//                   ],
//                 );
//               }
//           ),
//         ),
//       );
//   }
}
