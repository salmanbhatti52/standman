// import 'package:flutter/material.dart';
//
// class DateTimePicker extends StatefulWidget {
//   @override
//   _DateTimePickerState createState() => _DateTimePickerState();
// }
//
// class _DateTimePickerState extends State<DateTimePicker> {
//   DateTime? selectedDate;
//   TimeOfDay? startTime;
//   TimeOfDay? endTime;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Date and Time Picker'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               child: Text(selectedDate != null
//                   ? 'Selected Date: ${selectedDate.toString().split(' ')[0]}'
//                   : 'Select Date'),
//               onPressed: () {
//                 _selectDate(context);
//               },
//             ),
//             ElevatedButton(
//               child: Text(startTime != null
//                   ? 'Selected Start Time: ${startTime?.format(context)}'
//                   : 'Select Start Time'),
//               onPressed: () {
//                 _selectStartTime(context);
//               },
//             ),
//             ElevatedButton(
//               child: Text(endTime != null
//                   ? 'Selected End Time: ${endTime?.format(context)}'
//                   : 'Select End Time'),
//               onPressed: () {
//                 _selectEndTime(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//     );
//
//     if (pickedDate != null && pickedDate != selectedDate) {
//       setState(() {
//         selectedDate = pickedDate;
//         startTime = null;
//         endTime = null;
//       });
//     }
//   }
//
//   Future<void> _selectStartTime(BuildContext context) async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//
//     if (pickedTime != null) {
//       final DateTime selectedDateTime = DateTime(
//         selectedDate!.year,
//         selectedDate!.month,
//         selectedDate!.day,
//         pickedTime.hour,
//         pickedTime.minute,
//       );
//
//       if (selectedDateTime.isBefore(DateTime.now())) {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('Invalid Time'),
//               content: Text('Please select a future time.'),
//               actions: [
//                 ElevatedButton(
//                   child: Text('OK'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       } else {
//         setState(() {
//           startTime = pickedTime;
//         });
//       }
//     }
//   }
//
//   Future<void> _selectEndTime(BuildContext context) async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//
//     if (pickedTime != null) {
//       final DateTime startDateTime = DateTime(
//         selectedDate!.year,
//         selectedDate!.month,
//         selectedDate!.day,
//         startTime!.hour,
//         startTime!.minute,
//       );
//       final DateTime endDateTime = DateTime(
//         selectedDate!.year,
//         selectedDate!.month,
//         selectedDate!.day,
//         pickedTime.hour,
//         pickedTime.minute,
//       );
//
//       if (endDateTime.isBefore(startDateTime)) {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('Invalid Time'),
//               content: Text('End time must be greater than start time.'),
//               actions: [
//                 ElevatedButton(
//                   child: Text('OK'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       } else {
//         setState(() {
//           endTime = pickedTime;
//         });
//       }
//     }
//   }
// }




