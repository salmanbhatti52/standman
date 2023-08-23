import 'dart:convert';

import 'package:StandMan/Pages/EmpBottombar.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Models/get_jobs_employees_Model.dart';
import '../../../Models/jobs_action_employees_Model.dart';
import '../../../Utils/api_urls.dart';
import '../../../widgets/MyButton.dart';
import 'package:http/http.dart' as http;
import '../../../widgets/ToastMessage.dart';
import '../../Customer/HomePage/HomePage.dart';
import 'EmpJobComplete.dart';
import 'EmpJobsDetails.dart';

class EmpJobs extends StatefulWidget {
  Datum3? getJobsEmployeesModel;
  String? jobIndex;
  EmpJobs({Key? key, this.jobIndex, this.getJobsEmployeesModel})
      : super(key: key);
  @override
  _EmpJobsState createState() => _EmpJobsState();
}

class _EmpJobsState extends State<EmpJobs> {
  JobsActionEmployeesModel jobsActionEmployeesModel =
      JobsActionEmployeesModel();

  bool isLoading = false;
  bool isClicked = false;
  JobsActionEmployeesAccept() async {
    setState(() {
      isLoading = true;
    });

    String apiUrl = jobsActionEmployeesApiUrl;
    print("working");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "users_customers_id": usersCustomersId,
        "jobs_id": widget.jobIndex,
        "status": "Accepted"
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
      // print('jobsActionEmployees status: ${jobsActionEmployeesModel.status}');
      print('jobsActionEmployees message: ${jobsActionEmployeesModel.message}');
    }
    setState(() {
      isLoading = false;
    });
  }

  JobsActionEmployeesReject() async {
    setState(() {
      isLoading = true;
    });

    String apiUrl = jobsActionEmployeesApiUrl;
    print("working");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "users_customers_id": usersCustomersId,
        "jobs_id": widget.jobIndex,
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
      isLoading = false;
    });
  }


  dynamic arriveJob = [];

  arrivedJob() async {
    setState(() {
      isLoading = true;
    });

    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('empUsersCustomersId');
    print("empUsersCustomersId = $usersCustomersId");
    print("jobid = ${widget.jobIndex}");

    http.Response response = await http.post(
      Uri.parse(employeeArrived),
      headers: {"Accept": "application/json"},
      body: {
        "users_customers_id": usersCustomersId,
        "jobs_id":  widget.jobIndex,
      },
    );
    if (mounted) {
      setState(() {
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);
          arriveJob = json.decode(response.body);
          print("arriveJob: $arriveJob");
          // if (jsonResponse['status'] == 'success') {
          //   String Message = jsonResponse['message'];
          //   print("message: $Message");
          // }
          isLoading = false;
        } else {
          print("Response Body ::${response.body}");
          isLoading = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Container(
            height: 120,
            decoration: BoxDecoration(
                // color: Colors.green,
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: Offset(0, 2),
                      color: Color.fromRGBO(167, 169, 183, 0.1)),
                ]),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(EmpJobDetaisl(
                        myJobId: "${widget.getJobsEmployeesModel?.jobsId}",
                        image:
                            "$baseUrlImage${widget.getJobsEmployeesModel?.image}",
                        jobStatus: '${widget.getJobsEmployeesModel?.status}',
                        jobName: widget.getJobsEmployeesModel?.name,
                        totalPrice: widget.getJobsEmployeesModel?.price,
                        address: widget.getJobsEmployeesModel?.location,
                        completeJobTime:
                            widget.getJobsEmployeesModel?.dateAdded.toString(),
                        description:
                            widget.getJobsEmployeesModel?.description == null
                                ? ""
                                : widget.getJobsEmployeesModel?.description,
                        name:
                            "${widget.getJobsEmployeesModel?.usersCustomersData?.firstName} ${widget.getJobsEmployeesModel?.usersCustomersData?.lastName}",
                        profilePic:
                            "$baseUrlImage${widget.getJobsEmployeesModel?.usersCustomersData?.profilePic}",
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: FadeInImage(
                            placeholder: AssetImage(
                              "assets/images/fade_in_image.jpeg",
                            ),
                            fit: BoxFit.fill,
                            width: 140,
                            height: 96,
                            image: NetworkImage(baseUrlImage +
                                "${widget.getJobsEmployeesModel?.image}")),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.5),
                          child: AutoSizeText(
                            "${widget.getJobsEmployeesModel?.name.toString()}",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontFamily: "Outfit",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              // letterSpacing: -0.3,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // Text(
                        //   "${getJobsEmployeesModel.data?[index].name.toString()}",
                        //   // 'Job name comes here',
                        //   style: TextStyle(
                        //     color: Color(0xff000000),
                        //     fontFamily: "Outfit",
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.w500,
                        //     // letterSpacing: -0.3,
                        //   ),
                        //   textAlign: TextAlign.left,
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0.0),
                          child: Text(
                            "${widget.getJobsEmployeesModel?.dateAdded}",
                            // 'Mar 03, 2023',
                            style: TextStyle(
                              color: Color(0xff9D9FAD),
                              fontFamily: "Outfit",
                              fontSize: 8,
                              fontWeight: FontWeight.w500,
                              // letterSpacing: -0.3,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/locationfill.svg',
                            ),
                            // Text(
                            //   "${getJobsEmployeesModel.data?[index].location} ",
                            //   style: const TextStyle(
                            //     color: Color(0xff9D9FAD),
                            //     fontFamily: "Outfit",
                            //     fontWeight: FontWeight.w400,
                            //     fontSize: 8,
                            //   ),
                            // ),
                            Container(
                              width: width * 0.4,
                              child: AutoSizeText(
                                "${widget.getJobsEmployeesModel?.location} ",
                                style: const TextStyle(
                                  color: Color(0xff9D9FAD),
                                  fontFamily: "Outfit",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 8,
                                ),
                                maxLines: 2,
                                minFontSize: 8,
                                maxFontSize: 8,
                                textAlign: TextAlign.left,
                                presetFontSizes: [8],
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "\$${widget.getJobsEmployeesModel?.price}",
                          // "\$22",
                          style: TextStyle(
                            color: Color(0xff2B65EC),
                            fontFamily: "Outfit",
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Row(
                          children: [
                            Container(
                              child: (widget.getJobsEmployeesModel?.status == "Accepted")
                                  ? Padding(
                                padding: const EdgeInsets.only(left: 28.0),
                                child: GestureDetector(
                                    onTap: () async {
                                      await arrivedJob();
                                      if (arriveJob['status'] == 'success') {
                                        toastSuccessMessage("Now, Your Job has been  Started", Colors.green);
                                      Get.to(Empbottom_bar(currentIndex: 0));
                                      }
                                      else {
                                        toastFailedMessage(arriveJob['message'], Colors.red);
                                        Get.to(Empbottom_bar(currentIndex: 0));
                                      }
                                    },
                                    child: smallButton2("Arrived job location", Color(0xff2B65EC), context)),
                              )
                                  : GestureDetector(
                                onTap: () async {

                                  await JobsActionEmployeesAccept();

                                  if (jobsActionEmployeesModel.message ==
                                      "Job Accepted successfully.") {
                                    setState(() {
                                      isClicked = true;
                                    });
                                    Future.delayed(
                                        const Duration(seconds: 1), () {
                                      Get.to(Empbottom_bar(currentIndex: 0));
                                      toastSuccessMessage(
                                          "${jobsActionEmployeesModel.message}",
                                          Colors.green);
                                      // Get.to(
                                      //   EmpJobComplete(
                                      //     myJobId:
                                      //         "${widget.getJobsEmployeesModel?.jobsId}",
                                      //     image:
                                      //         "$baseUrlImage${widget.getJobsEmployeesModel?.image}",
                                      //     jobName: widget
                                      //         .getJobsEmployeesModel?.name,
                                      //     totalPrice: widget
                                      //         .getJobsEmployeesModel?.price,
                                      //     address: widget
                                      //         .getJobsEmployeesModel
                                      //         ?.location,
                                      //     completeJobTime: widget
                                      //         .getJobsEmployeesModel
                                      //         ?.dateAdded
                                      //         .toString(),
                                      //     description: widget
                                      //                 .getJobsEmployeesModel
                                      //                 ?.description ==
                                      //             null
                                      //         ? ""
                                      //         : widget.getJobsEmployeesModel
                                      //             ?.description,
                                      //     name:
                                      //         "${widget.getJobsEmployeesModel?.usersCustomersData?.firstName} ${widget.getJobsEmployeesModel?.usersCustomersData?.lastName}",
                                      //     profilePic:
                                      //         "$baseUrlImage${widget.getJobsEmployeesModel?.usersCustomersData?.profilePic}",
                                      //     customerId: widget
                                      //         .getJobsEmployeesModel
                                      //         ?.usersCustomersId
                                      //         .toString(),
                                      //   ),
                                      // );
                                      print("false: $isLoading");
                                    });
                                  }
                                  if (jobsActionEmployeesModel.message == "This job is already assigned to you." ||
                                      jobsActionEmployeesModel.message ==
                                          "This job is already assigned to someone else. Thank you for your interest." ||
                                      jobsActionEmployeesModel.message ==
                                          "You have already taken action on this Job.") {
                                    toastFailedMessage(
                                        jobsActionEmployeesModel.message,
                                        Colors.red);
                                    Get.to(Empbottom_bar(currentIndex: 0));
                                  }
                                },
                                child: smallButton2(
                                    "Accept", Color(0xff2B65EC), context),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Container(
                              child :
                              (widget.getJobsEmployeesModel?.status == "Accepted")
                                    ? SizedBox()
                                    : GestureDetector(
                                  onTap: () async {
                                    await JobsActionEmployeesReject();

                                    if (jobsActionEmployeesModel.message ==
                                        "Job Rejected successfully.") {
                                      Future.delayed(const Duration(seconds: 1),
                                              () {
                                            toastSuccessMessage(
                                                "${jobsActionEmployeesModel.message}",
                                                Colors.green);
                                            Get.to(
                                              Empbottom_bar(
                                                currentIndex: 0,
                                              ),
                                            );
                                            print("false: $isLoading");
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
                                  child: smallButton2(
                                      "Reject", Color(0xffC70000), context),
                                ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

List menuList = [
  _MenuItemList("assets/images/jobarea.svg", "Heart Beat", 'N/A', Colors.grey),
  _MenuItemList("assets/images/jobarea.svg", "Heart Beat", 'N/A', Colors.grey),
  _MenuItemList(
      "assets/images/jobarea.svg", "Blood Prure", 'N/A', Colors.black12),
  _MenuItemList(
      "assets/images/jobarea.svg", "Blood Pressure", 'N/A', Colors.black12),
];

class _MenuItemList {
  final String image;
  final String title;
  final String subTitle;
  final Color color;

  _MenuItemList(this.image, this.title, this.subTitle, this.color);
}
