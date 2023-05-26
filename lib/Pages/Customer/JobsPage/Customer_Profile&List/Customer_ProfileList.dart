import 'package:flutter/material.dart';

class Customer_ProfileLists extends StatefulWidget {
  @override
  _Customer_ProfileListsState createState() => _Customer_ProfileListsState();
}

class _Customer_ProfileListsState extends State<Customer_ProfileLists> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          child: Container(
            // height: MediaQuery.of(context).size.height * 0.16,
            width: width,
            height: height * 0.62, //88,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: customer_ProfileLists.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.only(top: 20, left: 15),
                    // width: 150,
                    // height: height * 0.1,
                    child: Row(
                      children: [
                        Image.asset(
                          customer_ProfileLists[index].image,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              customer_ProfileLists[index].title,
                              style: const TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontFamily: "Outfit",
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                customer_ProfileLists[index].subTitle,
                                style: const TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: "Outfit",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.star, color: Color(0xffFFDF00), size: 15,),
                                Text(
                                  '4.5',
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontFamily: "Outfit",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
// letterSpacing: -0.3,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}

List customer_ProfileLists = [
  _customer_ProfileLists("assets/images/person.png", "Alex Buckmaster", 'Donec dictum tristique porta. Etiam convallis lorem\nlobortis nulla molestie, nec tincidunt ex ullamcorper.', Colors.grey),
  _customer_ProfileLists("assets/images/person.png", "Alex Buckmaster", 'Donec dictum tristique porta. Etiam convallis lorem\nlobortis nulla molestie, nec tincidunt ex ullamcorper.', Colors.grey),
  _customer_ProfileLists("assets/images/person.png", "Alex Buckmaster", 'Donec dictum tristique porta. Etiam convallis lorem\nlobortis nulla molestie, nec tincidunt ex ullamcorper.', Colors.grey),
  _customer_ProfileLists("assets/images/person.png", "Alex Buckmaster", 'Donec dictum tristique porta. Etiam convallis lorem\nlobortis nulla molestie, nec tincidunt ex ullamcorper.', Colors.grey),
  _customer_ProfileLists("assets/images/person.png", "Alex Buckmaster", 'Donec dictum tristique porta. Etiam convallis lorem\nlobortis nulla molestie, nec tincidunt ex ullamcorper.', Colors.grey),
  _customer_ProfileLists("assets/images/person.png", "Alex Buckmaster", 'Donec dictum tristique porta. Etiam convallis lorem\nlobortis nulla molestie, nec tincidunt ex ullamcorper.', Colors.grey),
];

class _customer_ProfileLists {
  final String image;
  final String title;
  final String subTitle;
  final Color color;

  _customer_ProfileLists(this.image, this.title, this.subTitle, this.color);
}
