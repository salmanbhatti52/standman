import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../widgets/MyButton.dart';
import '../../../Employee/HomePage/Jobs.dart';
import '../Customer_AddRating/Customer_JobsDetails_AddRating.dart';
import 'Customer_OnGoingJobsList.dart';

class Customer_Create_Or_OnGoingJobs extends StatefulWidget {
  const Customer_Create_Or_OnGoingJobs({Key? key}) : super(key: key);

  @override
  State<Customer_Create_Or_OnGoingJobs> createState() => _Customer_Create_Or_OnGoingJobsState();
}

class _Customer_Create_Or_OnGoingJobsState extends State<Customer_Create_Or_OnGoingJobs> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body:
          CustomerOnGoingJobList(),
          // Column(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //   Padding(
          //     padding: const EdgeInsets.only(left: 10.0),
          //     child: const Text(
          //       "You did not created\nany job,",
          //       style: TextStyle(
          //         color: Colors.black,
          //         fontFamily: "Outfit",
          //         fontWeight: FontWeight.w500,
          //         fontSize: 32,
          //       ),
          //       textAlign: TextAlign.left,
          //     ),
          //   ),
          //   Padding(
          //     padding: const EdgeInsets.only(left: 10.0),
          //     child: const Text(
          //       "Please create your Job now..!",
          //       style: TextStyle(
          //         color: Color(0xff2B65EC),
          //         fontFamily: "Outfit",
          //         fontWeight: FontWeight.w500,
          //         fontSize: 24,
          //       ),
          //       textAlign: TextAlign.left,
          //     ),
          //   ),
          //   GestureDetector(
          //       onTap: () {
          //         Get.to(() => Customer_AddRating());
          //       },
          //       child: mainButton(
          //           "Create Job", Color.fromRGBO(43, 101, 236, 1), context)),
          //   SizedBox(
          //     height: height * 0.02,
          //   ),
          //   SvgPicture.asset(
          //     'assets/images/cartoon.svg',
          //   ),
          // ]),
    );
  }
}