// import 'dart:async';
// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:StandMan/Pages/Customer/HomePage/HomePage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import '../../../Models/get_messge_Model.dart';
// import '../../../Models/send_messge_customer_Model.dart';
// import '../../../Models/update_messge_Model.dart';
// import '../../../Utils/api_urls.dart';
// import 'dart:io';
// import '../../../widgets/ToastMessage.dart';
// import '../../Bottombar.dart';
// import 'package:cron/cron.dart';
//
// class MessagesDetails extends StatefulWidget {
//   final String? usersCustomersId;
//   final String? other_users_customers_id;
//   final String? name;
//   final String? img;
//
//   MessagesDetails(
//       {Key? key,
//         this.usersCustomersId,
//         this.other_users_customers_id,
//         this.name,
//         this.img})
//       : super(key: key);
//
//   @override
//   State<MessagesDetails> createState() => _MessagesDetailsState();
// }
//
// class _MessagesDetailsState extends State<MessagesDetails> {
//   var sendMessageController = TextEditingController();
//   final GlobalKey<FormState> sendMessageFormKey = GlobalKey<FormState>();
//   List<UpdateMessgeModel> updateMessageModelObject = [];
//   SendMessgeCustomerModel sendMessageCustomerModel = SendMessgeCustomerModel();
//   bool loading = true;
//   bool progress = false;
//   GetMessgeModel getMessageModel = GetMessgeModel();
//   String? Image;
//   ScrollController _scrollController = ScrollController();
//
//   getMessageApi() async {
//     prefs = await SharedPreferences.getInstance();
//     usersCustomersId = prefs!.getString('usersCustomersId');
//     // empUsersCustomersId = empPrefs!.getString('empUsersCustomersId');
//     print("usersCustomersId = $usersCustomersId");
//     print("empUsersCustomersId = ${widget.other_users_customers_id}");
//
//     setState(() {
//       loading = true;
//     });
//     String apiUrl = getUserChatApiUrl;
//     print("working");
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {"Accept": "application/json"},
//       body: {
//         "requestType": "getMessages",
//         "users_customers_id": usersCustomersId,
//         "other_users_customers_id": widget.other_users_customers_id,
//       },
//     );
//     final responseString = response.body;
//     print("getMessgeModelApiUrl: ${response.body}");
//     print("status Code getMessgeModel: ${response.statusCode}");
//     print("in 200 getMessgeModel");
//     if (response.statusCode == 200) {
//       getMessageModel = getMessgeModelFromJson(responseString);
//       // setState(() {});
//       print('getMessgemodel status: ${getMessageModel.status}');
//       print('getMessgemodel message: ${getMessageModel.data?[0].message}');
//     }
//     setState(() {
//       loading = false;
//     });
//   }
//
//   updateChatApiWidget() async {
//     setState(() {
//       loading = true;
//     });
//
//     prefs = await SharedPreferences.getInstance();
//     usersCustomersId = prefs!.getString('usersCustomersId');
//     // empUsersCustomersId = empPrefs!.getString('empUsersCustomersId');
//     print("usersCustomersId = $usersCustomersId");
//     print("empUsersCustomersId = ${widget.other_users_customers_id}");
//
//     Map body = {
//       "requestType": "updateMessages",
//       "users_customers_id": usersCustomersId,
//       "other_users_customers_id": widget.other_users_customers_id,
//     };
//     http.Response response = await http.post(Uri.parse(updateMessageApiUrl),
//         body: body, headers: {"Accept": "application/json"});
//     Map jsonData = jsonDecode(response.body);
//     print("updateMessageApiUrl: $updateMessageApiUrl");
//     print('updateMessageApiResponse $jsonData');
//
//     if (jsonData['message'] == 'no chat found') {
//       print('no chat found');
//       // setState(() {
//       //   loading = false;
//       // });
//     } else if (response.statusCode == 200) {
//       for (int i = 0; i < jsonData['data'].length; i++) {
//         Map<String, dynamic> obj = jsonData['data'][i];
//         print(obj['id']);
//         var pos = UpdateMessgeModel();
//         pos = UpdateMessgeModel.fromJson(obj);
//         updateMessageModelObject.add(pos);
//         print("updateMessagesLength: ${updateMessageModelObject.length}");
//         setState(() {
//           getMessageApi();
//         });
//       }
//     }
//   }
//
//   sendMessageApiWidget() async {
//     setState(() {
//       loading = true;
//     });
//
//     prefs = await SharedPreferences.getInstance();
//     usersCustomersId = prefs!.getString('usersCustomersId');
//     // empUsersCustomersId = empPrefs!.getString('empUsersCustomersId');
//     print("usersCustomersId = $usersCustomersId");
//     print("empUsersCustomersId = ${widget.other_users_customers_id}");
//
//     Map body = {
//       "requestType": "sendMessage",
//       "sender_type": "Customer",
//       "messageType":   "text",
//       "users_customers_id": usersCustomersId,
//       "other_users_customers_id": widget.other_users_customers_id,
//       "content": sendMessageController.text,
//       "image" : "",
//     };
//     http.Response response = await http.post(
//         Uri.parse(sendMessageCustomerApiUrl),
//         body: body,
//         headers: {"Accept": "application/json"});
//     Map jsonData = jsonDecode(response.body);
//     print("sendMessageApiUrl: $sendMessageCustomerApiUrl");
//     print("sendMessageText: ${sendMessageController.text}");
//     print('sendMessageApiResponse $jsonData');
//     if (jsonData['message'] == 'Message sent successfully.') {
//       // toastSuccessMessage("Message sent.", Colors.green);
//       print('Message sent successfully.');
//       setState(() {
//         loading = false;
//         getMessageApi();
//       });
//     }
//   }
//
//   sharedPrefs() async {
//     setState(() {
//       getMessageApi();
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(_scrollController.position.maxScrollExtent,
//             duration: const Duration(milliseconds: 500),
//             curve: Curves.easeInOut);
//         print("objectr3qF");
//       }
//       print("object");
//     });
//     sharedPrefs();
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     // var cron = Cron();
//     // cron.schedule(Schedule.parse('*/03 * * * * *'), () async {
//     //   print('auto refresh after 03 seconds allChatMessageApi');
//     //   await getMessageApi();
//     // });
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: GestureDetector(
//           onTap: () {
//             Get.to(bottom_bar(
//               currentIndex: 1,
//             ));
//           },
//           child: Center(
//               child: SvgPicture.asset(
//                 "assets/images/left.svg",
//               )),
//         ),
//         title: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 05),
//           child: ListTile(
//             title: Text(
//               // fullName!,
//               // g.data![index].usersData!.fullName.toString(),
//               "${widget.name.toString()}",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontFamily: "Outfit",
//                 fontWeight: FontWeight.w500,
//                 fontSize: 14,
//               ),
//             ),
//             subtitle: Text(
//               "Online",
//               // getUserChatModel.data
//               style: TextStyle(
//                 color: Color(0xffA7AEC1),
//                 fontFamily: "Outfit",
//                 fontWeight: FontWeight.w300,
//                 fontSize: 14,
//               ),
//             ),
//             leading: Stack(
//               children: [
//                 // ClipRRect(
//                 //   borderRadius: BorderRadius.circular(120),
//                 //   child: FadeInImage(
//                 //     placeholder: AssetImage("assets/images/fade_in_image.jpeg"),
//                 //     image: NetworkImage("${widget.img}"),
//                 //   ),
//                 // ),
//                 CircleAvatar(
//                   // radius: (screenWidth > 600) ? 90 : 70,
//                   radius: 30,
//
//                   backgroundImage: NetworkImage("${widget.img}"),
//                 ),
//                 // Image.network(widget.img.toString(),),
//                 Positioned(
//                   top: 5,
//                   right: 3,
//                   child: Container(
//                     height: 10,
//                     width: 10,
//                     decoration: BoxDecoration(
//                       color: Colors.green,
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                           color: Theme.of(context).scaffoldBackgroundColor,
//                           width: 1.5),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         // actions: [
//         //   Padding(
//         //   padding:  EdgeInsets.only(left:  width * 0.08),
//         //   child: Row(
//         //     children: [
//         //       GestureDetector(
//         //           onTap: (){
//         //             Get.back();
//         //           },
//         //           child: SvgPicture.asset("assets/images/left.svg",)),
//         //       Padding(
//         //         padding: const EdgeInsets.only(left: 20.0, right: 10),
//         //         child:
//         //       ),
//         //       Column(
//         //         mainAxisAlignment: MainAxisAlignment.start,
//         //         crossAxisAlignment: CrossAxisAlignment.start,
//         //         children: [
//         //
//
//         //         ],
//         //       ),
//         //     ],
//         //   ),
//         // ),
//         // ],
//       ),
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Column(children: [
//             //  SizedBox(
//             //    height: height * 0.04,
//             //  ),
//             // Padding(
//             //   padding:  EdgeInsets.only(left:  width * 0.08),
//             //   child: Row(
//             //     children: [
//             //       GestureDetector(
//             //         onTap: (){
//             //           Get.back();
//             // },
//             //           child: SvgPicture.asset("assets/images/left.svg",)),
//             //       Padding(
//             //         padding: const EdgeInsets.only(left: 20.0, right: 10),
//             //         child: Stack(
//             //           children: [
//             //             Image.asset("assets/images/person.png"),
//             //             Positioned(
//             //                 top: 5,
//             //                 right: 6,
//             //                 child: Container(
//             //                   height: 10,
//             //                   width: 10,
//             //                   decoration:
//             //                   BoxDecoration(
//             //                     color: Colors.green,
//             //                     shape:
//             //                     BoxShape.circle,
//             //                     border: Border.all(
//             //                         color: Theme.of(
//             //                             context)
//             //                             .scaffoldBackgroundColor,
//             //                         width: 1.5),
//             //                   ),
//             //                 ),)
//             //           ],
//             //         ),
//             //       ),
//             //       Column(
//             //         mainAxisAlignment: MainAxisAlignment.start,
//             //         crossAxisAlignment: CrossAxisAlignment.start,
//             //         children: [
//             //           Text(
//             //             "Maddy Lin",
//             //             style: TextStyle(
//             //               color: Colors.black,
//             //               fontFamily: "Outfit",
//             //               fontWeight: FontWeight.w500,
//             //               fontSize: 14,
//             //             ),
//             //           ),
//             //           Text(
//             //             "Online",
//             //             style: TextStyle(
//             //               color: Color(0xffA7AEC1),
//             //               fontFamily: "Outfit",
//             //               fontWeight: FontWeight.w300,
//             //               fontSize: 14,
//             //             ),
//             //           ),
//             //         ],
//             //       ),
//             //     ],
//             //   ),
//             // ),
//             //  SizedBox(
//             //    height: height * 0.04,
//             //  ),
//             loading
//                 ? Container(
//                 height: height * 0.78,
//                 child: Center(
//                     child: CircularProgressIndicator(
//                         color: Colors.blueAccent)))
//                 : ModalProgressHUD(
//               inAsyncCall: progress,
//               opacity: 0.02,
//               blur: 0.5,
//               color: Colors.transparent,
//               progressIndicator:
//               CircularProgressIndicator(color: Colors.blue),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     getMessageModel.data != null
//                         ? Container(
//                       height:
//                       MediaQuery.of(context).size.height * 0.78,
//                       color: Colors.transparent,
//                       child: Stack(
//                         children: [
//                           ListView.builder(
//                             itemCount: getMessageModel.data?.length,
//                             shrinkWrap: true,
//                             controller: _scrollController,
//                             reverse: true,
//                             padding: EdgeInsets.only(
//                                 top: 10, bottom: 10),
//                             physics: BouncingScrollPhysics(),
//                             itemBuilder: (context, index) {
//                               // final message = getMessageModel.data?[index];
//                               int reverseIndex = getMessageModel.data!.length - 1 - index;
//                               return getMessageModel.data!.isEmpty
//                                   ? Center(child: Text("no chat history"),)
//                                   : Container(
//                                 padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10,),
//                                 child: Align(
//                                   alignment: (
//                                       getMessageModel.data?[
//                                       reverseIndex].senderType == "Customer"
//                                           ? Alignment.topRight
//                                           : Alignment.topLeft
//                                   ),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius:
//                                       BorderRadius.only(
//                                         topRight: Radius.circular(20),
//                                         topLeft: Radius.circular(20),
//                                         bottomLeft: Radius.circular(20),
//                                       ),
//                                       color: (getMessageModel.data?[reverseIndex].senderType == "Customer" && getMessageModel.data?[reverseIndex].msgType == "text"
//                                           ? Color(0xff2B65EC)
//                                           : Colors.transparent
//                                       ),
//                                     ),
//                                     padding: EdgeInsets.all(10),
//                                     child: getMessageModel.data?[reverseIndex].senderType == "Customer"
//                                         ? getMessageModel.data![reverseIndex].msgType == "attachment"
//                                         ? Container(
//                                       child: Column(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment
//                                             .end,
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment
//                                             .end,
//                                         children: [
//                                           ClipRRect(
//                                             borderRadius:
//                                             BorderRadius.only(
//                                               topRight:
//                                               Radius.circular(20),
//                                               topLeft:
//                                               Radius.circular(20),
//                                               bottomLeft:
//                                               Radius.circular(20),
//                                             ),
//                                             child:
//                                             // Image.asset("assets/images/jobarea.png", width: 96, height: 96,),
//                                             FadeInImage(
//                                               placeholder:
//                                               AssetImage(
//                                                 "assets/images/fade_in_image.jpeg",
//                                               ),
//                                               fit: BoxFit
//                                                   .fill,
//                                               width:
//                                               115,
//                                               height:
//                                               110,
//                                               image:
//                                               NetworkImage("$baseUrlImage${getMessageModel.data?[reverseIndex].message}"),
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding:
//                                             const EdgeInsets.only(top: 3.0),
//                                             child: Text(
//                                               // "time",
//                                                 "${getMessageModel.data?[reverseIndex].time} ${getMessageModel.data?[reverseIndex].date}",
//                                                 maxLines: 1,
//                                                 overflow: TextOverflow.ellipsis,
//                                                 textAlign: TextAlign.right,
//                                                 style: TextStyle(fontSize: 10, color: Color(0xffA7A9B7), fontFamily: "Outfit")),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                         : Column(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment
//                                           .end,
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment
//                                           .end,
//                                       children: [
//                                         Text(
//                                           // "${messages[].}",
//                                             "${getMessageModel.data?[reverseIndex].message}",
//                                             // "${messageDetailsModelObject[reverseIndex].data?[index].message}",
//                                             maxLines:
//                                             3,
//                                             overflow:
//                                             TextOverflow
//                                                 .ellipsis,
//                                             textAlign:
//                                             TextAlign
//                                                 .left,
//                                             style: TextStyle(
//                                                 fontSize:
//                                                 14,
//                                                 fontFamily:
//                                                 "Outfit",
//                                                 color:
//                                                 Colors.white)),
//                                         SizedBox(
//                                             height:
//                                             03),
//                                         Text(
//                                           // "time",
//                                             "${getMessageModel.data?[reverseIndex].time} ${getMessageModel.data?[reverseIndex].date}",
//                                             maxLines:
//                                             1,
//                                             overflow:
//                                             TextOverflow
//                                                 .ellipsis,
//                                             textAlign:
//                                             TextAlign
//                                                 .right,
//                                             style: TextStyle(
//                                                 fontSize:
//                                                 10,
//                                                 color:
//                                                 Colors.white,
//                                                 fontFamily: "Outfit")),
//                                       ],
//                                     )
//                                         : getMessageModel
//                                         .data?[
//                                     reverseIndex]
//                                         .senderType !=
//                                         "Customer"
//                                         ? getMessageModel
//                                         .data![
//                                     reverseIndex]
//                                         .msgType ==
//                                         "attachment"
//                                         ? Container(
//                                       child:
//                                       Column(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.end,
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.end,
//                                         children: [
//                                           ClipRRect(
//                                             borderRadius:
//                                             BorderRadius.only(
//                                               topRight: Radius.circular(20),
//                                               topLeft: Radius.circular(20),
//                                               bottomRight: Radius.circular(20),
//                                             ),
//                                             child:
//                                             // Image.asset("assets/images/jobarea.png", width: 96, height: 96,),
//                                             FadeInImage(
//                                               placeholder: AssetImage(
//                                                 "assets/images/fade_in_image.jpeg",
//                                               ),
//                                               fit: BoxFit.fill,
//                                               width: 115,
//                                               height: 110,
//                                               image: NetworkImage("$baseUrlImage${getMessageModel.data?[reverseIndex].message}"),
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding:
//                                             const EdgeInsets.only(top: 3.0),
//                                             child: Text(
//                                               // "time",
//                                                 "${getMessageModel.data?[reverseIndex].time} ${getMessageModel.data?[reverseIndex].date}",
//                                                 maxLines: 1,
//                                                 overflow: TextOverflow.ellipsis,
//                                                 textAlign: TextAlign.right,
//                                                 style: TextStyle(fontSize: 10, color: Color(0xffA7A9B7), fontFamily: "Outfit")),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                         : Container(
//                                       height: 54,
//                                       padding: EdgeInsets.all(10),
//                                       decoration: BoxDecoration(
//                                         borderRadius:
//                                         BorderRadius.only(
//                                           topRight: Radius.circular(20),
//                                           topLeft: Radius.circular(20),
//                                           bottomRight: Radius.circular(20),
//                                         ),
//                                         color: (getMessageModel.data?[reverseIndex].senderType != "Customer" && getMessageModel.data?[reverseIndex].msgType == "text"
//                                             ? Color(0xffEBEBEB)
//                                             : Color(0xff2B65EC)
//                                         ),
//                                       ),
//                                       child:
//                                       Column(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.end,
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.end,
//                                         children: [
//                                           Text(
//                                               "${getMessageModel.data?[reverseIndex].message}",
//                                               maxLines: 3,
//                                               overflow: TextOverflow.ellipsis,
//                                               textAlign: TextAlign.left,
//                                               style: TextStyle(fontSize: 14, color: Colors.black, fontFamily: "Outfit")),
//                                           SizedBox(
//                                               height: 03),
//                                           Text(
//                                             // "time",
//                                             "${getMessageModel.data?[reverseIndex].time} ${getMessageModel.data?[reverseIndex].date}",
//                                             overflow:
//                                             TextOverflow.ellipsis,
//                                             textAlign:
//                                             TextAlign.left,
//                                             style: TextStyle(
//                                                 fontSize: 10,
//                                                 color: Colors.black,
//                                                 fontFamily: "Outfit"),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                         : Container(),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     )
//                         : Container(
//                       height: Get.height * 0.78,
//                     ),
//                     // Chat(
//                     //   theme: DefaultChatTheme(
//                     //     inputTextCursorColor: Color(0xff8C8C8C),
//                     //     inputTextColor: Color(0xff8C8C8C),
//                     //     inputTextStyle: TextStyle(
//                     //       color: Color(0xff8C8C8C),
//                     //       fontFamily: "Outfit",
//                     //       fontWeight: FontWeight.w300,
//                     //       fontSize: 14,
//                     //     ),
//                     //     // primaryColor: Color(Helpers.secondry),
//                     //     // secondaryColor: Colors.white,
//                     //     // backgroundColor:Colors.white,
//                     //
//                     //     inputBorderRadius: BorderRadius.circular(10),
//                     //     inputBackgroundColor: Color(0xffF9F9F9),
//                     //     inputContainerDecoration: BoxDecoration(
//                     //         borderRadius: BorderRadius.circular(40),
//                     //         boxShadow: [
//                     //           // BoxShadow(
//                     //           //   // color: Color(0xff4DA0E6),
//                     //           //   blurRadius: 8,
//                     //           //     offset:  Offset(0, -3),
//                     //           // ),
//                     //         ]),
//                     //   ),
//                     //   disableImageGallery: true,
//                     //   messages: _messages,
//                     //   onAttachmentPressed: _handleAttachmentPressed,
//                     //   onMessageTap: _handleMessageTap,
//                     //   onPreviewDataFetched: _handlePreviewDataFetched,
//                     //   onSendPressed: _handleSendPressed,
//                     //   showUserAvatars: true,
//                     //   showUserNames: true,
//                     //   user: _user,
//                     // ),
//                   ],
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomLeft,
//               child: Container(
//                 padding: EdgeInsets.only(left: 10, top: 30),
//                 child: Row(
//                   children: <Widget>[
//                     sendMessageTextFields(),
//                     SizedBox(width: 05),
//                     FloatingActionButton(
//                       onPressed: () async {
//                         if (sendMessageFormKey.currentState!.validate()) {
//                           if (sendMessageController.text.isEmpty)  {
//                             toastFailedMessage(
//                                 'please type a message', Colors.red);
//                           } else {
//                             setState(() {
//                               progress = true;
//                             });
//                             await sendMessageApiWidget();
//                             Future.delayed(Duration(seconds: 3), () {
//                               print("sendMessage Success");
//                               setState(() {
//                                 progress = false;
//                                 sendMessageController.clear();
//                               });
//                               print("false: $progress");
//                             });
//                           }
//                         }
//                       },
//                       backgroundColor: Colors.white,
//                       elevation: 0,
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 10.0),
//                         child: SvgPicture.asset("assets/images/send.svg"),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
//
//   Widget sendMessageTextFields() {
//     return Form(
//       key: sendMessageFormKey,
//       child: Expanded(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 05, vertical: 0),
//           decoration: BoxDecoration(
//               color: Color(0xffF9F9F9),
//               borderRadius: BorderRadius.circular(20)),
//           child: Row(
//             children: [
//               GestureDetector(
//                 onTap: () {
// //                   Get.bottomSheet(
// //                     Container(
// //                       height: 100,
// //                       child: Wrap(
// //                         children: [
// //                           ListTile(
// //                             title: Text("Pick from Gallery"),
// //                             leading: Icon(Icons.photo),
// //                             onTap: () {
// //                              pickImageGallery();
// //                              Get.back();
// //                             },
// //                           ),
// //                           // ListTile(
// //                           //   title: Text("Pick from "),
// //                           //   leading: Icon(Icons.dark_mode_rounded),
// //                           //   onTap: () {
// //                           //     Get.changeTheme(ThemeData.dark());
// //                           //   },
// //                           // ),
// //                         ],
// //                       ),
// //                     ),
// //                     // barrierColor: Colors.greenAccent,
// //                     backgroundColor: Colors.grey.shade200,
// // // isDismissible: false,
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(20),
// //                       side: BorderSide(
// //                         color: Colors.white,
// //                         style: BorderStyle.solid,
// //                         width: 2,
// //                       ),
// //                     ),
// //                     enableDrag: false,
// //                   );
// //                 if(base64img == null )
// //                 sendImageApiWidget();
// //                   setState(() {
//                   pickImageGallery();
// //                   });
//                   Future.delayed(const Duration(seconds: 5), () {
//                     if(base64img != null){
//                       sendImageApiWidget();
//                     } else{
//                       toastFailedMessage("failed", Colors.red);
//                     }
//                   });
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: SvgPicture.asset(
//                     "assets/images/paperclip.svg",
//                     width: 25,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   // padding: EdgeInsets.symmetric(horizontal: 05, vertical: 0),
//                   // decoration: BoxDecoration(
//                   //     color: Color(0xffF9F9F9),
//                   //     borderRadius: BorderRadius.circular(20)),
//                   child: TextField(
//                     cursorColor: Colors.blue,
//                     textAlign: TextAlign.left,
//                     controller: sendMessageController,
//                     decoration: InputDecoration(
//                         contentPadding: EdgeInsets.only(left: 10, bottom: 3),
//                         hintText: "Type your message",
//                         hintStyle: TextStyle(
//                             fontSize: 14,
//                             fontFamily: "Outfit",
//                             color: Color(0xffD4DCE1)),
//                         fillColor: Colors.white,
//                         border: InputBorder.none),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   File? imagePath;
//   String? base64img;
//
//   sendImageApiWidget() async {
//     setState(() {
//       loading = true;
//     });
//
//     prefs = await SharedPreferences.getInstance();
//     usersCustomersId = prefs!.getString('usersCustomersId');
//     // empUsersCustomersId = empPrefs!.getString('empUsersCustomersId');
//     print("usersCustomersId = $usersCustomersId");
//     print("empUsersCustomersId = ${widget.other_users_customers_id}");
//
//     Map body = {
//       "requestType": "sendMessage",
//       "sender_type": "Customer",
//       "messageType":   "attachment",
//       "users_customers_id": usersCustomersId,
//       "other_users_customers_id": widget.other_users_customers_id,
//       "content": "",
//       "image" : base64img,
//     };
//     http.Response response = await http.post(
//         Uri.parse(sendMessageCustomerApiUrl),
//         body: body,
//         headers: {"Accept": "application/json"});
//     Map jsonData = jsonDecode(response.body);
//     print("sendImageApiUrl: $sendMessageCustomerApiUrl");
//     print("sendMessageText: ${sendMessageController.text}");
//     print('sendImage $jsonData');
//     if (jsonData['message'] == 'Message sent successfully.') {
//       // toastSuccessMessage("Message sent.", Colors.green);
//       print('Message sent successfully.');
//       setState(() {
//         loading = false;
//         getMessageApi();
//       });
//     }
//   }
//
//   Future pickImageGallery() async {
//     try {
//       final ImagePicker _picker = ImagePicker();
//       final XFile? xFile = await _picker.pickImage(source: ImageSource.gallery);
//       if (xFile == null) return;
//
//       Uint8List imageByte = await xFile.readAsBytes();
//       base64img = base64.encode(imageByte);
//       print("base64img $base64img");
//
//       final imageTemporary = File(xFile.path);
//
//       setState(() {
//         imagePath = imageTemporary;
//         print("newImage $imagePath");
//       });
//     } on PlatformException catch (e) {
//       print('Failed to pick image: ${e.toString()}');
//     }
//   }
// }
//
// // class MessageDetailsScreen extends StatefulWidget {
// //   final String? image, name, usersCustomersId, other_users_customers_id;
// //
// //   MessageDetailsScreen(
// //       {Key? key,
// //       this.usersCustomersId,
// //       this.other_users_customers_id,
// //       this.name,
// //       this.image})
// //       : super(key: key);
// //
// //   @override
// //   State<MessageDetailsScreen> createState() => _MessageDetailsScreenState();
// // }
// //
// // class _MessageDetailsScreenState extends State<MessageDetailsScreen> {
// //   var sendMessageController = TextEditingController();
// //   final GlobalKey<FormState> sendMessageFormKey = GlobalKey<FormState>();
// //   List<GetMessgeModel> messageDetailsModelObject = [];
// //   List<GetMessgeModel> newMessageObject = [];
// //   List<UpdateMessgeModel> updateMessageModelObject = [];
// //   SendMessgeCustomerModel sendMessgeCustomerModel = SendMessgeCustomerModel();
// //   bool loading = true;
// //
// //   Map jsonData = {};
// //
// //   getMessageApi() async {
// //     prefs = await SharedPreferences.getInstance();
// //     usersCustomersId = prefs!.getString('usersCustomersId');
// //     // empUsersCustomersId = empPrefs!.getString('empUsersCustomersId');
// //     print("usersCustomersId = $usersCustomersId");
// //     print("empUsersCustomersId = ${widget.other_users_customers_id}");
// //     Map body = {
// //       "requestType": "getMessages",
// //       "users_customers_id": usersCustomersId,
// //       "other_users_customers_id": widget.other_users_customers_id,
// //     };
// //     http.Response response = await http.post(Uri.parse(getUserChatApiUrl),
// //         body: body, headers: {"Accept": "application/json"});
// //     messageDetailsModelObject.clear();
// //     jsonData = jsonDecode(response.body);
// //     print("allChatApi: $getAllChatApiUrl");
// //     print("statusCode: ${response.statusCode}");
// //     print("responseData: $jsonData");
// //
// //     if (jsonData['status'] == 'error') {
// //       // toastSuccessMessage("no chat history", kRed);
// //       print('no chat history');
// //       setState(() {
// //         loading = false;
// //       });
// //     } else if (response.statusCode == 200) {
// //       for (int i = 0; i < jsonData['data'].length; i++) {
// //         Map<String, dynamic> obj = jsonData['data'][i];
// //         var pos = GetMessgeModel();
// //         pos = GetMessgeModel.fromJson(obj);
// //         messageDetailsModelObject.add(pos);
// //       }
// //       print("allChatLength: ${messageDetailsModelObject.length}");
// //       loading = false;
// //       setState(() {
// //         updateChatApiWidget();
// //       });
// //     }
// //   }
// //
// //   updateChatApiWidget() async {
// //     // setState(() {
// //     //   loading = true;
// //     // });
// //     Map body = {
// //       "requestType": "updateMessages",
// //       "users_customers_id": usersCustomersId,
// //       "other_users_customers_id": widget.other_users_customers_id,
// //     };
// //     http.Response response = await http.post(Uri.parse(updateMessageApiUrl),
// //         body: body, headers: {"Accept": "application/json"});
// //     Map jsonData = jsonDecode(response.body);
// //     print("updateMessageApiUrl: $updateMessageApiUrl");
// //     print('updateMessageApiResponse $jsonData');
// //
// //     if (jsonData['message'] == 'no chat found') {
// //       // toastSuccessMessage("no chat found", kRed);
// //       print('no chat found');
// //       // setState(() {
// //       //   loading = false;
// //       // });
// //     } else if (response.statusCode == 200) {
// //       for (int i = 0; i < jsonData['data'].length; i++) {
// //         Map<String, dynamic> obj = jsonData['data'][i];
// //         print(obj['id']);
// //         var pos = UpdateMessgeModel();
// //         pos = UpdateMessgeModel.fromJson(obj);
// //         updateMessageModelObject.add(pos);
// //         print("updateMessagesLength: ${updateMessageModelObject.length}");
// //         setState(() {
// //           getMessageApi();
// //         });
// //       }
// //     }
// //   }
// //
// //   sendMessageApiWidget() async {
// //     setState(() {
// //       loading = true;
// //     });
// //     Map body = {
// //       "requestType": "sendMessage",
// //       "sender_type": "Customer",
// //       "messageType": "1",
// //       "users_customers_id": usersCustomersId,
// //       "other_users_customers_id": widget.other_users_customers_id,
// //       "content": sendMessageController.text,
// //     };
// //     http.Response response = await http.post(
// //         Uri.parse(sendMessageCustomerApiUrl),
// //         body: body,
// //         headers: {"Accept": "application/json"});
// //     Map jsonData = jsonDecode(response.body);
// //     print("sendMessageApiUrl: $sendMessageCustomerApiUrl");
// //     print("sendMessageText: ${sendMessageController.text}");
// //     print('sendMessageApiResponse $jsonData');
// //
// //     if (jsonData['message'] == 'Message sent successfully.') {
// //       // toastSuccessMessage("Message sent successfully1.", colorGreen);
// //       print('Message sent successfully.');
// //       setState(() {
// //         loading = false;
// //         getMessageApi();
// //       });
// //     }
// //   }
// //
// //   sharedPrefs() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     print('in msgs details shared prefs');
// //     prefs = await SharedPreferences.getInstance();
// //     usersCustomersId = prefs.getString('userid');
// //     print("userId in Prefs is = $usersCustomersId");
// //
// //     setState(() {
// //       getMessageApi();
// //     });
// //   }
// //
// //   // String? carOwnerName1, carOwnerImage1, other_users_customers_id;
// //   // int? carOwnerID1;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     sharedPrefs();
// //   }
// //
// //   bool progress = false;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     var cron = Cron();
// //     cron.schedule(Schedule.parse('*/03 * * * * *'), () async {
// //       print('auto refresh after 03 seconds allChatMessageApi');
// //       // await getMessageApi();
// //     });
// //
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         leading: GestureDetector(
// //           onTap: () {
// //             Get.to(bottom_bar(
// //               currentIndex: 1,
// //             ));
// //           },
// //           child: Center(
// //               child: SvgPicture.asset(
// //             "assets/images/left.svg",
// //           )),
// //         ),
// //         title: Padding(
// //           padding: const EdgeInsets.symmetric(vertical: 05),
// //           child: ListTile(
// //             title: Text(
// //               // fullName!,
// //               // g.data![index].usersData!.fullName.toString(),
// //               "${widget.name.toString()}",
// //               style: TextStyle(
// //                 color: Colors.black,
// //                 fontFamily: "Outfit",
// //                 fontWeight: FontWeight.w500,
// //                 fontSize: 14,
// //               ),
// //             ),
// //             subtitle: Text(
// //               "Online",
// //               // getUserChatModel.data
// //               style: TextStyle(
// //                 color: Color(0xffA7AEC1),
// //                 fontFamily: "Outfit",
// //                 fontWeight: FontWeight.w300,
// //                 fontSize: 14,
// //               ),
// //             ),
// //             leading: Stack(
// //               children: [
// //                 // ClipRRect(
// //                 //   borderRadius: BorderRadius.circular(120),
// //                 //   child: FadeInImage(
// //                 //     placeholder: AssetImage("assets/images/fade_in_image.jpeg"),
// //                 //     image: NetworkImage("${widget.img}"),
// //                 //   ),
// //                 // ),
// //                 CircleAvatar(
// //                   // radius: (screenWidth > 600) ? 90 : 70,
// //                   radius: 30,
// //
// //                   backgroundImage: NetworkImage("${widget.image}"),
// //                 ),
// //                 // Image.network(widget.img.toString(),),
// //                 Positioned(
// //                   top: 5,
// //                   right: 3,
// //                   child: Container(
// //                     height: 10,
// //                     width: 10,
// //                     decoration: BoxDecoration(
// //                       color: Colors.green,
// //                       shape: BoxShape.circle,
// //                       border: Border.all(
// //                           color: Theme.of(context).scaffoldBackgroundColor,
// //                           width: 1.5),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //       backgroundColor: Colors.white,
// //       body: loading
// //           ? Center(child: CircularProgressIndicator(color: Colors.blue))
// //           :
// //           // messageDetailsModelObject.isEmpty?  Center(child: Text("no chat history")):
// //           ModalProgressHUD(
// //               inAsyncCall: progress,
// //               opacity: 0.02,
// //               blur: 0.5,
// //               color: Colors.transparent,
// //               progressIndicator: CircularProgressIndicator(color: Colors.blue),
// //               child: SingleChildScrollView(
// //                 child: Column(
// //                   children: [
// //                     Container(
// //                       height: MediaQuery.of(context).size.height * 0.78,
// //                       color: Colors.transparent,
// //                       child: Stack(
// //                         children: [
// //                           ListView.builder(
// //                             itemCount: messageDetailsModelObject.length,
// //                             shrinkWrap: true,
// //                             reverse: true,
// //                             padding: EdgeInsets.only(top: 10, bottom: 10),
// //                             physics: BouncingScrollPhysics(),
// //                             itemBuilder: (context, index) {
// //                               int reverseIndex =
// //                                   messageDetailsModelObject.length - 1 - index;
// //                               return Container(
// //                                 padding: EdgeInsets.only(
// //                                     left: 14, right: 14, top: 10, bottom: 10),
// //                                 child: Align(
// //                                   alignment:
// //                                       (messageDetailsModelObject[reverseIndex]
// //                                                   .data?[index]
// //                                                   .senderType ==
// //                                               "Customer"
// //                                           ? Alignment.topRight
// //                                           : Alignment.topLeft),
// //                                   child: Container(
// //                                     decoration: BoxDecoration(
// //                                       borderRadius: BorderRadius.circular(20),
// //                                       color: (messageDetailsModelObject[
// //                                                       reverseIndex]
// //                                                   .data?[index]
// //                                                   .senderType ==
// //                                               "Customer"
// //                                           ? Colors.blue
// //                                           : Colors.white),
// //                                     ),
// //                                     padding: EdgeInsets.all(10),
// //                                     child: messageDetailsModelObject[
// //                                                     reverseIndex]
// //                                                 .data?[index]
// //                                                 .senderType ==
// //                                             "Customer"
// //                                         ? Column(
// //                                             children: [
// //                                               Text(
// //                                                   messageDetailsModelObject[
// //                                                           reverseIndex]
// //                                                       .data![index]
// //                                                       .message
// //                                                       .toString(),
// //                                                   maxLines: 3,
// //                                                   overflow:
// //                                                       TextOverflow.ellipsis,
// //                                                   textAlign: TextAlign.left,
// //                                                   style: TextStyle(
// //                                                       fontSize: 14,
// //                                                       fontFamily: "Outfit",
// //                                                       color: Colors.white)),
// //                                               SizedBox(height: 03),
// //                                               Text(
// //                                                   "${messageDetailsModelObject[reverseIndex].data?[index].time.toString()} ${messageDetailsModelObject[reverseIndex].data?[index].date.toString()}",
// //                                                   maxLines: 1,
// //                                                   overflow:
// //                                                       TextOverflow.ellipsis,
// //                                                   textAlign: TextAlign.right,
// //                                                   style: TextStyle(
// //                                                       fontSize: 10,
// //                                                       color: Colors.white,
// //                                                       fontFamily: "Outfit")),
// //                                             ],
// //                                           )
// //                                         : Column(
// //                                             children: [
// //                                               Text(
// //                                                   messageDetailsModelObject[
// //                                                           reverseIndex]
// //                                                       .data![index]
// //                                                       .message
// //                                                       .toString(),
// //                                                   maxLines: 3,
// //                                                   overflow:
// //                                                       TextOverflow.ellipsis,
// //                                                   textAlign: TextAlign.left,
// //                                                   style: TextStyle(
// //                                                       fontSize: 14,
// //                                                       color: Colors.black,
// //                                                       fontFamily: "Outfit")),
// //                                               SizedBox(height: 03),
// //                                               Text(
// //                                                   "${messageDetailsModelObject[reverseIndex].data?[index].time.toString()} ${messageDetailsModelObject[reverseIndex]..data?[index].date.toString()}",
// //                                                   maxLines: 1,
// //                                                   overflow:
// //                                                       TextOverflow.ellipsis,
// //                                                   textAlign: TextAlign.left,
// //                                                   style: TextStyle(
// //                                                       fontSize: 10,
// //                                                       color: Colors.black,
// //                                                       fontFamily: "Outfit")),
// //                                             ],
// //                                           ),
// //                                   ),
// //                                 ),
// //                               );
// //                             },
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                     Align(
// //                       alignment: Alignment.bottomLeft,
// //                       child: Container(
// //                         padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
// //                         height: 65,
// //                         child: Row(
// //                           children: <Widget>[
// //                             sendMessageTextFields(),
// //                             SizedBox(width: 05),
// //                             FloatingActionButton(
// //                               onPressed: () async {
// //                                 if (sendMessageFormKey.currentState!
// //                                     .validate()) {
// //                                   if (sendMessageController.text.isEmpty) {
// //                                     toastFailedMessage(
// //                                         'please type a message', Colors.red);
// //                                   } else {
// //                                     setState(() {
// //                                       progress = true;
// //                                     });
// //                                     await sendMessageApiWidget();
// //                                     Future.delayed(Duration(seconds: 3), () {
// //                                       print("sendMessage Success");
// //                                       // toastSuccessMessage("Message sent successfully2.", colorGreen);
// //                                       setState(() {
// //                                         sendMessageController.clear();
// //                                         progress = false;
// //                                       });
// //                                       print("false: $progress");
// //                                     });
// //                                   }
// //                                 }
// //                               },
// //                               backgroundColor: Colors.grey,
// //                               elevation: 0,
// //                               child: Image.asset(
// //                                 'assets/live_chat_images/send.png',
// //                                 height: 30,
// //                                 width: 30,
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //     );
// //   }
// //
// //   Widget sendMessageTextFields() {
// //     return Form(
// //       key: sendMessageFormKey,
// //       child: Expanded(
// //         child: Container(
// //           padding: EdgeInsets.symmetric(horizontal: 05, vertical: 0),
// //           decoration: BoxDecoration(
// //               color: Colors.white, borderRadius: BorderRadius.circular(20)),
// //           child: TextField(
// //             cursorColor: Colors.black,
// //             textAlign: TextAlign.left,
// //             controller: sendMessageController,
// //             decoration: InputDecoration(
// //                 contentPadding: EdgeInsets.only(left: 10, bottom: 3),
// //                 hintText: "Type your message here.....",
// //                 hintStyle: TextStyle(
// //                     fontSize: 14,
// //                     fontFamily: "Outfit",
// //                     color: Color(0xffD4DCE1)),
// //                 fillColor: Colors.white,
// //                 border: InputBorder.none),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class ChatMessage {
// //   String? messageContent;
// //   String? messageType;
// //
// //   ChatMessage({@required this.messageContent, @required this.messageType});
// // }
// //
// // class ChatScreen extends StatefulWidget {
// //   final String? usersCustomersId;
// //   final String? other_users_customers_id;
// //   final String? name;
// //   final String? img;
// //
// //   ChatScreen(
// //       {Key? key,
// //       this.usersCustomersId,
// //       this.other_users_customers_id,
// //       this.name,
// //       this.img})
// //       : super(key: key);
// //
// //   @override
// //   _ChatScreenState createState() => _ChatScreenState();
// // }
// //
// // class _ChatScreenState extends State<ChatScreen> {
// //   List<UpdateMessgeModel> updateMessageModelObject = [];
// //   List<String> messages = [
// //     // 'Hello',
// //     // 'How are you?',
// //     // 'I am doing well. Thanks for asking.',
// //     // 'That\'s great!',
// //     // 'Bye',
// //     // 'Hello',
// //     // 'How are you?',
// //     // 'I am doing well. Thanks for asking.',
// //     // 'That\'s great!',
// //     // 'Bye',
// //     // 'Hello',
// //     // 'How are you?',
// //     // 'I am doing well. Thanks for asking.',
// //     // 'That\'s great!',
// //     // 'Bye',
// //     // 'Hello',
// //     // 'How are you?',
// //     // 'I am doing well. Thanks for asking.',
// //     // 'That\'s great!',
// //     // 'Bye',
// //   ];
// //
// //   ScrollController _scrollController = ScrollController();
// //   String? Image;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     usersCustomersId = widget.usersCustomersId;
// //     Image = widget.img;
// //     print("usersCustomersId $usersCustomersId");
// //     sharedPrefs();
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       _scrollController.animateTo(
// //         _scrollController.position.maxScrollExtent,
// //         duration: Duration(milliseconds: 1000),
// //         curve: Curves.easeInOut,
// //       );
// //     });
// //   }
// //
// //   @override
// //   void dispose() {
// //     _scrollController.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         leading: GestureDetector(
// //           onTap: () {
// //             Get.to(bottom_bar(
// //               currentIndex: 1,
// //             ));
// //           },
// //           child: Center(
// //               child: SvgPicture.asset(
// //             "assets/images/left.svg",
// //           )),
// //         ),
// //         title: Padding(
// //           padding: const EdgeInsets.symmetric(vertical: 05),
// //           child: ListTile(
// //             title: Text(
// //               // fullName!,
// //               // g.data![index].usersData!.fullName.toString(),
// //               "${widget.name.toString()}",
// //               style: TextStyle(
// //                 color: Colors.black,
// //                 fontFamily: "Outfit",
// //                 fontWeight: FontWeight.w500,
// //                 fontSize: 14,
// //               ),
// //             ),
// //             subtitle: Text(
// //               "Online",
// //               // getUserChatModel.data
// //               style: TextStyle(
// //                 color: Color(0xffA7AEC1),
// //                 fontFamily: "Outfit",
// //                 fontWeight: FontWeight.w300,
// //                 fontSize: 14,
// //               ),
// //             ),
// //             leading: Stack(
// //               children: [
// //                 // ClipRRect(
// //                 //   borderRadius: BorderRadius.circular(120),
// //                 //   child: FadeInImage(
// //                 //     placeholder: AssetImage("assets/images/fade_in_image.jpeg"),
// //                 //     image: NetworkImage("${widget.img}"),
// //                 //   ),
// //                 // ),
// //                 CircleAvatar(
// //                   // radius: (screenWidth > 600) ? 90 : 70,
// //                   radius: 30,
// //
// //                   backgroundImage: NetworkImage("${widget.img}"),
// //                 ),
// //                 // Image.network(widget.img.toString(),),
// //                 Positioned(
// //                   top: 5,
// //                   right: 3,
// //                   child: Container(
// //                     height: 10,
// //                     width: 10,
// //                     decoration: BoxDecoration(
// //                       color: Colors.green,
// //                       shape: BoxShape.circle,
// //                       border: Border.all(
// //                           color: Theme.of(context).scaffoldBackgroundColor,
// //                           width: 1.5),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //       backgroundColor: Colors.white,
// //       body: Column(
// //         children: [
// //           getMessageModel.data != null
// //               ? Container(
// //                   height: Get.height * 0.78,
// //                   child: ListView.builder(
// //                     // reverse: true,
// //                     controller: _scrollController,
// //                     itemCount: getMessageModel.data?.length,
// //                     itemBuilder: (BuildContext context, int index) {
// //                       // getMessageModel.data?[index] = messages as Datum;
// //                       final message = getMessageModel.data?[index];
// //
// //                       return getMessageModel.data!.isEmpty
// //                           ? Center(child: Text("no chat history"))
// //                           : Container(
// //                               padding: EdgeInsets.only(
// //                                 left: 14,
// //                                 right: 14,
// //                                 top: 10,
// //                                 bottom: 10,
// //                               ),
// //                               child: Align(
// //                                 alignment: (
// //                                     // messageDetailsModelObject[reverseIndex].data?[index].senderType == "Customer"
// //                                     // messages[reverseIndex].data?[index].senderType == "Customer"
// //                                     message?.senderType == "Customer"
// //                                         ? Alignment.topRight
// //                                         : Alignment.topLeft),
// //                                 child: Container(
// //                                   decoration: BoxDecoration(
// //                                     borderRadius: BorderRadius.circular(20),
// //                                     color: (message?.senderType == "Customer"
// //                                         ? Color(0xff2B65EC)
// //                                         : Color(0xffEBEBEB)),
// //                                   ),
// //                                   padding: EdgeInsets.all(10),
// //                                   child: message?.senderType == "Customer"
// //                                       ? Column(
// //                                           mainAxisAlignment:
// //                                               MainAxisAlignment.end,
// //                                           crossAxisAlignment:
// //                                               CrossAxisAlignment.end,
// //                                           children: [
// //                                             Text(
// //                                                 // "${messages[].}",
// //                                                 "${message?.message}",
// //                                                 // "${messageDetailsModelObject[reverseIndex].data?[index].message}",
// //                                                 maxLines: 3,
// //                                                 overflow: TextOverflow.ellipsis,
// //                                                 textAlign: TextAlign.left,
// //                                                 style: TextStyle(
// //                                                     fontSize: 14,
// //                                                     fontFamily: "Outfit",
// //                                                     color: Colors.white)),
// //                                             SizedBox(height: 03),
// //                                             Text(
// //                                                 // "time",
// //                                                 "${message?.time} ${message?.date}",
// //                                                 maxLines: 1,
// //                                                 overflow: TextOverflow.ellipsis,
// //                                                 textAlign: TextAlign.right,
// //                                                 style: TextStyle(
// //                                                     fontSize: 10,
// //                                                     color: Colors.white,
// //                                                     fontFamily: "Outfit")),
// //                                           ],
// //                                         )
// //                                       : Column(
// //                                           mainAxisAlignment:
// //                                               MainAxisAlignment.end,
// //                                           crossAxisAlignment:
// //                                               CrossAxisAlignment.end,
// //                                           children: [
// //                                             Text("${message?.message}",
// //                                                 maxLines: 3,
// //                                                 overflow: TextOverflow.ellipsis,
// //                                                 textAlign: TextAlign.left,
// //                                                 style: TextStyle(
// //                                                     fontSize: 14,
// //                                                     color: Colors.black,
// //                                                     fontFamily: "Outfit")),
// //                                             SizedBox(height: 03),
// //                                             Text(
// //                                               // "time",
// //                                               "${message?.time} ${message?.date}",
// //                                               overflow: TextOverflow.ellipsis,
// //                                               textAlign: TextAlign.left,
// //                                               style: TextStyle(
// //                                                   fontSize: 10,
// //                                                   color: Colors.black,
// //                                                   fontFamily: "Outfit"),
// //                                             ),
// //                                           ],
// //                                         ),
// //                                 ),
// //                               ),
// //                             );
// //                     },
// //                   ),
// //                 )
// //               : Container(
// //                   height: Get.height * 0.78,
// //                 ),
// //           Align(
// //             alignment: Alignment.bottomLeft,
// //             child: Container(
// //               padding: EdgeInsets.only(left: 10, top: 30),
// //               child: Row(
// //                 children: <Widget>[
// //                   sendMessageTextFields(),
// //                   SizedBox(width: 05),
// //                   FloatingActionButton(
// //                     onPressed: () async {
// //                       if (sendMessageFormKey.currentState!.validate()) {
// //                         if (sendMessageController.text.isEmpty) {
// //                           toastFailedMessage(
// //                               'please type a message', Colors.red);
// //                         } else {
// //                           setState(() {
// //                             progress = true;
// //                           });
// //                           await sendMessageApiWidget();
// //                           Future.delayed(Duration(seconds: 3), () {
// //                             print("sendMessage Success");
// //                             setState(() {
// //                               progress = false;
// //                               sendMessageController.clear();
// //                             });
// //                             print("false: $progress");
// //                           });
// //                         }
// //                       }
// //                     },
// //                     backgroundColor: Colors.white,
// //                     elevation: 0,
// //                     child: Padding(
// //                       padding: const EdgeInsets.only(top: 10.0),
// //                       child: SvgPicture.asset("assets/images/send.svg"),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   SendMessgeCustomerModel sendMessageCustomerModel = SendMessgeCustomerModel();
// //   GetMessgeModel getMessageModel = GetMessgeModel();
// //
// //   sendMessageApiWidget() async {
// //     setState(() {
// //       progress = true;
// //     });
// //
// //     prefs = await SharedPreferences.getInstance();
// //     usersCustomersId = prefs!.getString('usersCustomersId');
// //     // empUsersCustomersId = empPrefs!.getString('empUsersCustomersId');
// //     print("usersCustomersId = $usersCustomersId");
// //     print("empUsersCustomersId = ${widget.other_users_customers_id}");
// //
// //     Map body = {
// //       "requestType": "sendMessage",
// //       "sender_type": "Customer",
// //       "messageType": "1",
// //       "users_customers_id": usersCustomersId,
// //       "other_users_customers_id": widget.other_users_customers_id,
// //       "content": sendMessageController.text,
// //     };
// //     http.Response response = await http.post(
// //         Uri.parse(sendMessageCustomerApiUrl),
// //         body: body,
// //         headers: {"Accept": "application/json"});
// //     Map jsonData = jsonDecode(response.body);
// //     print("sendMessageApiUrl: $sendMessageCustomerApiUrl");
// //     print("sendMessageText: ${sendMessageController.text}");
// //     print('sendMessageApiResponse $jsonData');
// //     if (jsonData['message'] == 'Message sent successfully.') {
// //       // toastSuccessMessage("Message sent.", Colors.green);
// //       print('Message sent successfully.');
// //       setState(() {
// //         progress = false;
// //         getMessageApi();
// //       });
// //     }
// //   }
// //
// //   getMessageApi() async {
// //     prefs = await SharedPreferences.getInstance();
// //     usersCustomersId = prefs!.getString('usersCustomersId');
// //     // empUsersCustomersId = empPrefs!.getString('empUsersCustomersId');
// //     print("usersCustomersId = $usersCustomersId");
// //     print("empUsersCustomersId = ${widget.other_users_customers_id}");
// //
// //     setState(() {
// //       progress = true;
// //     });
// //     String apiUrl = getUserChatApiUrl;
// //     print("working");
// //     final response = await http.post(
// //       Uri.parse(apiUrl),
// //       headers: {"Accept": "application/json"},
// //       body: {
// //         "requestType": "getMessages",
// //         "users_customers_id": usersCustomersId,
// //         "other_users_customers_id": widget.other_users_customers_id,
// //       },
// //     );
// //     final responseString = response.body;
// //     print("getMessgeModelApiUrl: ${response.body}");
// //     print("status Code getMessgeModel: ${response.statusCode}");
// //     print("in 200 getMessgeModel");
// //     if (response.statusCode == 200) {
// //       getMessageModel = getMessgeModelFromJson(responseString);
// //       // setState(() {});
// //       print('getMessgemodel status: ${getMessageModel.status}');
// //       print('getMessgemodel message: ${getMessageModel.data?[0].message}');
// //     }
// //     setState(() {
// //       progress = false;
// //     });
// //   }
// //
// //   updateChatApiWidget() async {
// //     setState(() {
// //       progress = true;
// //     });
// //
// //     prefs = await SharedPreferences.getInstance();
// //     usersCustomersId = prefs!.getString('usersCustomersId');
// //     // empUsersCustomersId = empPrefs!.getString('empUsersCustomersId');
// //     print("usersCustomersId = $usersCustomersId");
// //     print("empUsersCustomersId = ${widget.other_users_customers_id}");
// //
// //     Map body = {
// //       "requestType": "updateMessages",
// //       "users_customers_id": usersCustomersId,
// //       "other_users_customers_id": widget.other_users_customers_id,
// //     };
// //     http.Response response = await http.post(Uri.parse(updateMessageApiUrl),
// //         body: body, headers: {"Accept": "application/json"});
// //     Map jsonData = jsonDecode(response.body);
// //     print("updateMessageApiUrl: $updateMessageApiUrl");
// //     print('updateMessageApiResponse $jsonData');
// //
// //     if (jsonData['message'] == 'no chat found') {
// //       print('no chat found');
// //       // setState(() {
// //       //   loading = false;
// //       // });
// //     } else if (response.statusCode == 200) {
// //       for (int i = 0; i < jsonData['data'].length; i++) {
// //         Map<String, dynamic> obj = jsonData['data'][i];
// //         print(obj['id']);
// //         var pos = UpdateMessgeModel();
// //         pos = UpdateMessgeModel.fromJson(obj);
// //         updateMessageModelObject.add(pos);
// //         print("updateMessagesLength: ${updateMessageModelObject.length}");
// //         setState(() {
// //           getMessageApi();
// //         });
// //       }
// //     }
// //   }
// //
// //   sharedPrefs() async {
// //     setState(() {
// //       getMessageApi();
// //     });
// //   }
// //
// //   bool progress = false;
// //   var sendMessageController = TextEditingController();
// //   final GlobalKey<FormState> sendMessageFormKey = GlobalKey<FormState>();
// //
// //   Widget sendMessageTextFields() {
// //     return Form(
// //       key: sendMessageFormKey,
// //       child: Expanded(
// //         child: Container(
// //           padding: EdgeInsets.symmetric(horizontal: 05, vertical: 0),
// //           decoration: BoxDecoration(
// //               color: Color(0xffF9F9F9),
// //               borderRadius: BorderRadius.circular(20)),
// //           child: Row(
// //             children: [
// //               GestureDetector(
// //                 onTap: () {
// // //                   Get.bottomSheet(
// // //                     Container(
// // //                       height: 100,
// // //                       child: Wrap(
// // //                         children: [
// // //                           ListTile(
// // //                             title: Text("Pick from Gallery"),
// // //                             leading: Icon(Icons.photo),
// // //                             onTap: () {
// // //                              pickImageGallery();
// // //                              Get.back();
// // //                             },
// // //                           ),
// // //                           // ListTile(
// // //                           //   title: Text("Pick from "),
// // //                           //   leading: Icon(Icons.dark_mode_rounded),
// // //                           //   onTap: () {
// // //                           //     Get.changeTheme(ThemeData.dark());
// // //                           //   },
// // //                           // ),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                     // barrierColor: Colors.greenAccent,
// // //                     backgroundColor: Colors.grey.shade200,
// // // // isDismissible: false,
// // //                     shape: RoundedRectangleBorder(
// // //                       borderRadius: BorderRadius.circular(20),
// // //                       side: BorderSide(
// // //                         color: Colors.white,
// // //                         style: BorderStyle.solid,
// // //                         width: 2,
// // //                       ),
// // //                     ),
// // //                     enableDrag: false,
// // //                   );
// // //                   pickImageGallery();
// //                 },
// //                 child: Padding(
// //                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
// //                   child: SvgPicture.asset(
// //                     "assets/images/paperclip.svg",
// //                     width: 25,
// //                   ),
// //                 ),
// //               ),
// //               Expanded(
// //                 child: Container(
// //                   // padding: EdgeInsets.symmetric(horizontal: 05, vertical: 0),
// //                   // decoration: BoxDecoration(
// //                   //     color: Color(0xffF9F9F9),
// //                   //     borderRadius: BorderRadius.circular(20)),
// //                   child: TextField(
// //                     cursorColor: Colors.blue,
// //                     textAlign: TextAlign.left,
// //                     controller: sendMessageController,
// //                     decoration: InputDecoration(
// //                         contentPadding: EdgeInsets.only(left: 10, bottom: 3),
// //                         hintText: "Type your message",
// //                         hintStyle: TextStyle(
// //                             fontSize: 14,
// //                             fontFamily: "Outfit",
// //                             color: Color(0xffD4DCE1)),
// //                         fillColor: Colors.white,
// //                         border: InputBorder.none),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
