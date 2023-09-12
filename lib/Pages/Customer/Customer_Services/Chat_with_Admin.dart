import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Models/getMessageLiveModel.dart';
import '../../../Utils/api_urls.dart';
import '../../../widgets/ToastMessage.dart';
import '../../Bottombar.dart';
import '../HomePage/HomePage.dart';
import 'package:http/http.dart' as http;

class ChatWithAdmin extends StatefulWidget {
  const ChatWithAdmin({Key? key}) : super(key: key);

  @override
  State<ChatWithAdmin> createState() => _ChatWithAdminState();
}

class _ChatWithAdminState extends State<ChatWithAdmin> {

  bool loading = false;
  var sendMessageController = TextEditingController();
  GetMessageLiveModel getMessageLiveModel = GetMessageLiveModel();
  final GlobalKey<FormState> sendMessageFormKey = GlobalKey<FormState>();
  ScrollController _scrollController = ScrollController();

  sendMessageApiWidget() async {
    setState(() {
      loading = true;
    });

    prefs = await SharedPreferences.getInstance();
    adminID = prefs!.getString('adminID');
    usersCustomersId = prefs!.getString('usersCustomersId');
    print("usersCustomersId = $usersCustomersId");
    print("getAdmin = $adminID");

    Map body = {
      "requestType": "sendMessage",
      "sender_type": "Users",
      "messageType":   "1",
      "users_customers_id": usersCustomersId,
      "other_users_customers_id": adminID,
      "content": sendMessageController.text,
    };
    http.Response response = await http.post(
        Uri.parse(sendMessageLiveApiUrl),
        body: body,
        headers: {"Accept": "application/json"});
    Map jsonData = jsonDecode(response.body);
    print("sendMessageApiUrl: $sendMessageLiveApiUrl");
    print("sendMessageText: ${sendMessageController.text}");
    print('sendMessageApiResponse $jsonData');
    if (jsonData['message'] == 'Message sent successfully.') {
      // toastSuccessMessage("Message sent.", Colors.green);
      print('Message sent successfully.');
      setState(() {
        loading = false;
        getMessageApi();
      });
    }
  }

  // Declare a timer variable
  Timer? timer;

  void startTimer() {
    // Start the timer and call getMessageApi() every 1 second
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) {
      getMessageApi();
    });
  }

  void cancelTimer() {
    // Cancel the timer if it's active
    timer?.cancel();
  }

// Call this function when the user enters the page
  void onPageEnter() {
    // Start the timer to call getMessageApi() every 1 second
    startTimer();
  }

