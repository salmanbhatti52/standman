import 'package:StandMan/Pages/Employee/HomePage/EmpHomePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Models/get_allCaht_Model.dart';
import '../../../Utils/api_urls.dart';
import '../../Customer/HomePage/HomePage.dart';
import 'MessageDetails.dart';
import 'package:http/http.dart' as http;

class EmpMessagesLists extends StatefulWidget {
  @override
  _EmpMessagesListsState createState() => _EmpMessagesListsState();
}

class _EmpMessagesListsState extends State<EmpMessagesLists> {
  GetAllCahtModel getAllChatModel = GetAllCahtModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllChat();
    sharePref();
  }

  sharePref() async {
    prefs = await SharedPreferences.getInstance();
    oneSignalID = prefs!.getString('oneSignalId');
    print("oneSignalId = $oneSignalID");
  }


  bool progress = false;
  bool isInAsyncCall = false;

  getAllChat() async {

setState(() {
  progress = true;
});
    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('empUsersCustomersId');
    print("userId in Prefs is = $usersCustomersId");

    // try {
    String apiUrl = getAllChatApiUrl;
    print("getAllChatApiUrl: $apiUrl");
    final response = await http.post(Uri.parse(apiUrl),
      body: {
        "users_customers_id": usersCustomersId,
      },
      headers: {
        'Accept': 'application/json'
      },
    );
    print('${response.statusCode}');
    print(response);
    if (response.statusCode == 200) {
      final responseString = response.body;
      print("getAllChatResponse: ${responseString.toString()}");
      getAllChatModel = getAllCahtModelFromJson(responseString);
      setState(() {
        progress = false;
      });

    }
    // } catch (e) {
    //   print('Error in getAllChatApi: ${e.toString()}');
    // }
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ModalProgressHUD(
      inAsyncCall: isInAsyncCall,
      opacity: 0.02,
      blur: 0.5,
      color: Colors.transparent,
      progressIndicator: CircularProgressIndicator(
        color: Colors.blue,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.16,
              width: width,
              height: height * 0.80, //88,
              child: progress
                  ? Center(
                child: Lottie.asset(
                  "assets/images/loading.json",
                  height: 50,
                ),
              )
                  : getAllChatModel.status != "success"
                      ? Center(
                          child: Text('no Chat available...',
                              style: TextStyle(fontWeight: FontWeight.bold)))
                      : ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: getAllChatModel.data?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(  () => EmpMessagesDetails(
                                      other_users_customers_id: "${getAllChatModel.data?[index].userData?.usersCustomersId}",
                                      img: "$baseUrlImage${getAllChatModel.data![index].userData!.profilePic}",
                                      name: "${getAllChatModel.data![index].userData!.firstName} ${getAllChatModel.data![index].userData!.lastName}",
                                    ));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(top: 20, left: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          title: Text(
                                            // messagesList[index].title,
                                            "${getAllChatModel.data![index].userData!.firstName} ${getAllChatModel.data![index].userData!.lastName}",
                                            style: const TextStyle(
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                              fontFamily: "Outfit",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                            // textAlign: TextAlign.center,
                                          ),
                                          subtitle: Container(
                                            child: getAllChatModel.data![index].messageType  == "attachment" ? Row(
                                              children: [
                                                ClipRRect(
                                                    borderRadius: BorderRadius.circular(5.0),
                                                    child: Image.asset("assets/images/fade_in_image.jpeg", width: 25, height: 25,)),
                                                SizedBox(width: 5),
                                                Text("Image", style: const TextStyle(
                                                  color: Color.fromRGBO(0, 0, 0, 1),
                                                  fontFamily: "Outfit",
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 15,
                                                ),
                                                ),
                                              ],
                                            ) : Text(
                                              "${ getAllChatModel.data![index].lastMessage}",
                                              style: const TextStyle(
                                                color: Color.fromRGBO(0, 0, 0, 1),
                                                fontFamily: "Outfit",
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                              ),
                                              // textAlign: TextAlign.left,
                                            ),
                                          ),
                                          leading: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(80),
                                            child: FadeInImage(
                                              placeholder: AssetImage(
                                                  "assets/images/fade_in_image.jpeg"),
                                              fit: BoxFit.fill,
                                              height: 35,
                                              width: 35,
                                              image: NetworkImage(
                                                  "$baseUrlImage${getAllChatModel.data![index].userData!.profilePic}"),
                                            ),
                                          ),
                                          trailing: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Text(
                                              // "${getAllChatModel.data![index].time.toString()} ${getAllChatModel.data![index].date.toString()}",
                                              // "${getAllChatModel.data![index].date} ${getAllChatModel.data![index].runtimeType}",
                                              getAllChatModel.data![index].date!,
                                              style: TextStyle(
                                                color: Color(0xffA7A9B7),
                                                fontFamily: "Outfit",
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              // textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  indent: 15,
                                  endIndent: 15,
                                ),
                              ],
                            );
                          }),
            ),
          ),
        ],
      ),
    );
  }
}

List messagesList = [
  _messagesList("assets/images/g2.png", "Maddy Lin",
      'Hai Rizal, I’m on the way to your...', Colors.grey),
  _messagesList("assets/images/g2.png", "Maddy Lin",
      'Hai Rizal, I’m on the way to your...', Colors.grey),
  _messagesList("assets/images/g2.png", "Maddy Lin",
      'Hai Rizal, I’m on the way to your...', Colors.grey),
  _messagesList("assets/images/g2.png", "Maddy Lin",
      'Hai Rizal, I’m on the way to your...', Colors.grey),
  _messagesList("assets/images/g2.png", "Maddy Lin",
      'Hai Rizal, I’m on the way to your...', Colors.grey),
  _messagesList("assets/images/g2.png", "Maddy Lin",
      'Hai Rizal, I’m on the way to your...', Colors.grey),
  _messagesList("assets/images/g2.png", "Maddy Lin",
      'Hai Rizal, I’m on the way to your...', Colors.grey),
  _messagesList("assets/images/g2.png", "Maddy Lin",
      'Hai Rizal, I’m on the way to your...', Colors.grey),
  _messagesList("assets/images/g2.png", "Maddy Lin",
      'Hai Rizal, I’m on the way to your...', Colors.grey),
  _messagesList("assets/images/g2.png", "Maddy Lin",
      'Hai Rizal, I’m on the way to your...', Colors.grey),
];

class _messagesList {
  final String image;
  final String title;
  final String subTitle;
  final Color color;

  _messagesList(this.image, this.title, this.subTitle, this.color);
}
