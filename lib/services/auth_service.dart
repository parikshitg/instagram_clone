import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models.dart/user_data.dart';
import 'package:provider/provider.dart';

import '../screens/login_screen.dart';
import '../screens/feed_screen.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = Firestore.instance;

  static void signUpUser(
      BuildContext context, String name, String email, String password) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser signedInUser = authResult.user;
      if(signedInUser != null) {
        _firestore.collection('/users').document(signedInUser.uid).setData({
          'name': name,
          'email': email,
          'profileImageurl': '',
        });
        //Navigator.pushNamed(context, FeedScreen.id);
        Provider.of<UserData>(context).currentUserId = signedInUser.uid;
        Navigator.pop(context);
      }

    } catch (e) {
      print(e);
    }
  }


  static void logout() {
    _auth.signOut();
   // Navigator.pushNamed(context, LoginScreen.id);
  }


  static void login(String email,String password) async {
    try {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    //Navigator.pushNamed(context, FeedScreen.id);
    } catch (e) {
      print(e);
    }
  }
}
