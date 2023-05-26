import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Models/chat_start_user_Model.dart';
import '../../../../Models/jobs_action_employees_Model.dart';
import '../../../../Utils/api_urls.dart';
import '../../../../widgets/MyButton.dart';
import '../../../../widgets/ToastMessage.dart';
import '../../../../widgets/TopBar.dart';
import '../../../Customer/HomePage/HomePage.dart';
import '../../../EmpBottombar.dart';
import '../../HomePage/EmpHomePage.dart';
import '../../MessagePage/MessageDetails.dart';
import '../Emp_Complete_Profilewithdetails/Emp_Profile_details.dart';
import 'package:http/http.dart' as http;

import '../Emp_QR_Scanner/EMp_QRScanned.dart';

class EmpCompleteProfile extends StatefulWidget {
  final String? customerId;
  String? image;
  String? jobName;
  String? totalPrice;
  String? address;
  String? completeJobTime;
  String? description;
  String? profilePic;
  String? status;
  String? name;
  String? myJobId;
   EmpCompleteProfile({Key? key,  this.customerId, this.image,
    this.myJobId,
    this.jobName,
    this.totalPrice,
     this.status,
    this.address,
    this.completeJobTime,
    this.description,
    this.profilePic,
    this.name
  }) : super(key: key);

  @override
  State<EmpCompleteProfile> createState() => _EmpCompleteProfileState();
}

class _EmpCompleteProfileState extends State<EmpCompleteProfile> {



  JobsActionEmployeesModel jobsActionEmployeesModel =
  JobsActionEmployeesModel();

