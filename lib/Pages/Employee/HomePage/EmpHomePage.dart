import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Models/Employee_OngoingJobs_Model.dart';
import '../../../Models/get_jobs_employees_Model.dart';
import '../../../Models/users_profilet_model.dart';
import '../../../Utils/api_urls.dart';
import '../../Customer/HomePage/HeadRow.dart';
import '../../Customer/HomePage/HomePage.dart';
import '../../Drawer.dart';
import '../../EmpDrawer.dart';
import 'EmpJobs.dart';
import 'package:http/http.dart' as http;
import 'EmpQueueJobs.dart';

String? empUserEmail;
String? empPassword;
String? empFullName;
String? empPhoneNumber;
String? empProfilePic1;
String? empUsersCustomersId;
SharedPreferences? empPrefs;

class EmpHomePage extends StatefulWidget {
  const EmpHomePage({Key? key}) : super(key: key);

  @override
  State<EmpHomePage> createState() => _EmpHomePageState();
}

class _EmpHomePageState extends State<EmpHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserProfileWidget();
    sharePref();
    getOngoingJobsEmployees();
    GetJobsEmployees();
  }

  UsersProfileModel usersProfileModel = UsersProfileModel();

  bool progress = false;
  bool isInAsyncCall = false;

  getUserProfileWidget() async {

    setState(() {
      progress = true;
    });
    prefs = await SharedPreferences.getInstance();
    empUsersCustomersId = prefs!.getString('empUsersCustomersId');
    print("userId in Prefs is = $usersCustomersId");
    try {
      String apiUrl = usersProfileApiUrl;
      print("getUserProfileApi: $apiUrl");
      final response = await http.post(Uri.parse(apiUrl),
          body: {
            "users_customers_id": empUsersCustomersId.toString(),
          }, headers: {
            'Accept': 'application/json'
          });
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("getUserProfileResponse: ${responseString.toString()}");
        usersProfileModel = usersProfileModelFromJson(responseString);
        print("getUserName: ${usersProfileModel.data!.lastName}");
        print("getUserEmail: ${usersProfileModel.data!.email}");
        print("getUserEmail: ${usersProfileModel.data!.email}");
        print("getUserNumber: ${usersProfileModel.data!.phone}");
        print("usersCustomersId: ${usersProfileModel.data!.usersCustomersId}");
        setState(() {
          progress = false;
        });
        print(
            "getUserProfileImage: $baseUrlImage${usersProfileModel.data!.profilePic}");
      }
    } catch (e) {
      print('Error in getUserProfileWidget: ${e.toString()}');
    }
  }

  EmployeeOngoingJobsModel employeeOngoingJobsModel = EmployeeOngoingJobsModel();

  getOngoingJobsEmployees() async {

    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('empUsersCustomersId');
    longitude =  prefs!.getString('longitude1');
    lattitude =  prefs!.getString('lattitude1');
    print("usersCustomersId = $usersCustomersId");
    print("longitude1111: ${longitude}");
    print("lattitude1111: ${lattitude}");

    String apiUrl = getOngoingJobsEmployeeModelApiUrl;
    print("working");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "users_customers_id": usersCustomersId,
        "employee_longitude": longitude,
        "employee_lattitude": lattitude,
      },
    );
    final responseString = response.body;
    print("getOngoingJobsEmployeesModelApiUrl: ${response.body}");
    print("status Code getOngoingJobsEmployeesModel: ${response.statusCode}");
    print("in 200 getOngoingJobsEmployees");
    if (response.statusCode == 200) {
      employeeOngoingJobsModel = employeeOngoingJobsModelFromJson(responseString);
      // setState(() {});
      print('getJobsEmployeesModel status: ${employeeOngoingJobsModel.status}');
      print('getJobsEmployeesModel Length: ${employeeOngoingJobsModel.data?.length}');
    }
  }

  sharePref() async {
    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('empUsersCustomersId');
    longitude =  prefs!.getString('longitude1');
    lattitude =  prefs!.getString('lattitude1');
    print("usersCustomersId = $usersCustomersId");
    print("longitude1111: ${longitude}");
    print("lattitude1111: ${lattitude}");
  }

  GetJobsEmployeesModel getJobsEmployeesModel = GetJobsEmployeesModel();

  String? jobIndex;
  GetJobsEmployees() async {
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
        "employee_longitude": longitude,
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
      // print('getJobsEmployeesModel status: "${getJobsEmployeesModel.data?[index].usersCustomersData?.first_name} ${getJobsEmployeesModel.data?[index].usersCustomersData?.last_name}",');
      print('getJobsEmployeesModel status: ${getJobsEmployeesModel.status}');
      print('getJobsEmployeesModel Length: ${getJobsEmployeesModel.data?.length}');
      // print('getJobsModelImage: $baseUrlImage${getJobsModel.data![0].image}');
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: EmpDrawer(),
      appBar: AppBar(
        toolbarHeight: height * 0.10,
        backgroundColor: Color(0xff2B65EC),
        elevation: 0,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Text(
            "Home",
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
          Padding(
            padding: const EdgeInsets.only(right: 20.0, top: 0.0),
            child: SvgPicture.asset(
              'assets/images/notification.svg',
            ),
          ),
        ],
      ),
      // drawer: MyDrawer(),
      backgroundColor: Color(0xff2B65EC),
      body:
      // progress
      //     ? Center(child: CircularProgressIndicator(color: Colors.blueAccent))
      //     : usersProfileModel.status != "success"
      //     ? Center(
      //     child: Text('no data found...',
      //         style: TextStyle(fontWeight: FontWeight.bold)))
      //     :
      SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
          padding:  EdgeInsets.only(bottom: height* 0.01,),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 18.0, right: 18, bottom: 0),
                      child:
                      // Image.asset("assets/images/person.png"),
                      Container(
                        child: progress
                            ? CircleAvatar(
                          radius: 35,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade500,
                            highlightColor: Colors.grey.shade200,
                            child: Text('',),),)
                            : usersProfileModel.status != "success"
                            ? Center(
                            child: Text('',
                                style: TextStyle(fontWeight: FontWeight.bold)))
                            : CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.transparent,
                            backgroundImage:  usersProfileModel.data!.usersCustomersId.toString() == null
                                ? Image.asset("assets/images/person2.png").image
                                : NetworkImage(baseUrlImage+usersProfileModel.data!.profilePic.toString())

                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Hello..!",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Outfit",
                            fontWeight: FontWeight.w500,
                            fontSize: 32,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          child: usersProfileModel.status != "success" ? Text("") : Text(
                            "${usersProfileModel.data?.firstName} ${usersProfileModel.data?.lastName}",
                            // "${usersProfileModel.data!.firstName "$+" usersProfileModel.data.lastName}",
                            // "Marvis Ighedosa",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Outfit",
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: Container(
                  width: width,
                  height: height * 0.7,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Heading("Jobs ", "", context),
                        // EmpJobs(),
                        Container(
                          height: 380,
                          child:
                           getJobsEmployeesModel.data !=null ?
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: ScrollPhysics(),
                              itemCount: getJobsEmployeesModel.data?.length,
                              itemBuilder: (BuildContext context, i) {
                                jobIndex = "${getJobsEmployeesModel.data?[i].jobsId}";
                                return  EmpJobs(getJobsEmployeesModel: getJobsEmployeesModel.data?[i], jobIndex: jobIndex,);
                              })
                              : Column(
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
                          ),
                        ),
                        Heading("Job in Queue ", "", context),
                        // QueueJobs(),
                        Container(
                          height: 200,
                          child: employeeOngoingJobsModel.data !=null ?
                          ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: ScrollPhysics(),
                              itemCount: employeeOngoingJobsModel.data?.length,
                              itemBuilder: (BuildContext context, i) {
                                return  QueueJobs(employeeOngoingJobsModel: employeeOngoingJobsModel.data?[i],);
                              }): Center(child: Text('No Queue Jobs')),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
