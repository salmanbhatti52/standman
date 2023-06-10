import 'dart:convert';
import 'dart:typed_data';
import 'package:StandMan/Models/send_messge_employee_Model.dart';
import 'package:StandMan/Pages/Customer/HomePage/HomePage.dart';
import 'package:StandMan/Pages/EmpBottombar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../Models/get_messge_Model.dart';
import '../../../Models/update_messge_Model.dart';
import '../../../Utils/api_urls.dart';
import '../../../widgets/ToastMessage.dart';

class EmpMessagesDetails extends StatefulWidget {
  final String? usersCustomersId;
  final String? other_users_customers_id;
  final String? name;
  final String? img;

  EmpMessagesDetails(
      {Key? key,
        this.usersCustomersId,
        this.other_users_customers_id,
        this.name,
        this.img})
      : super(key: key);

  @override
  State<EmpMessagesDetails> createState() => _EmpMessagesDetailsState();
}

class _EmpMessagesDetailsState extends State<EmpMessagesDetails> {
  var sendMessageController = TextEditingController();
  final GlobalKey<FormState> sendMessageFormKey = GlobalKey<FormState>();
  List<GetMessgeModel> newMessageObject = [];
  List<UpdateMessgeModel> updateMessageModelObject = [];
  SendMessgeEmployeeModel sendMessgeEmployeeModel = SendMessgeEmployeeModel();
  bool loading = true;
  bool progress = false;
  ScrollController _scrollController = ScrollController();
  String? Image;
  GetMessgeModel getMessgeModel = GetMessgeModel();

