import 'package:flutter/material.dart';

class RatingProfile extends StatefulWidget {
  @override
  _RatingProfileState createState() => _RatingProfileState();
}

class _RatingProfileState extends State<RatingProfile> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      // color: Color(0xff9D9FAD),
      // height: MediaQuery.of(context).size.height * 0.16,
      width: 358,
      // height: 150,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          // physics: BouncingScrollPhysics(),
          itemCount: jobstList.length,
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
                          child: Image.asset("assets/images/g2.png",)),
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
                              'Wade Warren',
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontFamily: "Outfit",
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
// letterSpacing: -0.3,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              'Donec dictum tristique porta. Etiam convallis lorem\nlobortis nulla molestie, nec tincidunt ex ullamcorper.',
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontFamily: "Outfit",
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
// letterSpacing: -0.3,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Row(
                              children: [
                                Icon(Icons.star, color: Color(0xffFFDF00), size: 15,),
                                Text(
                                  '4.5',
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
