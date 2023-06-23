import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'Pages/Authentication/Customer/google_signin.dart';
import 'Pages/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Utils/remove_scroll_glow.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey =
  'pk_test_51MV6RqJ1o3iGht9r3wtt4ZaiaiDqA0hcF03p9Kj0FhU3qgPnZI03BKzFxTniYSGjGklLrRqIhEcM5O67OWiJBEyS00xupHP2IW';
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
    );
    return ChangeNotifierProvider(
        create: (_) => GoogleSignInProvider(), child: GetMaterialApp(
      useInheritedMediaQuery: true,
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      builder: (context, child) {
        DevicePreview.appBuilder;
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!);
      },
      debugShowCheckedModeBanner: false,
      title: 'StandMan',
      theme: ThemeData(primarySwatch: Colors.blue),
      scrollBehavior: MyBehavior(),
      home: SplashScreen(),
    ),);
  }
}