// Call this function when the user leaves the page
  void onPageExit() {
    // Cancel the timer to stop calling getMessageApi()
    cancelTimer();
  }

  getMessageApi() async {

    // setState(() {
    //   loading = true;
    // });
    prefs = await SharedPreferences.getInstance();
    adminID = prefs!.getString('adminID');
    usersCustomersId = prefs!.getString('usersCustomersId');
    print("usersCustomersId = $usersCustomersId");
    print("getAdmin = $adminID");

    String apiUrl = getMessageLiveApiUrl;
    print("working");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "requestType": "getMessages",
        "users_customers_id": usersCustomersId,
        "other_users_customers_id": adminID,
      },
    );
    final responseString = response.body;
    print("getMessgeLiveModelApiUrl: ${response.body}");
    print("status Code getMessgeModelLive: ${response.statusCode}");
    print("in 200 getMessgeModelLive");
    if (response.statusCode == 200) {
      getMessageLiveModel = getMessageLiveModelFromJson(responseString);
      print('getMessgemodel status: ${getMessageLiveModel.status}');
      print('getMessgemodel message: ${getMessageLiveModel.data?[0].message}');
      setState(() {
        loading = false;
      });
    }
  }

  sharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    adminID = prefs!.getString('adminID');
    adminName = prefs!.getString('adminName');
    adminImage = prefs!.getString('adminImage');
    print("User Image: $adminImage");
    print("Admin ID: $adminID");
    print("First Name: $adminName");
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
    onPageExit();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    onPageEnter();
    _scrollController = ScrollController();
    sharedPrefs();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            onPageExit();
            Get.to( () => bottom_bar(
              currentIndex: 0,
            ));
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
              "${adminName}",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Outfit",
                fontWeight: FontWeight.w500,
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

                  backgroundImage: NetworkImage("${adminImage}"),
                ),
                // Image.network(widget.img.toString(),),
                // Positioned(
                //   top: 5,
                //   right: 3,
                //   child: Container(
                //     height: 10,
                //     width: 10,
                //     decoration: BoxDecoration(
                //       color: Colors.green,
                //       shape: BoxShape.circle,
                //       border: Border.all(
                //           color: Theme.of(context).scaffoldBackgroundColor,
                //           width: 1.5),
                //     ),
                //   ),
                // ),
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
            // loading
            //     ? Container(
            //     height: Get.height * 0.78,
            //     child: Center(
            //       child: Lottie.asset(
            //         "assets/images/loading.json",
            //         height: 50,
            //       ),
            //     ))
            //     : ModalProgressHUD(
            //   inAsyncCall: loading,
            //   opacity: 0.02,
            //   blur: 0.5,
            //   color: Colors.transparent,
            //   progressIndicator:
            //   CircularProgressIndicator(color: Colors.blue),
            //   child:
              SingleChildScrollView(
                child: Column(
                  children: [
                    getMessageLiveModel.data != null
                        ? Container(
                      height:
                      MediaQuery.of(context).size.height * 0.78,
                      color: Colors.transparent,
                      child: Stack(
                        children: [
                          ListView.builder(
                            itemCount: getMessageLiveModel.data?.length,
                            controller: _scrollController,
                            reverse: true,
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10),
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              // final message = getMessageModel.data?[index];
                              int reverseIndex = getMessageLiveModel.data!.length - 1 - index;
                              return getMessageLiveModel.data!.isEmpty
                                  ? Center(child: Text("no chat history"),)
                                  : Container(
                                padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10,),
                                child: Align(
                                  alignment: (
                                      getMessageLiveModel.data?[
                                      reverseIndex].senderType == "Users"
                                          ? Alignment.topRight
                                          : Alignment.topLeft
                                  ),
                                  child:getMessageLiveModel.data?[reverseIndex].senderType == "Users"
                                      ? Container(
                                    child:  getMessageLiveModel.data?[reverseIndex].senderType == "Users" &&
                                        getMessageLiveModel.data?[reverseIndex].msgType == "text"
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
                                                "${getMessageLiveModel.data?[reverseIndex].message}",
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(fontSize: 14, color: Color(0xffffffff), fontFamily: "Outfit")),
                                          ),

                                          SizedBox(
                                              height: 03),
                                          Text(
                                            // "time",
                                            "${getMessageLiveModel.data?[reverseIndex].time} ${getMessageLiveModel.data?[reverseIndex].date}",
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
                                              image: NetworkImage("$baseUrlImage${getMessageLiveModel.data?[reverseIndex].message}"),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(top: 3.0),
                                            child: Text(
                                              // "time",
                                                "${getMessageLiveModel.data?[reverseIndex].time} ${getMessageLiveModel.data?[reverseIndex].date}",
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
                                    child: getMessageLiveModel.data?[reverseIndex].senderType != "Users" &&
                                        getMessageLiveModel.data?[reverseIndex].msgType == "text"
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
                                                "${getMessageLiveModel.data?[reverseIndex].message}",
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(fontSize: 14, color: Color(0xff000000), fontFamily: "Outfit")),
                                          ),

                                          SizedBox(
                                              height: 03),
                                          Text(
                                            // "time",
                                            "${getMessageLiveModel.data?[reverseIndex].time} ${getMessageLiveModel.data?[reverseIndex].date}",
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
                                              image: NetworkImage("$baseUrlImage${getMessageLiveModel.data?[reverseIndex].message}"),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(top: 3.0),
                                            child: Text(
                                              // "time",
                                                "${getMessageLiveModel.data?[reverseIndex].time} ${getMessageLiveModel.data?[reverseIndex].date}",
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
                  ],
                ),
              ),
            // ),
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
                        final currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus &&
                            currentFocus.focusedChild != null) {
                          FocusManager.instance.primaryFocus
                              ?.unfocus();
                        }
                        if (sendMessageFormKey.currentState!.validate()) {
                          if (sendMessageController.text.isEmpty)  {
                            toastFailedMessage(
                                'please type a message', Colors.red);
                          } else {
                            setState(() {
                              loading = true;
                            });
                            await sendMessageApiWidget();
                            Future.delayed(Duration(seconds: 3), () {
                              print("sendMessage Success");
                              setState(() {
                                loading = false;
                                sendMessageController.clear();
                              });
                              print("false: $loading");
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
//                   setState(() {
//                     pickImageGallery();
//                   });
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
}
