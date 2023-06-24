// import 'dart:convert';
// import 'package:get/state_manager.dart';
// import '../Models/get_previous_jobs_Model.dart';
// import 'package:http/http.dart' as http;
// import '../Models/users_profilet_model.dart';
// import '../Pages/Customer/HomePage/HomePage.dart';
// import '../Utils/api_urls.dart';
//
// class ProfileController extends GetxController {
//
//   var isLoading = false.obs;
//   UsersProfileModel usersProfileModel = UsersProfileModel();
//
//   fetchUserProfile() async {
//     String apiUrl = usersProfileApiUrl;
//     try{
//       isLoading.value = true;
//       final response = await http.post(Uri.parse(apiUrl),
//         headers: {"Accept": "application/json"},
//         body: {
//           "users_customers_id": usersCustomersId,
//         },
//       );
//       if(response.statusCode == 200){
//         var result = jsonDecode(response.body);
//         print("response.statusCode ${response.statusCode}");
//         print("response.body ${response.body}");
//         isLoading.value = false;
//       } else{
//         print("Error Fetching Data");
//       }
//     } catch(e){
//       print("Error $e");
//     }
//   }
// }