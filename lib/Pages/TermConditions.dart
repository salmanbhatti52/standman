import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../Models/system_settings_Model.dart';
import '../Utils/api_urls.dart';
import 'Drawer.dart';
import 'package:http/http.dart' as http;

class TermsandConditions extends StatefulWidget {
  const TermsandConditions({Key? key}) : super(key: key);

  @override
  State<TermsandConditions> createState() => _TermsandConditionsState();
}

class _TermsandConditionsState extends State<TermsandConditions> {
  SystemSettingsModel systemSettingsModel = SystemSettingsModel();

  bool loading = false;

  systemSettingApi() async {
    // try {
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
    print("in 200 systemSettingApi");
    if (response.statusCode == 200) {
      systemSettingsModel = systemSettingsModelFromJson(responseString);
      setState(() {});
      print('systemSettingsModel status: ${systemSettingsModel.status}');
      print(
          'getAllSignaturesModel length: ${systemSettingsModel.data!.length}');
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    systemSettingApi();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        toolbarHeight: height * 0.10,
        backgroundColor: Color(0xfffffff),
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Text(
            // "${systemSettingsModel.data?[17].type}",
            "Terms & Conditions",
            style: TextStyle(
              color: Color(0xff000000),
              fontFamily: "Outfit",
              fontSize: 18,
              fontWeight: FontWeight.w500,
              // letterSpacing: -0.3,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator(color: Colors.blueAccent))
          : systemSettingsModel.data?[17].type != "terms_text"
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
                              // "Pellentesque suscipit fringilla libero eu ullamcorper. Cras risus eros, faucibus sit amet augue id, tempus pellentesque eros. In imperdiet tristique tincidunt. Integer lobortis lorem lorem, id accumsan arcu tempor id. Suspendisse vitae accumsan massa. Duis porttitor, mauris et faucibus sollicitudin, tellus sem tristique risus, nec gravida velit diam aliquet enim. Curabitur eleifend ligula quis convallis interdum. Sed vitae condimentum urna, nec suscipit purus."
                              //
                              //     "Pellentesque suscipit fringilla lib\n\nPellentesque suscipit fringilla libero eu ullamcorper. Cras risus eros, faucibus sit amet augue id, tempus pellentesque eros. In imperdiet tristique tincidunt. Integer lobortis lorem lorem, id accumsan arcu tempor id. Suspendisse vitae accumsan massa. Duis porttitor, mauris et faucibus sollicitudin, tellus sem tristique risus, nec gravida velit diam aliquet enim. Curabitur eleifend ligula quis convallis interdum. Sed vitae condimentum urna, nec suscipit purus."
                              //
                              //     "Pellentesque suscipit fringilla lib\n\nero eu ullamcorper. Cras risus eros, faucibus sit amet augue id, tempus pellentesque eros. In imperdiet tristique tincidunt. Integer lobortis lorem lorem, id accumsan arcu tempor id. Suspendisse vitae accumsan massa. Duis porttitor, mauris et faucibus sollicitudin, tellus sem tristique risus, nec gravida velit diam aliquet enim. Curabitur eleifend ligula quis convallis interdum. Sed vitae condimentum urna, nec suscipit purus."
                              //
                              //     "Pellentesque suscipit fringilla libero eu ullamcorper. Cras risus eros, faucibus sit amet augue id, tempus pellentesque eros. In imperdiet tristique tincidunt. Integer lobortis lorem lorem, id accumsan arcu tempor id. Suspendisse vitae accumsan massa. Duis porttitor, mauris et faucibus sollicitudin, tellus sem tristique risus, nec gravida velit diam aliquet enim. Curabitur eleifend ligula quis convallis interdum. Sed vitae condimentum urna, nec suscipit purus.Pellentesque suscipit fringilla libero eu ullamcorper. Cras risus eros, faucibus sit amet augue id, tempus pellentesque eros. In imperdiet tristique tincidunt. Integer lobortis lorem lorem, id accumsan arcu tempor id. Suspendisse vitae accumsan massa. Duis porttitor, mauris et faucibus sollicitudin, tellus sem tristique risus, nec gravida velit diam aliquet enim. Curabitur eleifend ligula quis convallis interdum. Sed vitae condimentum urna, nec suscipit purus."
                              //
                              //     "Pellentesque suscipit fringilla libero eu\n\n ullamcorper. Cras risus eros, faucibus sit amet augue id, tempus pellentesque eros. In imperdiet tristique tincidunt. Integer lobortis lorem lorem, id accumsan arcu tempor id. Suspendisse vitae accumsan massa. Duis porttitor, mauris et faucibus sollicitudin, tellus sem tristique risus, nec gravida velit diam aliquet enim. Curabitur eleifend ligula quis convallis interdum. Sed vitae condimentum urna, nec suscipit purus.Pellentesque suscipit fringilla libero eu ullamcorper. Cras risus eros, faucibus sit amet augue id, tempus pellentesque eros. In imperdiet tristique tincidunt. Integer lobortis lorem lorem, id accumsan arcu tempor id. Suspendisse vitae accumsan massa. Duis porttitor, mauris et faucibus sollicitudin, tellus sem tristique risus, nec gravida velit diam aliquet enim. Curabitur eleifend ligula quis convallis interdum. Sed vitae condimentum urna, nec suscipit purus.",
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
