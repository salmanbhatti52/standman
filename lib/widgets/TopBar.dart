import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class TopBar extends StatelessWidget {
  final String text;
  final String imagePath;
  final double? width;
  final Function onTap;

  TopBar(
      {Key? key,
      required this.text,
      required this.imagePath,
      this.width,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            onTap;
          },
          child: SvgPicture.asset(
            imagePath,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontFamily: "Outfit",
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        Text("            "),
      ],
    );
  }
}

Widget Bar(String text, String imagePath, Color color, Color color1,
    Function onTapped) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () {
          onTapped();
          print("object");
        },
        child: SvgPicture.asset(
          imagePath,
          color: color,
        ),
      ),
      Text(
        text,
        style: TextStyle(
          fontFamily: "Outfit",
          fontWeight: FontWeight.w500,
          color: color1,
          fontSize: 18,
        ),
      ),
      Text("            "),
    ],
  );
}

class TopBar2 extends StatelessWidget {
  final String text;
  final String imagePath;
  final String? color;
  final double? width;

  TopBar2(
      {Key? key,
      required this.text,
      required this.imagePath,
      this.color,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: SvgPicture.asset(
              imagePath,
            ),
          ),
          SizedBox(
            width: width,
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Outfit",
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class StandManAppBar1 extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color titlecolor;
  final Color iconcolor;
  final Color bgcolor;

  const StandManAppBar1(
      {Key? key,
      this.title = "",
      required this.bgcolor,
      required this.titlecolor,
      required this.iconcolor})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgcolor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        // <-- SEE HERE
        statusBarIconBrightness: Brightness.light,
        //<-- For Android SEE HERE (dark icons)
        statusBarBrightness:
            Brightness.light, //<-- For iOS SEE HERE (dark icons)
      ),
      leading: TextButton(
        onPressed: () => Navigator.pop(context),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.04,
            ),
            SvgPicture.asset(
              "assets/images/left.svg",
              color: iconcolor,
            ),
          ],
        ),
      ),
      leadingWidth: 80,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: "Outfit",
          fontWeight: FontWeight.w500,
          color: titlecolor,
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
      // backgroundColor: globalOrangeColors,
      elevation: 0.0,
      centerTitle: true,
    );
  }
}

class MyPreferredSizeAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Color? color;

  const MyPreferredSizeAppBar({Key? key, this.color}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(0);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(0.0),
      child: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: color,
          // <-- SEE HERE
          statusBarIconBrightness: Brightness.light,
          //<-- For Android SEE HERE (dark icons)
          statusBarBrightness:
              Brightness.light, //<-- For iOS SEE HERE (dark icons)
        ),
        elevation: 0,
      ),
    );
  }
}

Widget paymentBar(String imagePath, Color color, String text, Color color1,
    String imagePath2, Function onTapped, Function onTapped1) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GestureDetector(
        onTap: () {
          onTapped();
          print("object");
        },
        child: SvgPicture.asset(
          imagePath,
          color: color,
        ),
      ),
      Text(
        text,
        style: TextStyle(
          fontFamily: "Outfit",
          fontWeight: FontWeight.w500,
          color: color1,
          fontSize: 18,
        ),
      ),
      GestureDetector(
        onTap: () {
          onTapped1();
          print("object2");
        },
        child: SvgPicture.asset(
          imagePath2,
        ),
      ),
    ],
  );
}
