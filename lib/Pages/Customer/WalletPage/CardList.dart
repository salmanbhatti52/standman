import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CardList extends StatefulWidget {
  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left : 20,),
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.16,
        width: width,
        height: 160, //height * 0.2,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: cardList.length,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      // height: MediaQuery.of(context).size.height * 0.4,
                      // width: MediaQuery.of(context).size.width * 0.3,
                      width: 150,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                        border: Border.all(color: Color(0xffF2F2F2), width: 1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 20),
                            child: SvgPicture.asset(
                              cardList[index].image,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, bottom: 7.0),
                                  child: Text(
                                    cardList[index].title,
                                    style: TextStyle(
                                      color: Color(0xff242B42),
                                      fontFamily: "Outfit",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                                Text(
                                  cardList[index].subTitle,
                                  style: TextStyle(
                                    color: Color(0xff025188),
                                    fontFamily: "Outfit",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "USD",
                                  style: TextStyle(
                                    color: Color(0xff7E8CA0),
                                    fontFamily: "Outfit",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "29,300.00",
                                  style: TextStyle(
                                    color: Color(0xff2B65EC),
                                    fontFamily: "Outfit",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 110,
                    top: 30,
                    // top: 22,
                    child: Container(
                      width: 17,
                      height: 17,
                      decoration: BoxDecoration(
                        color: Color(0xffF6F7FA),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          width: 1,
                          color: Color(0xffF2F2F2),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    bottom: 20,
                    child: SvgPicture.asset("assets/images/cut.svg"),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

List cardList = [
  _cardList("assets/images/card.svg", "....", '8127'),
  _cardList("assets/images/visa.svg", "....", '8127'),
  _cardList("assets/images/visa.svg", "....", '8127'),
  // _MenuItemList( "assets/images/plusbig.png", "Add Card", '8127'),
  // _MenuItemList( "assets/images/hosp1.png", "Dr. Iyan", 'dentist'),
  // _MenuItemList( "assets/images/hosp2.png", "Dr. Iyan", 'dentist'),
  // _MenuItemList( "assets/images/hosp3.png", "Dr. Iyan", 'dentist'),
];

class _cardList {
  final String image;
  final String title;
  final String subTitle;

  _cardList(
    this.image,
    this.title,
    this.subTitle,
  );
}
