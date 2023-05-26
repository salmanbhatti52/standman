// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import '../../../widgets/MyButton.dart';
// import '../../../widgets/TopBar.dart';
// import 'Emp_user_transaction_details.dart';
//
// class EmpWalletPage extends StatefulWidget {
//   const EmpWalletPage({Key? key}) : super(key: key);
//
//   @override
//   State<EmpWalletPage> createState() => _EmpWalletPageState();
// }
//
// class _EmpWalletPageState extends State<EmpWalletPage> {
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       // drawer: MyDrawer(),
//       backgroundColor: Color(0xff2B65EC),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15.0),
//               child: TopBar2(
//                 text: 'Wallet',
//                 imagePath: 'assets/images/menu.svg',
//               ),
//             ),
//             SizedBox(
//               height: height * 0.04,
//             ),
//             Container(
//               width: width * 0.9, // 351,
//               height: height * 0.15, // 131,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 color: Color(0xffFF9900),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         "Earning to date",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: "Outfit",
//                           fontWeight: FontWeight.w400,
//                           fontSize: 16,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const Text(
//                         "\$4,875.00",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: "Outfit",
//                           fontWeight: FontWeight.w500,
//                           fontSize: 32,
//                         ),
//                         textAlign: TextAlign.left,
//                       ),
//                     ],
//                   ),
//                   SvgPicture.asset("assets/images/empty-wallet.svg"),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: height * 0.02,
//             ),
//             Container(
//               width: width * 0.9, // 351,
//               height: height * 0.16, // 131,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 color: Color(0xffffffff),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         "Available to Withdraw",
//                         style: TextStyle(
//                           color: Color(0xff2B65EC),
//                           fontFamily: "Outfit",
//                           fontWeight: FontWeight.w400,
//                           fontSize: 16,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const Text(
//                         "\$4,875.00",
//                         style: TextStyle(
//                           color: Color(0xff2B65EC),
//                           fontFamily: "Outfit",
//                           fontWeight: FontWeight.w500,
//                           fontSize: 32,
//                         ),
//                         textAlign: TextAlign.left,
//                       ),
//                     ],
//                   ),
//                   smallButton("Withdraw", Color(0xff2B65EC), context),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: height * 0.02,
//             ),
//             Container(
//               width: width,
//               height: 313.6,
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30),
//                   topRight: Radius.circular(30),
//                 ),
//               ),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Padding(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
//                       child: Text(
//                         "Amount History",
//                         style: TextStyle(
//                           color: Color(0xff000000),
//                           fontFamily: "OutFit",
//                           fontWeight: FontWeight.w400,
//                           fontSize: 16,
//                         ),
//                         textAlign: TextAlign.left,
//                       ),
//                     ),
//                     Container(
//                       // height: MediaQuery.of(context).size.height * 0.16,
//                       width: width,
//                       color: Colors.transparent,
//                       height:  height * 0.29, //300,
//                       child: ListView.builder(
//                           shrinkWrap: true,
//                           // physics: NeverScrollableScrollPhysics(),
//                           scrollDirection: Axis.vertical,
//                           itemCount: transactionList.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             return Padding(
//                               padding: const EdgeInsets.only(bottom: 0.0),
//                               child: GestureDetector(
//                                 // onTap: () {
//                                 //   // Get.to("jh");
//                                 //   Emp_user_transaction_details(ctx: context);
//                                 //   print("object");
//                                 // },
//                                 child: Container(
//                                   // height: MediaQuery.of(context).size.height * 0.4,
//                                   // width: MediaQuery.of(context).size.width * 0.3,
//                                   // width: 358,
//                                   height: height * 0.1, //80,
//                                   decoration: const BoxDecoration(
//                                     border: Border(
//                                       bottom: BorderSide(
//                                           width: 1.0,
//                                           color: Color(0xffF4F5F7)),
//                                     ),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 20.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             GestureDetector(
//                                               onTap: () {
//                                                 // Get.to("jh");
//                                                 Emp_user_transaction_details(ctx: context);
//                                                 print("object");
//                                               },
//                                               child: Image.asset(
//                                                 transactionList[index].image,
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               width: 10,
//                                             ),
//                                             Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           bottom: 3.0),
//                                                   child: Text(
//                                                     transactionList[index].title,
//                                                     style: const TextStyle(
//                                                       color:
//                                                           Color(0xff000000),
//                                                       fontFamily: "Outfit",
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                       fontSize: 14,
//                                                     ),
//                                                     textAlign: TextAlign.left,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   transactionList[index].subTitle,
//                                                   style: const TextStyle(
//                                                     color: Color(0xff9D9FAD),
//                                                     fontFamily: "Outfit",
//                                                     fontWeight:
//                                                         FontWeight.w400,
//                                                     fontSize: 10,
//                                                   ),
//                                                   textAlign: TextAlign.left,
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                         const Row(
//                                           children: [
//                                             Text(
//                                               "\$25.5",
//                                               style: TextStyle(
//                                                 color: Color(0xff18C85E),
//                                                 fontFamily: "Outfit",
//                                                 fontWeight: FontWeight.w500,
//                                                 fontSize: 12,
//                                               ),
//                                               textAlign: TextAlign.right,
//                                             ),
//                                           ],
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// List transactionList = [
//   _transactionList("assets/images/g2.png", "Dr.	Jane	N.	Dacks", '02 Mar 222', Colors.grey),
//   _transactionList("assets/images/g2.png", "Dr.	Jane	N.	Dacks", '02 Mar 222', Colors.grey),
//   _transactionList("assets/images/g2.png", "Dr.	Jane	N.	Dacks", '02 Mar 222', Colors.grey),
//   _transactionList("assets/images/g2.png", "Dr.	Jane	N.	Dacks", '02 Mar 222', Colors.grey),
// ];
//
// class _transactionList {
//   final String image;
//   final String title;
//   final String subTitle;
//   final Color color;
//
//   _transactionList(this.image, this.title, this.subTitle, this.color);
// }
