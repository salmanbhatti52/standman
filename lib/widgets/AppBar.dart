import 'package:get/get.dart';
import '../Pages/Drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/cupertino.dart';

class AppBarr extends StatelessWidget {
  const AppBarr({Key? key, required this.text, required this.imagePath})
      : super(key: key);

  final String text;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Get.to(  () => MyDrawer());
            },
            child: SvgPicture.asset("assets/images/menu.svg"),
          ),
          Text(
            text,
            style: TextStyle(
              color: Color(0xffffffff),
              fontFamily: "Outfit",
              fontSize: 18,
              fontWeight: FontWeight.w500,
              // letterSpacing: -0.3,
            ),
            textAlign: TextAlign.center,
          ),
          SvgPicture.asset(
            imagePath,
          ),
        ],
      ),
    );
  }
}
