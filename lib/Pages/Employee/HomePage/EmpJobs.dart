import 'package:StandMan/Pages/EmpBottombar.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Models/get_jobs_employees_Model.dart';
import '../../../Models/jobs_action_employees_Model.dart';
import '../../../Utils/api_urls.dart';
import '../../../widgets/MyButton.dart';
import 'package:http/http.dart' as http;
import '../../../widgets/ToastMessage.dart';
import '../../Customer/HomePage/HomePage.dart';
import 'EmpHomePage.dart';
import 'EmpJobComplete.dart';
import 'EmpJobsDetails.dart';

class EmpJobs extends StatefulWidget {
  @override
  _EmpJobsState createState() => _EmpJobsState();
}

class _EmpJobsState extends State<EmpJobs> {


  GetJobsEmployeesModel getJobsEmployeesModel = GetJobsEmployeesModel();
  bool loading = false;

  GetJobsEmployees() async {
    setState(() {
      loading = true;
    });

    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('empUsersCustomersId');
    longitude =  prefs!.getDouble('longitude');
    lattitude =  prefs!.getDouble('latitude');
    print("usersCustomersId = $usersCustomersId");
    print("longitude: ${longitude}");
    print("lattitude: ${lattitude}");

    String apiUrl = getJobsEmployeesModelApiUrl;
    print("working");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "users_customers_id": usersCustomersId,
        "employee_longitude": "123123",
        "employee_lattitude": "123123",
      },
    );
    final responseString = response.body;
    print("getJobsEmployeesModelApiUrl: ${response.body}");
    print("status Code getJobsEmployeesModel: ${response.statusCode}");
    print("in 200 getJobsEmployees");
    if (response.statusCode == 200) {
      getJobsEmployeesModel = getJobsEmployeesModelFromJson(responseString);
      // setState(() {});
      // print('getJobsEmployeesModel status: "${getJobsEmployeesModel.data?[index].usersCustomersData?.first_name} ${getJobsEmployeesModel.data?[index].usersCustomersData?.last_name}",');
      print('getJobsEmployeesModel Length: ${getJobsEmployeesModel.data?.length}');
      // print('getJobsModelImage: $baseUrlImage${getJobsModel.data![0].image}');
    }
    setState(() {
      loading = false;
    });
  }

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
        "jobs_id":  jobIndex,
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
    return loading
        ? Center(child: CircularProgressIndicator())
        : getJobsEmployeesModel.data?.length == null
            ? Column(
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
                    height: height * 0.08,
                  ),
                  SvgPicture.asset(
                    'assets/images/cartoon.svg',
                  ),
                ],
              )
            : Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
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
                                          image: "$baseUrlImage${getJobsEmployeesModel.data?[index].image}",
                                          jobName: getJobsEmployeesModel.data?[index].name,
                                          totalPrice: getJobsEmployeesModel.data?[index].totalPrice,
                                          address: getJobsEmployeesModel.data?[index].location,
                                          completeJobTime: getJobsEmployeesModel.data?[index].dateAdded.toString(),
                                          description: getJobsEmployeesModel.data?[index].description,
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
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context).size.width * 0.5),
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
                                                  "${getJobsEmployeesModel.data?[index].location} ",
                                                    style: const TextStyle(
                                                      color: Color(0xff9D9FAD),
                                                      fontFamily: "Outfit",
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 8,),
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
                                            "\$${getJobsEmployeesModel.data?[index].totalPrice}",
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

                                                  if (jobsActionEmployeesModel.message == "Job Accepted successfully.") {
                                                    Future.delayed(const Duration(seconds: 1), () {
                                                      toastSuccessMessage("${jobsActionEmployeesModel.message }", Colors.green);
                                                      Get.to(
                                                        EmpJobComplete(
                                                          myJobId: "${getJobsEmployeesModel.data?[index].jobsId}",
                                                          image:"$baseUrlImage${getJobsEmployeesModel.data?[index].image}",
                                                          jobName: getJobsEmployeesModel.data?[index].name,
                                                          totalPrice: getJobsEmployeesModel.data?[index].totalPrice,
                                                          address: getJobsEmployeesModel.data?[index].location,
                                                          completeJobTime: getJobsEmployeesModel.data?[index].dateAdded.toString(),
                                                          description: getJobsEmployeesModel.data?[index].description,
                                                          name: "${getJobsEmployeesModel.data?[index].usersCustomersData?.firstName} ${getJobsEmployeesModel.data?[index].usersCustomersData?.lastName}",
                                                          profilePic: "$baseUrlImage${getJobsEmployeesModel.data?[index].usersCustomersData?.profilePic}",
                                                        ),
                                                      );
                                                      print("false: $loading");
                                                    });
                                                  }
                                                  if (jobsActionEmployeesModel
                                                              .message ==
                                                          "This job is already assigned to you." ||
                                                      jobsActionEmployeesModel
                                                              .message ==
                                                          "This job is already assigned to someone else. Thank you for your interest." || jobsActionEmployeesModel
                                                      .message ==
                                                  "You have already taken action on this Job.") {
                                                    toastFailedMessage(
                                                        jobsActionEmployeesModel
                                                            .message,
                                                        Colors.red);
                                                    Get.to(Empbottom_bar(currentIndex: 0));
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