  getMessageApi() async {
    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('empUsersCustomersId');
    // empUsersCustomersId = empPrefs!.getString('empUsersCustomersId');
    print("usersCustomersId = $usersCustomersId");
    print("empUsersCustomersId = ${widget.other_users_customers_id}");

    setState(() {
      loading = true;
    });
    String apiUrl = getUserChatApiUrl;
    print("working");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "requestType": "getMessages",
        "users_customers_id": usersCustomersId,
        "other_users_customers_id": widget.other_users_customers_id,
      },
    );
    final responseString = response.body;
    print("getMessgeModelApiUrl: ${response.body}");
    print("status Code getMessgeModel: ${response.statusCode}");
    print("in 200 getMessgeModel");
    if (response.statusCode == 200) {
      getMessgeModel = getMessgeModelFromJson(responseString);
      // setState(() {});
      print('getMessgemodel status: ${getMessgeModel.status}');
      print('getMessgemodel message: ${getMessgeModel.data?[0].message}');
    }
    setState(() {
      loading = false;
    });
  }

  updateChatApiWidget() async {
    setState(() {
      loading = true;
    });

    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('empUsersCustomersId');
    // empUsersCustomersId = empPrefs!.getString('empUsersCustomersId');
    print("usersCustomersId = $usersCustomersId");
    print("empUsersCustomersId = ${widget.other_users_customers_id}");

    Map body = {
      "requestType": "updateMessages",
      "users_customers_id": usersCustomersId,
      "other_users_customers_id": widget.other_users_customers_id,
    };
    http.Response response = await http.post(Uri.parse(updateMessageApiUrl),
        body: body, headers: {"Accept": "application/json"});
    Map jsonData = jsonDecode(response.body);
    print("updateMessageApiUrl: $updateMessageApiUrl");
    print('updateMessageApiResponse $jsonData');

    if (jsonData['message'] == 'no chat found') {
      print('no chat found');
      // setState(() {
      //   loading = false;
      // });
    } else if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['data'].length; i++) {
        Map<String, dynamic> obj = jsonData['data'][i];
        print(obj['id']);
        var pos = UpdateMessgeModel();
        pos = UpdateMessgeModel.fromJson(obj);
        updateMessageModelObject.add(pos);
        print("updateMessagesLength: ${updateMessageModelObject.length}");
        setState(() {
          getMessageApi();
        });
      }
    }
  }

  sendMessageApiWidget() async {
    setState(() {
      loading = true;
    });

    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('empUsersCustomersId');
    // empUsersCustomersId = empPrefs!.getString('empUsersCustomersId');
    print("usersCustomersId = $usersCustomersId");
    print("empUsersCustomersId = ${widget.other_users_customers_id}");

    Map body = {
      "requestType": "sendMessage",
      "sender_type": "Employee",
      "messageType": "text",
      "users_customers_id": usersCustomersId,
      "other_users_customers_id": widget.other_users_customers_id,
      "content": sendMessageController.text,
      "image": "",
    };
    http.Response response = await http.post(
        Uri.parse(sendMessageCustomerApiUrl),
        body: body,
        headers: {"Accept": "application/json"});
    Map jsonData = jsonDecode(response.body);
    print("sendMessageApiUrl: $sendMessageCustomerApiUrl");
    print("sendMessageText: ${sendMessageController.text}");
    print('sendMessageApiResponse $jsonData');
    if (jsonData['message'] == 'Message sent successfully.') {
      // toastSuccessMessage("Message sent successfully1.", Colors.green);
      print('Message sent successfully.');
      setState(() {
        loading = false;
        getMessageApi();
      });
    }
  }

  sharedPrefs() async {
    setState(() {
      getMessageApi();
    });
  }

  void scrollToBottom() {
    final bottomOffset = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(
      bottomOffset,
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    usersCustomersId = widget.usersCustomersId;
    Image = widget.img;
    print("usersCustomersId $usersCustomersId");
    _scrollController = ScrollController();
    sharedPrefs();
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // var cron = Cron();
    // cron.schedule(Schedule.parse('*/03 * * * * *'), () async {
    //   print('auto refresh after 03 seconds allChatMessageApi');
    //   await getMessageApi();
    // });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.to(Empbottom_bar(currentIndex: 1));
          },
          child: Center(
              child: SvgPicture.asset(
                "assets/images/left.svg",
              )),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 05),
          child: ListTile(
            title: Text(
              // fullName!,
              // g.data![index].usersData!.fullName.toString(),
              "${widget.name.toString()}",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Outfit",
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            subtitle: Text(
              "Online",
              // getUserChatModel.data
              style: TextStyle(
                color: Color(0xffA7AEC1),
                fontFamily: "Outfit",
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
            ),
            leading: Stack(
              children: [
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(120),
                //   child: FadeInImage(
                //     placeholder: AssetImage("assets/images/fade_in_image.jpeg"),
                //     image: NetworkImage("${widget.img}"),
                //   ),
                // ),
                CircleAvatar(
                  // radius: (screenWidth > 600) ? 90 : 70,
                  radius: 30,

                  backgroundImage: NetworkImage("${widget.img}"),
                ),
                // Image.network(widget.img.toString(),),
                Positioned(
                  top: 5,
                  right: 3,
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // actions: [
        //   Padding(
        //   padding:  EdgeInsets.only(left:  width * 0.08),
        //   child: Row(
        //     children: [
        //       GestureDetector(
        //           onTap: (){
        //             Get.back();
        //           },
        //           child: SvgPicture.asset("assets/images/left.svg",)),
        //       Padding(
        //         padding: const EdgeInsets.only(left: 20.0, right: 10),
        //         child:
        //       ),
        //       Column(
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //

        //         ],
        //       ),
        //     ],
        //   ),
        // ),
        // ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: [
            //  SizedBox(
            //    height: height * 0.04,
            //  ),
            // Padding(
            //   padding:  EdgeInsets.only(left:  width * 0.08),
            //   child: Row(
            //     children: [
            //       GestureDetector(
            //         onTap: (){
            //           Get.back();
            // },
            //           child: SvgPicture.asset("assets/images/left.svg",)),
            //       Padding(
            //         padding: const EdgeInsets.only(left: 20.0, right: 10),
            //         child: Stack(
            //           children: [
            //             Image.asset("assets/images/person.png"),
            //             Positioned(
            //                 top: 5,
            //                 right: 6,
            //                 child: Container(
            //                   height: 10,
            //                   width: 10,
            //                   decoration:
            //                   BoxDecoration(
            //                     color: Colors.green,
            //                     shape:
            //                     BoxShape.circle,
            //                     border: Border.all(
            //                         color: Theme.of(
            //                             context)
            //                             .scaffoldBackgroundColor,
            //                         width: 1.5),
            //                   ),
            //                 ),)
            //           ],
            //         ),
            //       ),
            //       Column(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             "Maddy Lin",
            //             style: TextStyle(
            //               color: Colors.black,
            //               fontFamily: "Outfit",
            //               fontWeight: FontWeight.w500,
            //               fontSize: 14,
            //             ),
            //           ),
            //           Text(
            //             "Online",
            //             style: TextStyle(
            //               color: Color(0xffA7AEC1),
            //               fontFamily: "Outfit",
            //               fontWeight: FontWeight.w300,
            //               fontSize: 14,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            //  SizedBox(
            //    height: height * 0.04,
            //  ),
            loading
                ? Container(
                height: height * 0.78,
                child: Center(
                    child: CircularProgressIndicator(
                        color: Colors.blueAccent)))
                : ModalProgressHUD(
              inAsyncCall: progress,
              opacity: 0.02,
              blur: 0.5,
              color: Colors.transparent,
              progressIndicator:
              CircularProgressIndicator(color: Colors.blue),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    getMessgeModel.data != null
                        ? Container(
                      height:
                      MediaQuery.of(context).size.height * 0.78,
                      color: Colors.transparent,
                      child: Stack(
                        children: [
                          ListView.builder(
                            itemCount: getMessgeModel.data?.length,
                            controller: _scrollController,
                            reverse: true,
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10),
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              // final message = getMessageModel.data?[index];
                              int reverseIndex = getMessgeModel.data!.length - 1 - index;
                              return getMessgeModel.data!.isEmpty
                                  ? Center(child: Text("no chat history"),)
                                  : Container(
                                padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10,),
                                child: Align(
                                  alignment: (
                                      getMessgeModel.data?[
                                      reverseIndex].senderType == "Employee"
                                          ? Alignment.topRight
                                          : Alignment.topLeft
                                  ),
                                  child:getMessgeModel.data?[reverseIndex].senderType == "Employee"
                                      ? Container(
                                    child:  getMessgeModel.data?[reverseIndex].senderType == "Employee" &&
                                        getMessgeModel.data?[reverseIndex].msgType == "text"
                                        ? Container(
                                      // height: 54,

                                      child:
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                topLeft: Radius.circular(20),
                                                bottomLeft: Radius.circular(20),
                                              ),
                                              color:  Color(0xff2B65EC),
                                            ),
                                            child: Text(
                                                "${getMessgeModel.data?[reverseIndex].message}",
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(fontSize: 14, color: Color(0xffffffff), fontFamily: "Outfit")),
                                          ),

                                          SizedBox(
                                              height: 03),
                                          Text(
                                            // "time",
                                            "${getMessgeModel.data?[reverseIndex].time} ${getMessgeModel.data?[reverseIndex].date}",
                                            overflow:
                                            TextOverflow.ellipsis,
                                            textAlign:
                                            TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Color(0xffA7A9B7),
                                                fontFamily: "Outfit"),
                                          ),
                                        ],
                                      ),
                                    )
                                        : Container(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                            BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              topLeft: Radius.circular(20),
                                              bottomLeft: Radius.circular(20),
                                            ),
                                            child:
                                            // Image.asset("assets/images/jobarea.png", width: 96, height: 96,),
                                            FadeInImage(
                                              placeholder: AssetImage(
                                                "assets/images/fade_in_image.jpeg",
                                              ),
                                              fit: BoxFit.fill,
                                              width: 115,
                                              height: 110,
                                              image: NetworkImage("$baseUrlImage${getMessgeModel.data?[reverseIndex].message}"),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(top: 3.0),
                                            child: Text(
                                              // "time",
                                                "${getMessgeModel.data?[reverseIndex].time} ${getMessgeModel.data?[reverseIndex].date}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(fontSize: 10, color: Color(0xffA7A9B7), fontFamily: "Outfit")),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                      : Container(
                                    child: getMessgeModel.data?[reverseIndex].senderType != "Employee" &&
                                        getMessgeModel.data?[reverseIndex].msgType == "text"
                                        ? Container(
                                      // height: 54,

                                      child:
                                      Column(
                                        // mainAxisAlignment:
                                        // MainAxisAlignment.end,
                                        // crossAxisAlignment:
                                        // CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                topLeft: Radius.circular(20),
                                                bottomRight: Radius.circular(20),
                                              ),
                                              color:  Color(0xffEBEBEB),
                                            ),
                                            child: Text(
                                                "${getMessgeModel.data?[reverseIndex].message}",
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(fontSize: 14, color: Color(0xff000000), fontFamily: "Outfit")),
                                          ),

                                          SizedBox(
                                              height: 03),
                                          Text(
                                            // "time",
                                            "${getMessgeModel.data?[reverseIndex].time} ${getMessgeModel.data?[reverseIndex].date}",
                                            overflow:
                                            TextOverflow.ellipsis,
                                            textAlign:
                                            TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Color(0xffA7A9B7),
                                                fontFamily: "Outfit"),
                                          ),
                                        ],
                                      ),
                                    )
                                        : Container(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                            BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              topLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            ),
                                            child:
                                            // Image.asset("assets/images/jobarea.png", width: 96, height: 96,),
                                            FadeInImage(
                                              placeholder: AssetImage(
                                                "assets/images/fade_in_image.jpeg",
                                              ),
                                              fit: BoxFit.fill,
                                              width: 115,
                                              height: 110,
                                              image: NetworkImage("$baseUrlImage${getMessgeModel.data?[reverseIndex].message}"),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(top: 3.0),
                                            child: Text(
                                              // "time",
                                                "${getMessgeModel.data?[reverseIndex].time} ${getMessgeModel.data?[reverseIndex].date}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(fontSize: 10, color: Color(0xffA7A9B7), fontFamily: "Outfit")),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                        : Container(
                      height: Get.height * 0.78,
                    ),
                    // Chat(
                    //   theme: DefaultChatTheme(
                    //     inputTextCursorColor: Color(0xff8C8C8C),
                    //     inputTextColor: Color(0xff8C8C8C),
                    //     inputTextStyle: TextStyle(
                    //       color: Color(0xff8C8C8C),
                    //       fontFamily: "Outfit",
                    //       fontWeight: FontWeight.w300,
                    //       fontSize: 14,
                    //     ),
                    //     // primaryColor: Color(Helpers.secondry),
                    //     // secondaryColor: Colors.white,
                    //     // backgroundColor:Colors.white,
                    //
                    //     inputBorderRadius: BorderRadius.circular(10),
                    //     inputBackgroundColor: Color(0xffF9F9F9),
                    //     inputContainerDecoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(40),
                    //         boxShadow: [
                    //           // BoxShadow(
                    //           //   // color: Color(0xff4DA0E6),
                    //           //   blurRadius: 8,
                    //           //     offset:  Offset(0, -3),
                    //           // ),
                    //         ]),
                    //   ),
                    //   disableImageGallery: true,
                    //   messages: _messages,
                    //   onAttachmentPressed: _handleAttachmentPressed,
                    //   onMessageTap: _handleMessageTap,
                    //   onPreviewDataFetched: _handlePreviewDataFetched,
                    //   onSendPressed: _handleSendPressed,
                    //   showUserAvatars: true,
                    //   showUserNames: true,
                    //   user: _user,
                    // ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10, top: 30),
                child: Row(
                  children: <Widget>[
                    sendMessageTextFields(),
                    SizedBox(width: 05),
                    FloatingActionButton(
                      onPressed: () async {
                        if (sendMessageFormKey.currentState!.validate()) {
                          if (sendMessageController.text.isEmpty) {
                            toastFailedMessage(
                                'please type a message', Colors.red);
                          } else {
                            setState(() {
                              progress = true;
                            });
                            await sendMessageApiWidget();
                            Future.delayed(Duration(seconds: 3), () {
                              print("sendMessage Success");
                              setState(() {
                                progress = false;
                                sendMessageController.clear();
                              });
                              print("false: $progress");
                            });
                          }
                        }
                      },
                      backgroundColor: Colors.white,
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: SvgPicture.asset("assets/images/send.svg"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget sendMessageTextFields() {
    return Form(
      key: sendMessageFormKey,
      child: Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 05, vertical: 0),
          decoration: BoxDecoration(
              color: Color(0xffF9F9F9),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
//                   Get.bottomSheet(
//                     Container(
//                       height: 100,
//                       child: Wrap(
//                         children: [
//                           ListTile(
//                             title: Text("Pick from Gallery"),
//                             leading: Icon(Icons.photo),
//                             onTap: () {
//                              pickImageGallery();
//                              Get.back();
//                             },
//                           ),
//                           // ListTile(
//                           //   title: Text("Pick from "),
//                           //   leading: Icon(Icons.dark_mode_rounded),
//                           //   onTap: () {
//                           //     Get.changeTheme(ThemeData.dark());
//                           //   },
//                           // ),
//                         ],
//                       ),
//                     ),
//                     // barrierColor: Colors.greenAccent,
//                     backgroundColor: Colors.grey.shade200,
// // isDismissible: false,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       side: BorderSide(
//                         color: Colors.white,
//                         style: BorderStyle.solid,
//                         width: 2,
//                       ),
//                     ),
//                     enableDrag: false,
//                   );
//                 if(base64img == null )
//                 sendImageApiWidget();
//                   setState(() {
                  pickImageGallery();
//                   });
                  Future.delayed(const Duration(seconds: 5), () {
                    if (base64img != null) {
                      sendImageApiWidget();
                    } else {
                      toastFailedMessage("failed", Colors.red);
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SvgPicture.asset(
                    "assets/images/paperclip.svg",
                    width: 25,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  // padding: EdgeInsets.symmetric(horizontal: 05, vertical: 0),
                  // decoration: BoxDecoration(
                  //     color: Color(0xffF9F9F9),
                  //     borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                    cursorColor: Colors.blue,
                    textAlign: TextAlign.left,
                    controller: sendMessageController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10, bottom: 3),
                        hintText: "Type your message",
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: "Outfit",
                            color: Color(0xffD4DCE1)),
                        fillColor: Colors.white,
                        border: InputBorder.none),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  File? imagePath;
  String? base64img;

  sendImageApiWidget() async {
    setState(() {
      loading = true;
    });

    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('empUsersCustomersId');
    // empUsersCustomersId = empPrefs!.getString('empUsersCustomersId');
    print("usersCustomersId = $usersCustomersId");
    print("empUsersCustomersId = ${widget.other_users_customers_id}");

    Map body = {
      "requestType": "sendMessage",
      "sender_type": "Employee",
      "messageType": "attachment",
      "users_customers_id": usersCustomersId,
      "other_users_customers_id": widget.other_users_customers_id,
      "content": "",
      "image": base64img,
    };
    http.Response response = await http.post(
        Uri.parse(sendMessageCustomerApiUrl),
        body: body,
        headers: {"Accept": "application/json"});
    Map jsonData = jsonDecode(response.body);
    print("sendImageApiUrl: $sendMessageCustomerApiUrl");
    print("sendMessageText: ${sendMessageController.text}");
    print('sendImage $jsonData');
    if (jsonData['message'] == 'Message sent successfully.') {
      // toastSuccessMessage("Message sent.", Colors.green);
      print('Message sent successfully.');
      setState(() {
        loading = false;
        getMessageApi();
      });
    }
  }

  Future pickImageGallery() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? xFile = await _picker.pickImage(source: ImageSource.gallery);
      if (xFile == null) return;

      Uint8List imageByte = await xFile.readAsBytes();
      base64img = base64.encode(imageByte);
      print("base64img $base64img");

      final imageTemporary = File(xFile.path);

      setState(() {
        imagePath = imageTemporary;
        print("newImage $imagePath");
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: ${e.toString()}');
    }
  }
}
