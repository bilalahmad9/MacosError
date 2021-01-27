import 'package:aidols/API/database.dart';
import 'package:aidols/Extra/constants.dart';
import 'package:aidols/UI/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aidols/UI/profile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';

class Accounts {
  static Future<bool> signInWithEmail(
      BuildContext context, String email, String password) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      MyGlobals.currentUser.emailId = email;
      MyGlobals.currentUser.firebaseId =
          (await FirebaseAuth.instance.currentUser()).uid;
      await FbDatabase.readUserdetails(MyGlobals.currentUser.firebaseId);
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<bool> forgetEmail(BuildContext context, String email) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<bool> signUpWithEmail(
      BuildContext context, String email, String password) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      MyGlobals.currentUser.firebaseId =
          (await FirebaseAuth.instance.currentUser()).uid;
      MyGlobals.currentUser.emailId = email;
      await FbDatabase.writeNewUser(email);
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<bool> googleLogin() async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      );
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final FirebaseUser authResult =
          await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult;
      if (user != null) {
        DocumentSnapshot snapshot = await Firestore.instance
            .collection('userList')
            .document(user.uid)
            .get();
        if (snapshot.exists) {
          MyGlobals.currentUser.emailId = user.email;
          MyGlobals.currentUser.firebaseId = user.uid;
          await FbDatabase.readUserdetails(MyGlobals.currentUser.firebaseId);
        } else {
          MyGlobals.currentUser.emailId = user.email;
          MyGlobals.currentUser.firebaseId = user.uid;
          await FbDatabase.writeNewUser(user.email);
        }
        Navigator.pushReplacement(
          MyGlobals.myContext,
          MaterialPageRoute(
            builder: (BuildContext context) => ProfilePage(),
          ),
        );
      } else {
        Fluttertoast.showToast(
            msg: "Error: Google Login failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Error: Google Login failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
    return true;
  }

  static Future<bool> checkUser() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      MyGlobals.currentUser.firebaseId = user.uid;
      await FbDatabase.readUserdetails(MyGlobals.currentUser.firebaseId);
      return true;
    }
    return false;
  }

  static logoutUser(context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => LoginScreen(),
      ),
    );
  }
}
