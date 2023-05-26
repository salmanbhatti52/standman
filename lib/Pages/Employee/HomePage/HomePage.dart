// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../../../widgets/AppBar.dart';
// import '../../../widgets/MyButton.dart';
// import '../../Customer/HomePage/HeadRow.dart';
// import '../../Customer/HomePage/RecentJobs.dart';
// import '../../Drawer.dart';
// import 'Jobs.dart';
// import 'QueueJobs.dart';
//
// class EmpHomePage extends StatefulWidget {
//   const EmpHomePage({Key? key}) : super(key: key);
//
//   @override
//   State<EmpHomePage> createState() => _EmpHomePageState();
// }
//
// class _EmpHomePageState extends State<EmpHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       drawer: MyDrawer(),
//       appBar: AppBar(
//         toolbarHeight: height * 0.10,
//         backgroundColor: Color(0xff2B65EC),
//         elevation: 0,
//         centerTitle: true,
//         title: Padding(
//           padding: const EdgeInsets.only(top: 0.0),
//           child: Text(
//             "Home",
//             style: TextStyle(
//               color: Color(0xffffffff),
//               fontFamily: "Outfit",
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//               // letterSpacing: -0.3,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 20.0, top: 0.0),
//             child: SvgPicture.asset(
//               'assets/images/notification.svg',
//             ),
//           ),
//         ],
//       ),
//       // drawer: MyDrawer(),
//       backgroundColor: Color(0xff2B65EC),
//       body: SingleChildScrollView(
//         physics: NeverScrollableScrollPhysics(),
//         child: SafeArea(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: height * 0.04,
//               ),
//               AppBarr(text: 'Hme', imagePath: 'assets/images/notification.svg',),
//               Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 18.0, vertical: 20),
//                     child: Image.asset("assets/images/person.png"),
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Hello..!",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: "Outfit",
//                           fontWeight: FontWeight.w500,
//                           fontSize: 32,
//                         ),
//                         textAlign: TextAlign.left,
//                       ),
//                       const Text(
//                         "Marvis Ighedosa",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: "Outfit",
//                           fontWeight: FontWeight.w400,
//                           fontSize: 18,
//                         ),
//                         textAlign: TextAlign.left,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               Container(
//                 width: width,
//                 height: height * 0.76,
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     topRight: Radius.circular(30),
//                   ),
//                 ),
//                 child: SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     // crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: height * 0.02,
//                       ),
//                       Heading("Jobs ", "", context),
//                       EmpJobs(),
//                       Heading("Job in Queue ", "", context),
//                       QueueJobs(),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
