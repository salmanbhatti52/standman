import 'package:StandMan/Pages/Authentication/Login_tab_class.dart';
import 'package:StandMan/widgets/MyButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../SplashScreen.dart';
import 'google_signin.dart';

class GoogleLoginData extends StatelessWidget {
  const GoogleLoginData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context , snapshot ){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          } else if(snapshot.hasData) {
            return GoogleLoginData2();
          } else if(snapshot.hasError) {
            return Center(child: Text("Something wrong"));
          } else{
           return SplashScreen();
          }
        },
      ),
    );
  }
}

class GoogleLoginData2 extends StatelessWidget {
   GoogleLoginData2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user =   FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Data"),
      ),
      body: Container(
        color: Colors.brown,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 50,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(user.photoURL!),
            ),
            SizedBox(height: 20,),
            Text(
              "Name " + user.displayName!,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Outfit",
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20,),
            Text(
              "Email " + user.email!,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Outfit",
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(onTap: (){
              final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();

            },child: smallButton2("Log Out", Colors.blueAccent, context))
          ],
        ),
      ),
    );
  }
}



