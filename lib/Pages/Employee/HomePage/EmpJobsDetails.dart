import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Models/get_jobs_employees_Model.dart';
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

import 'EmpJobComplete.dart';

class EmpJobDetaisl extends StatefulWidget {
  String? image;
  String? jobName;
  String? totalPrice;
  String? address;
  String? completeJobTime;
  String? description;
  String? profilePic;
  String? name, myJobId;
  EmpJobDetaisl({Key? key, this.image,  this.myJobId, this.jobName, this.totalPrice, this.address, this.completeJobTime, this.description, this.profilePic, this.name}) : super(key: key);

  @override
  State<EmpJobDetaisl> createState() => _EmpJobDetaislState();
}

class _EmpJobDetaislState extends State<EmpJobDetaisl> {



  // UsersProfileModel usersProfileModel = UsersProfileModel();

  bool progress = false;
  bool isInAsyncCall = false;

  JobsActionEmployeesModel jobsActionEmployeesModel = JobsActionEmployeesModel();

  bool loading = false;

  JobsActionEmployeesAccept() async {

    setState(() {
      loading = true;
    });

    String apiUrl = jobsActionEmployeesApiUrl;
    print("working");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "users_customers_id": usersCustomersId,
        "jobs_id":  widget.myJobId,
        "status": "Accepted"
      },
    );
    final responseString = response.body;
    print("jobsActionEmployeesApiUrl: ${response.body}");
    print("status Code jobsActionEmployeesModel: ${response.statusCode}");
    print("in 200 jobsActionEmployees");
    if (response.statusCode == 200) {
      jobsActionEmployeesModel = jobsActionEmployeesModelFromJson(responseString);
      // setState(() {});
      // print('jobsActionEmployees status: ${jobsActionEmployeesModel.status}');
      print('jobsActionEmployees message: ${jobsActionEmployeesModel.message}');
    }
    setState(() {
      loading = false;
    });
  }

  JobsActionEmployeesReject() async {
    setState(() {
      isInAsyncCall = true;
    });

    String apiUrl = jobsActionEmployeesApiUrl;
    print("working");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "users_customers_id": usersCustomersId,
        "jobs_id": widget.myJobId,
        "status": "Rejected"
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
      isInAsyncCall = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getUserProfileWidget();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: StandManAppBar1(title: "Job Details", bgcolor: Color(0xff2B65EC), titlecolor: Colors.white, iconcolor: Colors.white,),
      backgroundColor: Color(0xff2B65EC),
      body:  SingleChildScrollView(
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
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: height * 0.03,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.network("${widget.image}" )),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Text(
                            //   "${widget.jobName}",
                            //   style: TextStyle(
                            //     color: Color.fromRGBO(0, 0, 0, 1),
                            //     fontFamily: "Outfit",
                            //     fontSize: 20,
                            //     fontWeight: FontWeight.w500,
                            //     // letterSpacing: -0.3,
                            //   ),
                            //   textAlign: TextAlign.left,
                            // ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width * 0.72),
                              child: AutoSizeText(
                                "${widget.jobName}",
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontFamily: "Outfit",
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    // letterSpacing: -0.3,
                                  ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                minFontSize: 15,
                              ),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.address}",
                                  // "No 15 uti street off ovie palace road effurun delta state",
                                  style: const TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontFamily: "Outfit",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${widget.completeJobTime}",
                                  // "Complete job time 03 March - 4:40 PM",
                                  style: const TextStyle(
                                    color: Color.fromRGBO(167, 169, 183, 1),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              child: ClipRRect(borderRadius: BorderRadius.circular(25),child: Image.network("${widget.profilePic}", fit: BoxFit.fill,)),
                            ),
                            // CircleAvatar(
                            //   // radius: (screenWidth > 600) ? 90 : 70,
                            //   //   radius: 50,
                            //     backgroundColor: Colors.transparent,
                            //     backgroundImage: usersProfileModel.data!.usersCustomersId.toString() == null
                            //         ? Image.asset("assets/images/person2.png").image
                            //         : NetworkImage(baseUrlImage+usersProfileModel.data!.profilePic.toString())
                            //   // NetworkImage(baseUrlImage+ getUserProfileModelObject.data!.profilePic!)
                            //
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                // "${widget.name}",
                                "${widget.name}",
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
                          onTap: () async {

                            await JobsActionEmployeesAccept();

                            setState(() {
                              loading = true;
                            });

                            if (jobsActionEmployeesModel.message == "Job Accepted successfully.") {
                              Future.delayed(const Duration(seconds: 1), () {
                                toastSuccessMessage("${jobsActionEmployeesModel.message }", Colors.green);
                                Get.to(
                                    Get.to(
                                      Empbottom_bar(currentIndex: 0),
                                      // EmpJobComplete(
                                      //   myJobId: "${getJobsEmployeesModel.data?[index].jobsId}",
                                      //   image:"$baseUrlImage${getJobsEmployeesModel.data?[index].image}",
                                      //   jobName: getJobsEmployeesModel.data?[index].name,
                                      //   totalPrice: getJobsEmployeesModel.data?[index].totalPrice,
                                      //   address: getJobsEmployeesModel.data?[index].location,
                                      //   completeJobTime: getJobsEmployeesModel.data?[index].dateAdded.toString(),
                                      //   description: getJobsEmployeesModel.data?[index].description,
                                      //   name: "${getJobsEmployeesModel.data?[index].usersCustomersData?.firstName} ${getJobsEmployeesModel.data?[index].usersCustomersData?.lastName}",
                                      //   profilePic: "$baseUrlImage${getJobsEmployeesModel.data?[index].usersCustomersData?.profilePic}",
                                      // ),
                                    )
                                );
                                setState(() {
                                  loading = false;
                                });
                                print("false: $loading");
                              });
                            }
                            if (jobsActionEmployeesModel.message == "This job is already assigned to you." || jobsActionEmployeesModel.message == "This job is already assigned to someone else. Thank you for your interest." ||  jobsActionEmployeesModel
                                .message == "You have already taken action on this Job.") {
                              toastFailedMessage(
                                  jobsActionEmployeesModel
                                      .message,
                                  Colors.red);
                              setState(() {
                                loading = false;
                              });
                            }
                          },
                          child: loading
                              ?  loadingBar(context)
                              : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              // height: 48,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Color(0xff2B65EC),
                                //   color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  // border:
                                  // Border.all(color: Color(0xffC70000), width: 1),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 0,
                                        blurRadius: 15,
                                        offset: Offset(1, 10),
                                        color: Color.fromRGBO(7, 1, 87, 0.1)),
                                  ]),
                              child: Center(
                                child: Text(
                                  "Accept",
                                  style: TextStyle(
                                      fontFamily: "Outfit",
                                      fontSize: 14,
                                      color: Color(0xffffffff),
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () async {

                            await JobsActionEmployeesReject();
                            setState(() {
                              isInAsyncCall = true;
                            });

                            if (jobsActionEmployeesModel
                                .message ==
                                "Job Rejected successfully.") {
                              Future.delayed(
                                  const Duration(
                                      seconds: 1), () {
                                toastSuccessMessage(
                                    "${jobsActionEmployeesModel
                                        .message}",
                                    Colors.green);
                                Get.to(
                                  Empbottom_bar(
                                    currentIndex: 0,
                                  ),
                                );
                                print("false: $loading");
                              });
                            }
                            if (jobsActionEmployeesModel
                                .status !=
                                "success") {
                              toastFailedMessage(
                                  jobsActionEmployeesModel
                                      .message,
                                  Colors.red);
                              Get.to(
                                Empbottom_bar(
                                  currentIndex: 0,
                                ),
                              );
                              setState(() {
                                isInAsyncCall = false;
                              });
                            }
                          },
                          child: isInAsyncCall
                              ?  loadingBar(context)
                              : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25, ),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              // height: 48,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Color(0xffC70000),
                                  //   color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  // border:
                                  // Border.all(color: Color(0xffC70000), width: 1),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 0,
                                        blurRadius: 15,
                                        offset: Offset(1, 10),
                                        color: Color.fromRGBO(7, 1, 87, 0.1)),
                                  ]),
                              child: Center(
                                child: Text(
                                  "Reject",
                                  style: TextStyle(
                                      fontFamily: "Outfit",
                                      fontSize: 14,
                                      color: Color(0xffffffff),
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
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
