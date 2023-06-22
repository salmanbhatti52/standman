import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Models/Employee_OngoingJobs_Model.dart';
import '../../../Models/get_jobs_employees_Model.dart';
import '../../../Utils/api_urls.dart';
import '../../Customer/HomePage/HomePage.dart';
import 'EmpJobComplete.dart';
import 'package:http/http.dart' as http;

class QueueJobs extends StatefulWidget {

  Datum2? employeeOngoingJobsModel;
  QueueJobs({Key? key, this.employeeOngoingJobsModel}) : super(key: key);
  @override
  _QueueJobsState createState() => _QueueJobsState();
}

class _QueueJobsState extends State<QueueJobs> {


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return  Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            child: GestureDetector(
              // onTap: (){
              //   Get.to(EmpJobComplete());
              // },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
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
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage(
                            placeholder: AssetImage(
                              "assets/images/fade_in_image.jpeg",
                            ),
                            fit: BoxFit.fill,
                            width: 120,
                            height: 96,
                            image: NetworkImage(
                                "$baseUrlImage${widget.employeeOngoingJobsModel?.image}"),
                          ),),
                        SizedBox(width: 10,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                    maxWidth: MediaQuery.of(context).size.width * 0.37),
                                child: AutoSizeText(
                                  "${widget.employeeOngoingJobsModel?.name.toString()}",
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
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "${widget.employeeOngoingJobsModel?.dateAdded}",
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
                                  //   // "${getJobsEmployeesModel.data?[index].longitude} ${getJobsEmployeesModel.data?[index].longitude}",
                                  //   // "No 15 uti street off ovie palace road effurun ..",
                                  //   style: const TextStyle(
                                  //     color: Color(0xff9D9FAD),
                                  //     fontFamily: "Outfit",
                                  //     fontWeight: FontWeight.w400,
                                  //     fontSize: 8,
                                  //   ),
                                  // ),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth: MediaQuery.of(context).size.width * 0.35),
                                    child: AutoSizeText(
                                      "${widget.employeeOngoingJobsModel?.location} ",
                                      style: const TextStyle(
                                        color: Color(0xff9D9FAD),
                                        fontFamily: "Outfit",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 8,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      maxFontSize: 8,
                                      minFontSize: 8,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "\$${widget.employeeOngoingJobsModel?.price}",
                                // "\$22",
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
                                  color: Color(0xffFFDACC),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    "${widget.employeeOngoingJobsModel?.status}",
                                    style: TextStyle(
                                      color: Color(0xffFF4700),
                                      fontFamily: "Outfit",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
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
