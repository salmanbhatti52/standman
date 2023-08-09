
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSingin = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  Future googleLogin() async {
    try {
      final googleUser = await googleSingin.signIn();
      if (googleUser == null) {
        return;
      } else {

      }
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print("Hello ${e.toString()}");
    }
    notifyListeners();
  }

  Future logout() async {
    await googleSingin.disconnect();
    FirebaseAuth.instance.signOut();
  }
}

Future<UserCredential?>signInwithGoogle() async {

  final googleSingin = GoogleSignIn();
  try{

    final GoogleSignInAccount? googleuser = await googleSingin.signIn();

    final GoogleSignInAuthentication? googhleAuth = await googleuser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googhleAuth?.accessToken,
      idToken: googhleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);

  } on FirebaseAuthException catch(e){
    print("hello ${e.toString()}");
  } catch(_){
    print("hello2 ${_.toString()}");
  }
}