  JobsActionEmployeesCanceled() async {
    setState(() {
      progress = true;
    });

    String apiUrl = jobsActionEmployeesApiUrl;
    print("working");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "users_customers_id": usersCustomersId,
        "jobs_id": widget.myJobId,
        "status": "Cancelled"
      },
    );
    final responseString = response.body;
    print("jobsActionEmployeesApiUrl: ${response.body}");
    print("status Code jobsActionEmployeesModel: ${response.statusCode}");
    print("in 200 jobsActionEmployees");
    if (response.statusCode == 200) {
      jobsActionEmployeesModel =
          jobsActionEmployeesModelFromJson(responseString);
      // setState(() {});
      print('jobsActionEmployees status: ${jobsActionEmployeesModel.status}');
      print('jobsActionEmployees message: ${jobsActionEmployeesModel.message}');
    }
    setState(() {
      progress = false;
    });
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   sharedPrefs();
  // }
  //
  // sharedPrefs() async {
  //   // loading = true;
  //   setState(() {});
  //   // print('in LoginPage shared prefs');
  //   prefs = await SharedPreferences.getInstance();
  //   userEmail = (prefs!.getString('empUser_email'));
  //   phoneNumber = (prefs!.getString('empPhoneNumber'));
  //   fullName = (prefs!.getString('empFullName'));
  //   profilePic1 = (prefs!.getString('empProfilePic'));
  //   password = (prefs!.getString('empPassword'));
  //   empUsersCustomersId = prefs!.getString('empUsersCustomersId');
  //   print("userEmployeeId in Prefs is = $empUsersCustomersId");
  // }

  bool progress = false;
  // bool isInAsyncCall = false;

  ChatStartUserModel chatStartUserModel = ChatStartUserModel();

  chatStartUserEmp() async {

    progress = true;
    setState(() {});

    prefs = await SharedPreferences.getInstance();
    // usersCustomersId = prefs!.getString('usersCustomersId');
    empUsersCustomersId = empPrefs?.getString('empUsersCustomersId');
    print("empUsersCustomersId = $empUsersCustomersId");
    print("usersCustomersId = ${widget.customerId}");

    // try {
    String apiUrl = userChatApiUrl;
    print("userChatApiUrl: $apiUrl");
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        "requestType": "startChat",
        "users_customers_id": empUsersCustomersId,
        "other_users_customers_id": widget.customerId,
      },
      headers: {'Accept': 'application/json'},
    );
    print('${response.statusCode}');
    print(response);
    print("responseStartChat: $response");
    print("status Code chat: ${response.statusCode}");
    print("in 200 chat");
    if (response.statusCode == 200) {
      final responseString = response.body;
      print("userChatResponse: ${responseString.toString()}");
      chatStartUserModel = chatStartUserModelFromJson(responseString);
    }
    // } catch (e) {
    //   print('Error in userChatApiUrl: ${e.toString()}');
    // }
    progress = false;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: StandManAppBar1(title: "Job Details", bgcolor: Color(0xff2B65EC), titlecolor: Colors.white, iconcolor: Colors.white,),
      backgroundColor: Color(0xff2B65EC),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Padding(
              //   padding:  EdgeInsets.symmetric(vertical: height * 0.02),
              //   child: Bar(
              //     "Job Details",
              //     'assets/images/arrow-back.svg',
              //     Colors.white,
              //     Colors.white,
              //         () {
              //       Get.back();
              //     },
              //   ),
              // ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                width: width,
                // height: height,
                height:   height * 0.9,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Stack(
                          children: [
                            Image.network("${widget.image}"),
                            Positioned(
                                bottom: 10,
                                left: 10,
                                child: Container(
                                  margin: EdgeInsets.only(top: 40, left: 2),
                                  width: 73,
                                  height: 19,
                                  decoration: BoxDecoration(
                                    color: Color(0xffE9FFE7),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${widget.status}",
                                      style: TextStyle(
                                        color: Color(0xff10C900),
                                        fontFamily: "Outfit",
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
// letterSpacing: -0.3,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),),
                          ],
                        ),
                        SizedBox(height: height * 0.02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text(
                              "${widget.jobName}",
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontFamily: "Outfit",
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                // letterSpacing: -0.3,
                              ),
                              textAlign: TextAlign.left,
                            ),
                             Text(
                               "\$${widget.totalPrice}",
                              style: TextStyle(
                                color: Color(0xff2B65EC),
                                fontFamily: "Outfit",
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                // letterSpacing: -0.3,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.02,),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/locationfill.svg',
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: width * 0.8,
                                  child: AutoSizeText(
                                    "${widget.address}",
                                    style: const TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontFamily: "Outfit",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                    maxLines: 2,
                                    minFontSize: 12,
                                    presetFontSizes: [12],
                                    maxFontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  "${widget.completeJobTime}",
                                  style: const TextStyle(
                                    color: Color.fromRGBO(167, 169, 183, 1),
                                    fontFamily: "Outfit",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: height * 0.02,),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${widget.description}",
                                // "Donec dictum tristique porta. Etiam convallis lorem lobortis nulla molestie, nec tincidunt ex ullamcorper. Quisque ultrices lobortis elit sed euismod. Duis in ultrices dolor, ac rhoncus odio. Suspendisse tempor sollicitudin dui sed lacinia. Nulla quis enim posuere, congue libero quis, commodo purus. Cras iaculis massa ut elit.",
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: "Outfit",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  // letterSpacing: -0.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.02,),
                        Row(
                          children: [
                            const Text(
                              "Job Taken by",
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontFamily: "Outfit",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                // letterSpacing: -0.3,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap : (){
                                    Get.to(Emp_Profile_details());
              },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        "${widget.profilePic}",
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${widget.name}",
                                        style: TextStyle(
                                          color: Color(0xff000000),
                                          fontFamily: "Outfit",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
// letterSpacing: -0.3,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        "Rating not given yet",
                                        style: const TextStyle(
                                          color: Color.fromRGBO(167, 169, 183, 1),
                                          fontFamily: "Outfit",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.star, color: Color(0xffFFDF00), size: 15,),
                                          Text(
                                            '--',
                                            style: TextStyle(
                                              color: Color(0xff000000),
                                              fontFamily: "Outfit",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
// letterSpacing: -0.3,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: () async {
                                // // Get.to(Emp_complete_profile_details());
                                // userChat();
                                // Get.to(EmpMessagesDetails(
                                //   empUsersCustomersId: empUsersCustomersId,
                                //   other_users_customers_id: "1",
                                // ),
                                // );
                                await chatStartUserEmp();
                                Get.to(EmpMessagesDetails(
                                  usersCustomersId: empUsersCustomersId,
                                  other_users_customers_id: widget.customerId,
                                  img: widget.profilePic,
                                  name: widget.name,
                                  // img: widget.profilePic.toString(),
                                  // name: widget.name.toString(),
                                ),
                                );
                              },
                              child: smallButton("Chat", Color(0xff2B65EC) , context),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.04,),
                        GestureDetector(
                            onTap: () {
                              Get.to(EMpQRScanneer());
                            },
                            child: mainButton("Job Completed",
                                Color(0xff2B65EC), context)),
                        GestureDetector(
                          onTap: () async {
                            // print('jobIndex123 ${getJobsEmployeesModel.data?[index].jobsId}');
                            await JobsActionEmployeesCanceled();

                            if (jobsActionEmployeesModel.status ==
                                "success") {
                              Future.delayed(
                                  const Duration(seconds: 1), () {
                                toastSuccessMessage(
                                    jobsActionEmployeesModel.message, Colors.green);
                                Get.to(
                                  Empbottom_bar(
                                    currentIndex: 0,
                                  ),
                                );
                                print("false: $progress");
                              });
                            }
                            if (jobsActionEmployeesModel.status !=
                                "success") {
                              toastFailedMessage(
                                  jobsActionEmployeesModel.message,
                                  Colors.red);
                              Get.to(
                                Empbottom_bar(
                                  currentIndex: 0,
                                ),
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 20),
                            child: Container(
                              height:
                              MediaQuery.of(context).size.height *
                                  0.07,
                              // height: 48,
                              width:
                              MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                // color: Color(0xff4DA0E6),
                                //   color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(12),
                                  border: Border.all(
                                      color: Color(0xffC70000),
                                      width: 1),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 0,
                                        blurRadius: 15,
                                        offset: Offset(1, 10),
                                        color: Color.fromRGBO(
                                            7, 1, 87, 0.1)),
                                  ]),
                              child: Center(
                                child: Text(
                                  "Cancel Job",
                                  style: TextStyle(
                                      fontFamily: "Outfit",
                                      fontSize: 14,
                                      color: Color(0xffC70000),
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.04,),
                      ],
                    ),
                  ),
                ),),
            ],
          ),
        ),
      ),
    );
  }
}
