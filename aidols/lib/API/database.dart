import 'dart:core';
import 'dart:io';
import 'package:aidols/Models/user.dart';
import 'package:aidols/Extra/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FbDatabase {
  static readUserdetails(uid) async {
    DocumentSnapshot snapshot =
        await Firestore.instance.collection('userList').document(uid).get();
    var map = snapshot.data;
    if (map != null) MyGlobals.currentUser = User.fromMap(map, uid);
  }

  static writeNewUser(String email) async {
    DocumentReference snapshot = Firestore.instance
        .collection('userList')
        .document(MyGlobals.currentUser.firebaseId);
    MyGlobals.currentUser.emailId = email;
    Map<String, dynamic> emp = {
      "email": email,
    };
    await snapshot.setData(emp);
  }

  static Future<void> updateProfilePictureOfUser(File file) async {
    String url = await uploadFile(file);
    if (url != null) {
      DocumentReference snapshot = Firestore.instance
          .collection("userList")
          .document(MyGlobals.currentUser.firebaseId);
      snapshot.setData({"profilePic": MyGlobals.currentUser.profilePic},
          merge: true);
      MyGlobals.currentUser.profilePic = url;
    }
  }

  static void updateProfileOfUser() {
    DocumentReference snapshot = Firestore.instance
        .collection("userList")
        .document(MyGlobals.currentUser.firebaseId);
    snapshot.setData(MyGlobals.currentUser.toMap(), merge: true);
  }

  static Future<String> uploadFile(File file) async {
    if (file != null) {
      FirebaseStorage storage =
          FirebaseStorage(storageBucket: 'gs://aidols-83e07.appspot.com/');
      String filePathCover = "Profiles/" +
          '${file.path.split('/').last}' +
          DateTime.now().toString();
      StorageUploadTask uploadTask =
          storage.ref().child(filePathCover).putFile(file);
      var dowUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      return dowUrl;
    }
    return null;
  }
}
