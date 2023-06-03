import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Models/all_ratings_Model.dart';
import '../../../Utils/api_urls.dart';
import 'package:http/http.dart' as http;
import '../../Customer/HomePage/HomePage.dart';

class RatingProfile extends StatefulWidget {
  @override
  _RatingProfileState createState() => _RatingProfileState();
}

class _RatingProfileState extends State<RatingProfile> {

  AllRatingsModel allRatingsModel = AllRatingsModel();
  bool loading = false;

  allJobRating() async {
    setState(() {
      loading = true;
    });
    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('empUsersCustomersId');
    print("userId = $usersCustomersId");
    String apiUrl = allJobRatingModelApiUrl;
    print("working");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "users_customers_id": usersCustomersId.toString(),
      },
    );
    final responseString = response.body;
    print("allJobRatingModelApi: ${response.body}");
    print("status Code allJobRatingModel: ${response.statusCode}");
    print("in 200 allJobRatingModel");
    if (response.statusCode == 200) {
      allRatingsModel = allRatingsModelFromJson(responseString);
      // setState(() {});
      // print('getJobsModelImage: $baseUrlImage${al.data?[0].image}');
      // print('getJobsModelLength: ${getJobsModel.data?.length}');
      // print('getJobsModelemployeeusersCustomersType: ${ getJobsModel.data?[0].usersEmployeeData?.usersCustomersId}');
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
    allJobRating();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      child: loading ? Center(child: CircularProgressIndicator()) :

      allRatingsModel.data?.length == null?
        Center(child:  Text("No Ratings"))
          :Container(
        // color: Color(0xff9D9FAD),
        // height: MediaQuery.of(context).size.height * 0.16,
        // width: 358,
        // height: 150,
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            // physics: BouncingScrollPhysics(),
            itemCount: allRatingsModel.data?.length,
            itemBuilder: (BuildContext context, int index) {
              return  Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
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
                              // Get.to(page);
                            },
                            child: CircleAvatar(
                                radius: 32,
                                backgroundColor: Colors.transparent,
                                backgroundImage: allRatingsModel.data![index].customerData?.profilePic== null
                                    ? Image.asset("assets/images/person2.png").image
                                    : NetworkImage(baseUrlImage+"${allRatingsModel.data![index].customerData?.profilePic.toString()}")
                            ),
                        ),
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
                                "${allRatingsModel.data?[index].customerData?.firstName} ${allRatingsModel.data?[index].customerData?.lastName}",
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontFamily: "Outfit",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: Container(
                                  width: Get.width * 0.68,
                                  child: AutoSizeText(
                                    "${allRatingsModel.data?[index].comment}",
                                    style: const TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontFamily: "Outfit",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                    ),
                                    maxLines: 2,
                                    minFontSize: 10,
                                    maxFontSize: 10,
                                    presetFontSizes: [10],
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Color(0xffFFDF00), size: 15,),
                                  Text(
                                    "${allRatingsModel.data?[index].rating}",
                                    style: TextStyle(
                                      color: Color(0xff000000),
                                      fontFamily: "Outfit",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
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
              );
            }),
      ),
    );
  }
}

List jobstList = [
  _jobsList("assets/images/hosp1.png", "Dr. Prem Tiwari", 'Completed', "djf", "sad", "hjgh"),
  _jobsList("assets/images/hosp1.png", "Dr. Prem Tiwari", 'Completed', "djf", "sad", "hjgh"),
  _jobsList("assets/images/hosp1.png", "Dr. Prem Tiwari", 'Completed', "djf", "sad", "hjgh"),
  _jobsList(
      "assets/images/hosp1.png", "Dr. Prem Tiwari", 'Completed', "djf", "sda", "dsc"),
  _jobsList(
      "assets/images/hosp1.png", "Dr. Prem Tiwari", 'Completed', "djf", "sac", "cddc"),
  _jobsList(
      "assets/images/hosp1.png", "Dr. Prem Tiwari", 'Completed', "djf", "sad", "dc"),
  _jobsList("assets/images/hosp1.png", "Dr. Prem Tiwari", 'Cancelled', "djf", "sacc","cdc"),
];

class _jobsList {
  final String image;
  final String title;
  final String subTitle;
  final String image2;
  final String text;
  final String button;

  _jobsList(this.image, this.title, this.subTitle, this.image2, this.text, this.button);
}
