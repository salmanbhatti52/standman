import '../Utils/api_urls.dart';
import '../widgets/TopBar.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/system_settings_Model.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class TermsandConditions extends StatefulWidget {
  const TermsandConditions({Key? key}) : super(key: key);

  @override
  State<TermsandConditions> createState() => _TermsandConditionsState();
}

class _TermsandConditionsState extends State<TermsandConditions> {
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
    print("responseSettingApi $responseString");
    print("status Code systemSettingApi: ${response.statusCode}");
    print("in 200 systemSettingApi");
    if (response.statusCode == 200) {
      systemSettingsModel = systemSettingsModelFromJson(responseString);
      print('systemSettingsModel status: ${systemSettingsModel.status}');
      print(
          'getAllSignaturesModel length: ${systemSettingsModel.data!.length}');
      setState(() {
        loading = false;
      });
    }
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
      appBar: StandManAppBar1(
        title: "Term & Conditions",
        bgcolor: Colors.white,
        titlecolor: Colors.black,
        iconcolor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: loading
          ? Center(
              child: Lottie.asset(
                "assets/images/loading.json",
                height: 50,
              ),
            )
          : systemSettingsModel.data == null
              ? Center(
                  child: Text("No history"),
                )
              : ModalProgressHUD(
                  inAsyncCall: loading,
                  opacity: 0.02,
                  blur: 0.5,
                  color: Colors.transparent,
                  progressIndicator:
                      CircularProgressIndicator(color: Colors.blue),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: SingleChildScrollView(
                        physics: ScrollPhysics(),
                        child: Column(
                          children: [
                            Text(
                              "${systemSettingsModel.data?[17].description}",
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
