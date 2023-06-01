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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            // height: 120,
            width: double.infinity,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: getJobsModel.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){
                      Get.to(bottom_bar(currentIndex: 3));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.68,
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
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child:
                                  // Image.asset("assets/images/jobarea.png", width: 96, height: 96,),
                                  FadeInImage(
                                    placeholder:  AssetImage("assets/images/fade_in_image.jpeg",),
                                    fit: BoxFit.fill,
                                    width: 120,
                                    height: 96,
                                    image: NetworkImage("$baseUrlImage${getJobsModel.data?[index].image}"),
                                  ),
                              ),
                              SizedBox(width: 9,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Container(
                                    //   width : Get.width * 0.3,
                                    //   child: Text(
                                    //     getJobsModel.data![index].name.toString(),
                                    //     style: TextStyle(
                                    //       color: Color(0xff000000),
                                    //       fontFamily: "Outfit",
                                    //       fontSize: 12,
                                    //       fontWeight: FontWeight.w500,
                                    //       // letterSpacing: -0.3,
                                    //     ),
                                    //     textAlign: TextAlign.left,
                                    //   ),
                                    // ),
                                    Container(
                                      width: Get.width * 0.27,
                                      child: AutoSizeText(
                                        getJobsModel.data![index].name.toString(),
                                            style: TextStyle(
                                              color: Color(0xff000000),
                                              fontFamily: "Outfit",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              // letterSpacing: -0.3,
                                            ),
                                        maxLines: 1,
                                        minFontSize: 12,
                                        presetFontSizes: [12],
                                        maxFontSize: 12,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                                      child: Text(
                                        "${getJobsModel.data![index].dateAdded}",
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
                                    Text(
                                      // "${getJobsModel.data![index].status}",
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
                                    SizedBox(height: 8,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                        // SizedBox(width: 5,),
                                        Container(
                                          width: 65,
                                          margin: EdgeInsets.only(top: 10),
                                          child: Column(
                                            // mainAxisAlignment: MainAxisAlignment.center,
                                            // crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                // "${usersProfileModel.data!.firstName} ${usersProfileModel.data!.lastName}",
                                                "${getJobsModel.data?[index].usersCustomersData?.firstName} ${getJobsModel.data?[index].usersCustomersData?.lastName}",
                                                // "${getJobsModel.data?[index].name}",
                                                // 'Wade Warren',
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
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                      "assets/images/star.png"),
                                                  Text(
                                                    '--',
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
