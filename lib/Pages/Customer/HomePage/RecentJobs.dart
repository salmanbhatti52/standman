import 'package:StandMan/Pages/Bottombar.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Models/get_OnGoing_jobs_Model.dart';
import '../../../Models/users_profilet_model.dart';
import '../../../Utils/api_urls.dart';
import 'package:http/http.dart' as http;
import 'HomePage.dart';

class RecentJobs extends StatefulWidget {
  @override
  _RecentJobsState createState() => _RecentJobsState();
}

class _RecentJobsState extends State<RecentJobs> {

  GetJobsModel getJobsModel = GetJobsModel();
  bool loading = false;
  getJobsCustomer() async {
    setState(() {
      loading = true;
    });
    String apiUrl = getOngoingJobsModelApiUrl;
    print("working");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "users_customers_id": usersCustomersId,
      },
    );
    final responseString = response.body;
    print("getJobsModelApi: ${response.body}");
    print("status Code getJobsModel: ${response.statusCode}");
    print("in 200 getJobs");
    if (response.statusCode == 200) {
      getJobsModel = getJobsModelFromJson(responseString);
      // setState(() {});
      print('getJobsModel status: ${getJobsModel.status}');
      print('getJobsModelLength: ${getJobsModel.data?.length}');
      print('getJobsModelImage123: $baseUrlImage${getJobsModel.data?[0].image}');
    }
    setState(() {
      loading = false;
    });
  }

  UsersProfileModel usersProfileModel = UsersProfileModel();

  bool progress = false;
  bool isInAsyncCall = false;

  // getUserProfileWidget() async {
  //   progress = true;
  //   // setState(() {});
  //   try {
  //     String apiUrl = usersProfileApiUrl;
  //     print("getUserProfileApi: $apiUrl");
  //     final response = await http.post(Uri.parse(apiUrl),
  //         body: {
  //           "users_customers_id": usersCustomersId.toString(),
  //         }, headers: {
  //           'Accept': 'application/json'
  //         });
  //     print('${response.statusCode}');
  //     print(response);
  //     if (response.statusCode == 200) {
  //       final responseString = response.body;
  //       print("getUserProfileResponse: ${responseString.toString()}");
  //       usersProfileModel = usersProfileModelFromJson(responseString);
  //       print("getUserName: ${usersProfileModel.data!.lastName}");
  //       print("getUserEmail: ${usersProfileModel.data!.email}");
  //       print("getUserEmail: ${usersProfileModel.data!.email}");
  //       print("getUserNumber: ${usersProfileModel.data!.phone}");
  //       print("usersCustomersId: ${usersProfileModel.data!.usersCustomersId}");
  //       print(
  //           "getUserProfileImage: $baseUrlImage${usersProfileModel.data!.profilePic}");
  //     }
  //   } catch (e) {
  //     print('Error in getUserProfileWidget: ${e.toString()}');
  //   }
  //   progress = false;
  //   // setState(() {});
  // }

  @override
  void initState() {
    // TODO: implement initState
    print("users_customers_id: ${usersCustomersId}");
    super.initState();
    getJobsCustomer();
    // getUserProfileWidget();
  }

  @override
  Widget build(BuildContext context) {
    return loading? Center(child: CircularProgressIndicator()):

    getJobsModel.data?.length == null ?
    Center(child: Text('No Recent Jobs')) :
    // Center(child: Text('No Recent Jobs'));
    Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 15),
          height: MediaQuery.of(context).size.height * 0.2,
          // height: 120,
          width: double.infinity,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: getJobsModel.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(bottom_bar(
                      currentIndex: 3,
                    ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 5),
                    // padding: EdgeInsets.all( 10),
                    // width: MediaQuery.of(context).size.width * 0.51,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 0,
                              blurRadius: 20,
                              offset: Offset(0, 2),
                              color: Color.fromRGBO(167, 169, 183, 0.1)),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child:
                            // Image.asset("assets/images/jobarea.png", width: 96, height: 96,),
                            FadeInImage(
                              placeholder:  AssetImage("assets/images/fade_in_image.jpeg",),
                              fit: BoxFit.fill,
                              width: 115,
                              height: 96,
                              image: NetworkImage("$baseUrlImage${getJobsModel.data?[index].image}"),
                            ),
                          ),
                          SizedBox(width: Get.width * 0.02,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: Get.width * 0.32,
                                child: AutoSizeText(
                                  // 'Eleanor Pena',
                                  "${getJobsModel.data?[index].name.toString()}",
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontFamily: "Outfit",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
// letterSpacing: -0.3,
                                  ),
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                  presetFontSizes: [11],
                                  maxFontSize: 11,
                                  minFontSize: 11,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0),
                                child: Text(
                                  // 'Mar 03, 2023',
                                  "${getJobsModel.data?[index].dateAdded}",
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
                              Text(
                                'Taken By',
                                style: TextStyle(
                                  color: Color(0xff2B65EC),
                                  fontFamily: "Outfit",
                                  fontSize: 8,
                                  fontWeight: FontWeight.w400,
// letterSpacing: -0.3,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Image.asset("assets/images/g1.png"),
                                  CircleAvatar(
                                    // radius: (screenWidth > 600) ? 90 : 70,
                                    //   radius: 50,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: getJobsModel.data![index].usersCustomersData!.profilePic == null
                                          ? Image.asset("assets/images/person2.png").image
                                          : NetworkImage(baseUrlImage+getJobsModel.data![index].usersCustomersData!.profilePic.toString())
                                    // NetworkImage(baseUrlImage+ getUserProfileModelObject.data!.profilePic!)

                                  ),
                                  // CircleAvatar(
                                  //     backgroundColor: Colors.transparent,
                                  //     backgroundImage: profilePic1 == null
                                  //         ? Image.asset("assets/images/g1.png").image
                                  //         : NetworkImage(baseUrlImage+getJobsModel.data!.profilePic.toString())
                                  // ),
                                  // CircleAvatar(
                                  //   backgroundColor: Colors.transparent,
                                  //   backgroundImage: NetworkImage(
                                  //       "$baseUrlImage${getJobsModel.data?[index].}"),),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 65,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          // 'Wade Warren',
                                          "${getJobsModel.data?[index].usersCustomersData?.firstName} ${getJobsModel.data?[index].usersCustomersData?.lastName}",
                                          // "${usersProfileModel.data?.firstName} ${usersProfileModel.data?.lastName}",
                                          style: TextStyle(
                                            color: Color(0xff000000),
                                            fontFamily: "Outfit",
                                            fontSize: 8,
                                            fontWeight: FontWeight.w500,
// letterSpacing: -0.3,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                                "assets/images/star.png"),
                                            Text(
                                              '--',
                                              // getJobsModel.data?[index].rating,
                                              style: TextStyle(
                                                color: Color(0xff000000),
                                                fontFamily: "Outfit",
                                                fontSize: 8,
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
                              )
                            ],
                          ),
                        ],
                      ),
                    ),),
                );
              }),
        ),
      ],
    );
  }
}

List menuList = [
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
