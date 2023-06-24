import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Models/get_jobs_employees_Model.dart';
import '../../../../Models/jobs_action_employees_Model.dart';
import '../../../../Utils/api_urls.dart';
import '../../../../widgets/MyButton.dart';
import '../../../../widgets/ToastMessage.dart';
import '../../../Customer/HomePage/HomePage.dart';
import 'package:http/http.dart' as http;
import '../../../EmpBottombar.dart';
import '../../HomePage/EmpJobComplete.dart';
import '../../HomePage/EmpJobsDetails.dart';
import 'Emp_findJobs.dart';

class Emp_ceate_Or_findJobs extends StatefulWidget {
  const Emp_ceate_Or_findJobs({Key? key}) : super(key: key);

  @override
  State<Emp_ceate_Or_findJobs> createState() => _Emp_ceate_Or_findJobsState();
}

class _Emp_ceate_Or_findJobsState extends State<Emp_ceate_Or_findJobs> {

  GetJobsEmployeesModel getJobsEmployeesModel = GetJobsEmployeesModel();
  bool loading = false;

  GetJobsEmployees() async {
    setState(() {
      loading = true;
    });
    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('empUsersCustomersId');
    longitude =  prefs!.getString('longitude1');
    lattitude =  prefs!.getString('lattitude1');
    print("usersCustomersId = $usersCustomersId");
    print("longitude1111: ${longitude}");
    print("lattitude1111: ${lattitude}");

    String apiUrl = getJobsEmployeesModelApiUrl;
    print("working");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "users_customers_id": usersCustomersId,
        // "employee_longitude": "${longitude.toString()}",
        "employee_longitude": longitude,
        // "employee_lattitude": "${lattitude.toString()}",
        "employee_lattitude": lattitude,
      },
    );
    final responseString = response.body;
    print("getJobsEmployeesModelApiUrl: ${response.body}");
    print("status Code getJobsEmployeesModel: ${response.statusCode}");
    print("in 200 getJobsEmployees");
    if (response.statusCode == 200) {
      getJobsEmployeesModel = getJobsEmployeesModelFromJson(responseString);
      // setState(() {});
      print('getJobsEmployeesModel status: ${getJobsEmployeesModel.status}');
      print(
          'getJobsEmployeesModel Length: ${getJobsEmployeesModel.data?.length}');
      setState(() {
        loading = false;
      });
      // print('getJobsModelImage: $baseUrlImage${getJobsModel.data![0].image}');
    }
  }

  // sharedPref() async {
  //   // prefs = await SharedPreferences.getInstance();
  //   // usersCustomersId = prefs!.getString('empUsersCustomersId');
  //   GetJobsEmployees();
  // }

  JobsActionEmployeesModel jobsActionEmployeesModel = JobsActionEmployeesModel();

  String? jobIndex;

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
        "jobs_id": jobIndex,
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
      print('jobsActionEmployees status: ${jobsActionEmployeesModel.status}');
      print('jobsActionEmployees message: ${jobsActionEmployeesModel.message}');
    }
    setState(() {
      loading = false;
    });
  }

  JobsActionEmployeesReject() async {
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
        "jobs_id": jobIndex,
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
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    print("users_employee_id: ${usersCustomersId}");
    super.initState();
    // sharedPref();
    GetJobsEmployees();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      loading
          ? Center(
        child: Lottie.asset(
          "assets/images/loading.json",
          height: 50,
        ),
      ) : getJobsEmployeesModel.data?.length == null
          ? Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: const Text(
              "No jobs available in\nyour area.",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Outfit",
                fontWeight: FontWeight.w500,
                fontSize: 32,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: height * 0.2,
          ),
          SvgPicture.asset(
            'assets/images/cartoon.svg',
          ),
        ],
      )
          : Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: getJobsEmployeesModel.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  jobIndex = "${getJobsEmployeesModel.data?[index].jobsId}";
                  // jobIndex = "${getJobsEmployeesModel.data?[index].usersCustomersData!.fullName}";
                  print('jobIndex $jobIndex');
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 5),
                    child: Container(
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                        // color: Colors.green,
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 0,
                                blurRadius: 20,
                                offset: Offset(0, 2),
                                color:
                                Color.fromRGBO(167, 169, 183, 0.1)),
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
                                  myJobId: "${getJobsEmployeesModel.data?[index].jobsId}",
                                  image:
                                  "$baseUrlImage${getJobsEmployeesModel.data?[index].image}",
                                  jobName: getJobsEmployeesModel
                                      .data?[index].name,
                                  totalPrice: getJobsEmployeesModel
                                      .data?[index].price,
                                  address: getJobsEmployeesModel
                                      .data?[index].location,
                                  completeJobTime: getJobsEmployeesModel
                                      .data?[index].dateAdded
                                      .toString(),
                                  description: getJobsEmployeesModel
                                      .data?[index].description,
                                  name: "${getJobsEmployeesModel.data?[index].usersCustomersData?.firstName} ${getJobsEmployeesModel.data?[index].usersCustomersData?.lastName}",
                                  profilePic: "$baseUrlImage${getJobsEmployeesModel.data?[index].usersCustomersData?.profilePic}",
                                ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 5.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: FadeInImage(
                                    placeholder: AssetImage(
                                      "assets/images/fade_in_image.jpeg",
                                    ),
                                    fit: BoxFit.fill,
                                    width: 140,
                                    height: 96,
                                    image: NetworkImage(
                                        "$baseUrlImage${getJobsEmployeesModel.data?[index].image}"),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 0.0),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
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
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth: MediaQuery.of(context).size.width * 0.45),
                                    child: AutoSizeText(
                                      "${getJobsEmployeesModel.data?[index].name.toString()}",
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0.0),
                                    child: Text(
                                      "${getJobsEmployeesModel.data?[index].dateAdded}",
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
                                      Container(
                                        width: width * 0.4,
                                        child: AutoSizeText(
                                          "${getJobsEmployeesModel.data?[index].location} ",
                                          // "${getJobsEmployeesModel.data?[index].longitude} ${getJobsEmployeesModel.data?[index].longitude}",
                                          // "No 15 uti street off ovie palace road effurun ..",
                                          style: const TextStyle(
                                            color: Color(0xff9D9FAD),
                                            fontFamily: "Outfit",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 8,
                                          ),
                                          minFontSize: 8,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "\$${getJobsEmployeesModel.data?[index].price}",
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
                                      GestureDetector(
                                        onTap: () async {
                                          await JobsActionEmployeesAccept();

                                          if (jobsActionEmployeesModel
                                              .message ==
                                              "Job Accepted successfully.") {
                                            Future.delayed(
                                                const Duration(
                                                    seconds: 1), () {
                                              toastSuccessMessage("${jobsActionEmployeesModel.message }", Colors.green);
                                              Get.to(
                                                EmpJobComplete(
                                                  myJobId: "${getJobsEmployeesModel.data?[index].jobsId}",
                                                  image:
                                                  "$baseUrlImage${getJobsEmployeesModel.data?[index].image}",
                                                  name: "${getJobsEmployeesModel.data?[index].usersCustomersData?.firstName} ${getJobsEmployeesModel.data?[index].usersCustomersData?.lastName}",
                                                  profilePic: "$baseUrlImage${getJobsEmployeesModel.data?[index].usersCustomersData?.profilePic}",
                                                  jobName:
                                                  getJobsEmployeesModel
                                                      .data?[index]
                                                      .name,
                                                  totalPrice:
                                                  getJobsEmployeesModel
                                                      .data?[index]
                                                      .price,
                                                  address:
                                                  getJobsEmployeesModel
                                                      .data?[index]
                                                      .location,
                                                  completeJobTime:
                                                  getJobsEmployeesModel
                                                      .data?[index]
                                                      .dateAdded
                                                      .toString(),
                                                  description:
                                                  getJobsEmployeesModel
                                                      .data?[index]
                                                      .description,
                                                ),
                                              );
                                              print("false: $loading");
                                            });
                                          }
                                          if (jobsActionEmployeesModel.message == "This job is already assigned to you." || jobsActionEmployeesModel.message == "You have already taken action on this Job." || jobsActionEmployeesModel
                                              .message ==
                                              "This job is already assigned to someone else. Thank you for your interest.") {
                                            toastFailedMessage(
                                                jobsActionEmployeesModel
                                                    .message,
                                                Colors.red);
                                            Get.to(
                                              Empbottom_bar(
                                                currentIndex: 3,
                                              ),
                                            );
                                          }
                                        },
                                        child: smallButton2("Accept",
                                            Color(0xff2B65EC), context),
                                      ),
                                      SizedBox(
                                        width: width * 0.02,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await JobsActionEmployeesReject();

                                          if (jobsActionEmployeesModel
                                              .message ==
                                              "Job Rejected successfully.") {
                                            Future.delayed(
                                                const Duration(
                                                    seconds: 1), () {
                                              toastSuccessMessage(
                                                  "Job Rejected",
                                                  Colors.green);
                                              Get.to(
                                                Empbottom_bar(
                                                  currentIndex: 3,
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
                                                currentIndex: 3,
                                              ),
                                            );
                                          }
                                        },
                                        child: smallButton2("Reject",
                                            Color(0xffC70000), context),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      )

      // Emp_Find_Job(),


      // Column(
      //   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     SizedBox(
      //       height: height * 0.02,
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(left: 10.0),
      //       child: const Text(
      //         "No jobs available in\nyour area.",
      //         style: TextStyle(
      //           color: Colors.black,
      //           fontFamily: "Outfit",
      //           fontWeight: FontWeight.w500,
      //           fontSize: 32,
      //         ),
      //         textAlign: TextAlign.left,
      //       ),
      //     ),
      //     SizedBox(
      //       height: height * 0.2,
      //     ),
      //     SvgPicture.asset('assets/images/cartoon.svg',),
      //   ],
      // ),
    );
  }
}
