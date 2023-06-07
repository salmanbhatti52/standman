import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Models/Get_Previous_Jobs_Employee_Model.dart';
import '../../../../Utils/api_urls.dart';
import '../../../Customer/HomePage/HomePage.dart';
import '../Emp_Complete_Job/EMp_Job_Complete.dart';
import 'package:http/http.dart' as http;

class EmpPreviousJobList extends StatefulWidget {


  @override
  _EmpPreviousJobListState createState() => _EmpPreviousJobListState();
}

class _EmpPreviousJobListState extends State<EmpPreviousJobList> {

  GetPreviousJobsEmployeeModel getPreviousJobsEmployeeModel = GetPreviousJobsEmployeeModel();

  bool loading = false;

  GetPreviousJobsEmployees() async {

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

    String apiUrl = getPreviousJobsEmployeeModelApiUrl;
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
    print("getPreviousJobsEmployeeModelApiUrl: ${response.body}");
    print("status Code getPreviousJobsEmployeeModel: ${response.statusCode}");
    print("in 200 getPreviousJobsEmployee");
    if (response.statusCode == 200) {
      getPreviousJobsEmployeeModel = getPreviousJobsEmployeeModelFromJson(responseString);
      // setState(() {});
      print('getPreviousJobsEmployeeModel status: ${getPreviousJobsEmployeeModel.status}');
      print('getPreviousJobsEmployeeModel Length: ${getPreviousJobsEmployeeModel.data?.length}');
      // print('getJobsModelImage: $baseUrlImage${getJobsModel.data![0].image}');
    }
    setState(() {
      loading = false;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetPreviousJobsEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return loading? Center(child: CircularProgressIndicator()):

    getPreviousJobsEmployeeModel.data?.length == null ?
    Center(child:  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "No Previous Jobs",
          style: TextStyle(
            color: Color(0xff2B65EC),
            fontFamily: "Outfit",
            fontWeight: FontWeight.w500,
            fontSize: 32,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: Get.height * 0.1,
        ),
        SvgPicture.asset(
          'assets/images/cartoon.svg',
        ),
      ],
    )):
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Container(
        // color: Color(0xff9D9FAD),
        // height: MediaQuery.of(context).size.height * 0.16,
        width: 358,
        // height: 150,
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: getPreviousJobsEmployeeModel.data?.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: GestureDetector(
                  onTap: (){
                    Get.to(EMp_Job_Completed(
                      myJobId: "${getPreviousJobsEmployeeModel.data?[index].jobsId}",
                      image:"$baseUrlImage${getPreviousJobsEmployeeModel.data?[index].image}",
                      jobName: getPreviousJobsEmployeeModel.data?[index].name,
                      totalPrice: getPreviousJobsEmployeeModel.data?[index].totalPrice,
                      address: getPreviousJobsEmployeeModel.data?[index].location,
                      completeJobTime: getPreviousJobsEmployeeModel.data?[index].dateAdded.toString(),
                      description: getPreviousJobsEmployeeModel.data?[index].description,
                      name: "${getPreviousJobsEmployeeModel.data?[index].usersCustomersData?.firstName} ${getPreviousJobsEmployeeModel.data?[index].usersCustomersData?.lastName}",
                      profilePic: "$baseUrlImage${getPreviousJobsEmployeeModel.data?[index].usersCustomersData?.profilePic}",
                      customerId: "${getPreviousJobsEmployeeModel.data?[index].usersCustomersData?.usersCustomersId}",
                      status: "${getPreviousJobsEmployeeModel.data?[index].usersCustomersData?.status}",
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Colors.green,
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 0,
                              blurRadius: 20,
                              offset: Offset(0 , 2),
                              color: Color.fromRGBO(167, 169, 183, 0.1)
                          ),
                        ]
                    ),
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: FadeInImage(
                              placeholder: AssetImage(
                                "assets/images/fade_in_image.jpeg",
                              ),
                              fit: BoxFit.fill,
                              width: 140,
                              height: 96,
                              image: NetworkImage(
                                  "$baseUrlImage${getPreviousJobsEmployeeModel.data?[index].image}"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${getPreviousJobsEmployeeModel.data?[index].name.toString()}",
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontFamily: "Outfit",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    // letterSpacing: -0.3,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                                  child: Text(
                                    "${getPreviousJobsEmployeeModel.data?[index].dateAdded}",
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
                                    Text(
                                      "${getPreviousJobsEmployeeModel.data?[index].location} ",
                                      style: const TextStyle(
                                        color: Color(0xff9D9FAD),
                                        fontFamily: "Outfit",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 8,
                                      ),
                                    ),
                                  ],
                                ),
                                 Text(
                                   "\$${getPreviousJobsEmployeeModel.data?[index].totalPrice}",
                                  style: TextStyle(
                                    color: Color(0xff2B65EC),
                                    fontFamily: "Outfit",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Container(
                                  width: 67,
                                  height: 19,
                                  decoration: BoxDecoration(
                                    color:Color(0xffE9FFE7),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${getPreviousJobsEmployeeModel.data?[index].status}",
                                      style: TextStyle(
                                        color:Color(0xff10C900),
                                        fontFamily: "Outfit",
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
// letterSpacing: -0.3,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

List EmppreviousjobstList = [
  _emppreviousjobstList(
      "assets/images/hosp1.png", "Dr. Prem Tiwari", 'Completed', "djf", "sad", "hjgh"),
  _emppreviousjobstList(
      "assets/images/hosp1.png", "Dr. Prem Tiwari", 'Completed', "djf", "sda", "dsc"),
  _emppreviousjobstList(
      "assets/images/hosp1.png", "Dr. Prem Tiwari", 'Completed', "djf", "sac", "cddc"),
  _emppreviousjobstList(
      "assets/images/hosp1.png", "Dr. Prem Tiwari", 'Completed', "djf", "sad", "dc"),
  _emppreviousjobstList(
      "assets/images/hosp1.png", "Dr. Prem Tiwari", 'Cancelled', "djf", "sacc","cdc"),
];

class _emppreviousjobstList {
  final String image;
  final String title;
  final String subTitle;
  final String image2;
  final String text;
  final String button;

  _emppreviousjobstList(this.image, this.title, this.subTitle, this.image2, this.text, this.button);
}
