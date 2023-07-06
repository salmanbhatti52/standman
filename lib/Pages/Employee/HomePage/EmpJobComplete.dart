import 'package:StandMan/Pages/Employee/JobsPage/Emp_QR_Scanner/EMp_QRScanned.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Models/jobs_action_employees_Model.dart';
import '../../../Models/users_profilet_model.dart';
import '../../../Utils/api_urls.dart';
import '../../../widgets/MyButton.dart';
import '../../../widgets/ToastMessage.dart';
import '../../../widgets/TopBar.dart';
import '../../Customer/HomePage/HomePage.dart';
import '../../EmpBottombar.dart';
import 'EmpHomePage.dart';
import 'package:http/http.dart' as http;

class EmpJobComplete extends StatefulWidget {
  String? image;
  String? jobName;
  String? totalPrice;
  String? address;
  String? completeJobTime;
  String? description;
  String? profilePic;
  String? name;
  String? myJobId;
  final String? customerId;

  EmpJobComplete(
      {Key? key,
      this.image,
      this.myJobId,
      this.customerId,
      this.jobName,
      this.totalPrice,
      this.address,
      this.completeJobTime,
      this.description,
      this.profilePic,
      this.name})
      : super(key: key);

  @override
  State<EmpJobComplete> createState() => _EmpJobCompleteState();
}

class _EmpJobCompleteState extends State<EmpJobComplete> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("customerid : ${widget.customerId}");
    print("jobname : ${widget.jobName}");
    print("jobid : ${widget.myJobId}");
    // getUserProfileWidget();

  }

  // UsersProfileModel usersProfileModel = UsersProfileModel();
  // bool isInAsyncCall = false;

  // getUserProfileWidget() async {
  //   progress = true;
  //   setState(() {});
  //   empPrefs = await SharedPreferences.getInstance();
  //   empUsersCustomersId = empPrefs!.getString('empUsersCustomersId');
  //   print("userId in empPrefs is = $empUsersCustomersId");
  //   // try {
  //   String apiUrl = usersProfileApiUrl;
  //   print("getUserProfileApi: $apiUrl");
  //   final response = await http.post(Uri.parse(apiUrl), body: {
  //     "users_customers_id": empUsersCustomersId,
  //   }, headers: {
  //     'Accept': 'application/json'
  //   });
  //   print('${response.statusCode}');
  //   print(response);
  //   if (response.statusCode == 200) {
  //     final responseString = response.body;
  //     print("getUserProfileResponse: ${responseString.toString()}");
  //     usersProfileModel = usersProfileModelFromJson(responseString);
  //     print("getUserName: ${usersProfileModel.data!.fullName}");
  //     print("getUserEmail: ${usersProfileModel.data!.email}");
  //     print("getUserNumber: ${usersProfileModel.data!.phone}");
  //     print("usersCustomersId: ${usersProfileModel.data!.usersCustomersId}");
  //     // print("getUserProfileImage: $baseUrlImage${usersProfileModel.data!.profilePic}");
  //   }
  //   progress = false;
  //   setState(() {});
  // }

  JobsActionEmployeesModel jobsActionEmployeesModel =
      JobsActionEmployeesModel();

  bool progress = false;
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

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: StandManAppBar1(
        title: "Job Details",
        bgcolor: Color(0xff2B65EC),
        titlecolor: Colors.white,
        iconcolor: Colors.white,
      ),
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
                          height: height * 0.9,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: height * 0.03,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Image.network("${widget.image}"),
                                      // Image.asset("assets/images/areaa.png"),

//                             Positioned(
//                                 bottom: 10,
//                                 left: 10,
//                                 child: Container(
//                                   margin: EdgeInsets.only(top: 40, left: 2),
//                                   width: 73,
//                                   height: 19,
//                                   decoration: BoxDecoration(
//                                     color: Color(0xffE9FFE7),
//                                     borderRadius: BorderRadius.circular(30),
//                                   ),
//                                   child: Center(
//                                     child: Text(
//                                       "Completed",
//                                       style: TextStyle(
//                                         color: Color(0xff10C900),
//                                         fontFamily: "Outfit",
//                                         fontSize: 10,
//                                         fontWeight: FontWeight.w400,
// // letterSpacing: -0.3,
//                                       ),
//                                       textAlign: TextAlign.left,
//                                     ),
//                                   ),
//                                 ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                        // "\$22",
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
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/locationfill.svg',
                                      ),
                                      SizedBox(
                                        width: width * 0.03,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Text(
                                          //   "${widget.address}",
                                          //   // "No 15 uti street off ovie palace road effurun delta state",
                                          //   style: const TextStyle(
                                          //     color: Color.fromRGBO(0, 0, 0, 1),
                                          //     fontFamily: "Outfit",
                                          //     fontWeight: FontWeight.w400,
                                          //     fontSize: 12,
                                          //   ),
                                          // ),
                                          Container(
                                            width: width * 0.7,
                                            child: AutoSizeText(
                                              "${widget.address}",
                                                style: const TextStyle(
                                                  color: Color.fromRGBO(0, 0, 0, 1),
                                                  fontFamily: "Outfit",
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                ),
                                              maxLines: 1,
                                              minFontSize: 12,
                                              maxFontSize: 12,
                                              textAlign: TextAlign.left,
                                              presetFontSizes: [12],

                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Text(
                                            "${widget.completeJobTime}",
                                            // "Complete job time 03 March - 4:40 PM",
                                            style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  167, 169, 183, 1),
                                              fontFamily: "Outfit",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 8,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
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
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Job Posted by",
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
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Image.asset(
                                      //   "assets/images/g2.png",
                                      // ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.network(
                                          "${widget.profilePic}",
                                          width: 50,
                                          height: 50,
                                        ),
                                      ),
                                      // CircleAvatar(
                                      //     // radius: (screenWidth > 600) ? 90 : 70,
                                      //     //   radius: 50,
                                      //     backgroundColor: Colors.transparent,
                                      //     backgroundImage: usersProfileModel
                                      //                 .data!.usersCustomersId
                                      //                 .toString() ==
                                      //             null
                                      //         ? Image.asset(
                                      //                 "assets/images/person2.png")
                                      //             .image
                                      //         : NetworkImage(baseUrlImage +
                                      //             usersProfileModel
                                      //                 .data!.profilePic
                                      //                 .toString())
                                      //     // NetworkImage(baseUrlImage+ getUserProfileModelObject.data!.profilePic!)
                                      //
                                      //     ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "${widget.name}",
                                          // "${usersProfileModel.data!.fullName.toString()}",
                                          // "    Alex Buckmaster",
                                          style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontFamily: "Outfit",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            // letterSpacing: -0.3,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Get.to(EMpQRScanneer(customerId: widget.customerId, jobName: widget.jobName, myJobId: widget.myJobId,));
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
                                  )
                                ],
                              ),
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
