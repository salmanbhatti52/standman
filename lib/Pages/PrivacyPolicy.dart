import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../Models/system_settings_Model.dart';
import '../Utils/api_urls.dart';
import 'package:http/http.dart' as http;

import '../widgets/TopBar.dart';

class PrivacyPolicy extends StatefulWidget {
  PrivacyPolicy({
    Key? key,
  }) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  SystemSettingsModel systemSettingsModel = SystemSettingsModel();

  bool loading = false;

  systemSettingApi() async {
    setState(() {
      loading = true;
    });
    String apiUrl = system_settingsModelApiUrl;
    print("api: $apiUrl");
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
      },
    );
    final responseString = response.body;
    print("responsesystemSettingApi $responseString");
    print("status Code systemSettingApi: ${response.statusCode}");
    if (response.statusCode == 200) {
      systemSettingsModel = systemSettingsModelFromJson(responseString);
      print('systemSettingsModel status: ${systemSettingsModel.status}');
      print('getAllSignaturesModel length: ${systemSettingsModel.data!.length}');
      setState(() {
        loading = false;
      });
    }
    // } catch (e) {
    //   print('Something went wrong = ${e.toString()}');
    //   return null;
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    systemSettingApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // drawer: MyDrawer(),
      // appBar: AppBar(
      //   toolbarHeight: height * 0.10,
      //   backgroundColor: Color(0xfffffff),
      //   elevation: 0,
      //   centerTitle: true,
      //   iconTheme: IconThemeData(
      //     color: Colors.black,
      //   ),
      //   title: Padding(
      //     padding: const EdgeInsets.only(top: 0.0),
      //     child: Text(
      //       "Privacy Policy",
      //       // "${systemSettingsModel.data?[20].type}",
      //       style: TextStyle(
      //         color: Color(0xff000000),
      //         fontFamily: "Outfit",
      //         fontSize: 18,
      //         fontWeight: FontWeight.w500,
      //         // letterSpacing: -0.3,
      //       ),
      //       textAlign: TextAlign.center,
      //     ),
      //   ),
      // ),
      appBar: StandManAppBar1(title: "Privacy Policy",bgcolor: Colors.white, titlecolor: Colors.black, iconcolor: Colors.black,),
      body: loading
          ? Center(
        child: Lottie.asset(
          "assets/images/loading.json",
          height: 50,
        ),
      )
          // ? Container(color: Colors.white, width: double.infinity, height: double.infinity, child: Center(child: CircularProgressIndicator(color: Colors.blueAccent)))
          : systemSettingsModel.data == null
              ? Center(child: Text("No history"))
              : ModalProgressHUD(
                  inAsyncCall: loading,
                  opacity: 0.02,
                  blur: 0.5,
                  color: Colors.transparent,
                  progressIndicator:
                      CircularProgressIndicator(color: Colors.blue),
                  child:
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: SingleChildScrollView(
                        physics: ScrollPhysics(),
                        child: Column(
                          children: [
                            Text(
                              "${systemSettingsModel.data?[23].description}",
                              //   "Pellentesque suscipit fringilla libero eu ullamcorper. Cras risus eros, faucibus sit amet augue id, tempus pellentesque eros. In imperdiet tristique tincidunt. Integer lobortis lorem lorem, id accumsan arcu tempor id. Suspendisse vitae accumsan massa. Duis porttitor, mauris et faucibus sollicitudin, tellus sem tristique risus, nec gravida velit diam aliquet enim. Curabitur eleifend ligula quis convallis interdum. Sed vitae condimentum urna, nec suscipit purus."
                              //
                              //   "Pellentesque suscipit fringilla lib\n\nPellentesque suscipit fringilla libero eu ullamcorper. Cras risus eros, faucibus sit amet augue id, tempus pellentesque eros. In imperdiet tristique tincidunt. Integer lobortis lorem lorem, id accumsan arcu tempor id. Suspendisse vitae accumsan massa. Duis porttitor, mauris et faucibus sollicitudin, tellus sem tristique risus, nec gravida velit diam aliquet enim. Curabitur eleifend ligula quis convallis interdum. Sed vitae condimentum urna, nec suscipit purus."
                              //
                              //   "Pellentesque suscipit fringilla lib\n\nero eu ullamcorper. Cras risus eros, faucibus sit amet augue id, tempus pellentesque eros. In imperdiet tristique tincidunt. Integer lobortis lorem lorem, id accumsan arcu tempor id. Suspendisse vitae accumsan massa. Duis porttitor, mauris et faucibus sollicitudin, tellus sem tristique risus, nec gravida velit diam aliquet enim. Curabitur eleifend ligula quis convallis interdum. Sed vitae condimentum urna, nec suscipit purus."
                              //
                              // "Pellentesque suscipit fringilla libero eu ullamcorper. Cras risus eros, faucibus sit amet augue id, tempus pellentesque eros. In imperdiet tristique tincidunt. Integer lobortis lorem lorem, id accumsan arcu tempor id. Suspendisse vitae accumsan massa. Duis porttitor, mauris et faucibus sollicitudin, tellus sem tristique risus, nec gravida velit diam aliquet enim. Curabitur eleifend ligula quis convallis interdum. Sed vitae condimentum urna, nec suscipit purus.Pellentesque suscipit fringilla libero eu ullamcorper. Cras risus eros, faucibus sit amet augue id, tempus pellentesque eros. In imperdiet tristique tincidunt. Integer lobortis lorem lorem, id accumsan arcu tempor id. Suspendisse vitae accumsan massa. Duis porttitor, mauris et faucibus sollicitudin, tellus sem tristique risus, nec gravida velit diam aliquet enim. Curabitur eleifend ligula quis convallis interdum. Sed vitae condimentum urna, nec suscipit purus."
                              //
                              // "Pellentesque suscipit fringilla libero eu\n\n ullamcorper. Cras risus eros, faucibus sit amet augue id, tempus pellentesque eros. In imperdiet tristique tincidunt. Integer lobortis lorem lorem, id accumsan arcu tempor id. Suspendisse vitae accumsan massa. Duis porttitor, mauris et faucibus sollicitudin, tellus sem tristique risus, nec gravida velit diam aliquet enim. Curabitur eleifend ligula quis convallis interdum. Sed vitae condimentum urna, nec suscipit purus.Pellentesque suscipit fringilla libero eu ullamcorper. Cras risus eros, faucibus sit amet augue id, tempus pellentesque eros. In imperdiet tristique tincidunt. Integer lobortis lorem lorem, id accumsan arcu tempor id. Suspendisse vitae accumsan massa. Duis porttitor, mauris et faucibus sollicitudin, tellus sem tristique risus, nec gravida velit diam aliquet enim. Curabitur eleifend ligula quis convallis interdum. Sed vitae condimentum urna, nec suscipit purus.",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Outfit",
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }
}
