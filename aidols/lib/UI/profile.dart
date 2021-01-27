import 'dart:io';

import 'package:aidols/API/database.dart';
import 'package:aidols/Extra/constants.dart';
import 'package:aidols/widgets/profile_tile.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'package:aidols/widgets/common_divider.dart';
import 'package:aidols/widgets/common_scaffold.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  static final routeName = '/profile';
  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static var deviceSize;

  //Column1
  Widget profileColumn() => Container(
        height: deviceSize.height * 0.30,
        child: FittedBox(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ProfileTile(
                  title: MyGlobals.currentUser.profileName ?? "Name Not Set",
                  subtitle: MyGlobals.currentUser.profession ?? "",
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.chat),
                        color: Colors.black,
                        onPressed: () {},
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: new BorderRadius.all(
                                  new Radius.circular(40.0)),
                              border: new Border.all(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            child: InkWell(
                              onTap: () async {
                                File image = await FilePicker.getFile(
                                    type: FileType.image);
                                setState(() {
                                  FbDatabase.updateProfilePictureOfUser(image);
                                });
                              },
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    MyGlobals.currentUser.profilePic ?? ""),
                                foregroundColor: Colors.black,
                                radius: 30.0,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            color: Colors.green[600],
                            onPressed: () {
                              setState(() {
                                MyGlobals.currentUser.followersCount++;
                              });
                            },
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.call),
                        color: Colors.black,
                        onPressed: () {},
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );

  //column2
  Widget followColumn(Size deviceSize) => Container(
        height: deviceSize.height * 0.13,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ProfileTile(
              title: "${MyGlobals.currentUser.postsCount ?? 0}",
              subtitle: "Posts",
            ),
            ProfileTile(
              title: "${MyGlobals.currentUser.followersCount ?? 0}",
              subtitle: "Followers",
            ),
            ProfileTile(
              title: "${MyGlobals.currentUser.commentsCount ?? 0}",
              subtitle: "Comments",
            ),
            ProfileTile(
              title: "${MyGlobals.currentUser.followingsCount ?? 0}",
              subtitle: "Following",
            )
          ],
        ),
      );

  //column3
  Widget descColumn() => Container(
        height: deviceSize.height * 0.13,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              MyGlobals.currentUser.des ?? "Bio Not Giver",
              textAlign: TextAlign.justify,
              style: GoogleFonts.roboto(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ),
      );

  //column4
  Widget accountColumn() => Padding(
        padding: const EdgeInsets.only(right: 10.0, left: 10.0),
        child: FittedBox(
          fit: BoxFit.fill,
          child: Container(
            height: deviceSize.height * 0.3,
            child: Row(
              children: <Widget>[
                FittedBox(
                  child: Column(
                    children: <Widget>[
                      ProfileTile(
                        title: "Website",
                        subtitle: MyGlobals.currentUser.webS ?? "",
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ProfileTile(
                        title: "Phone",
                        subtitle: MyGlobals.currentUser.number ?? "",
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      // ProfileTile(
                      //   title: "YouTube",
                      //   subtitle: MyGlobals.currentUser.youT ?? "",
                      // ),
                    ],
                  ),
                ),
                SizedBox(width: 100),
                FittedBox(
                  fit: BoxFit.cover,
                  child: Column(
                    children: <Widget>[
                      ProfileTile(
                        title: "Location",
                        subtitle: MyGlobals.currentUser.city ?? "",
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ProfileTile(
                        title: "Email",
                        subtitle: MyGlobals.currentUser.emailId ?? "",
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      // ProfileTile(
                      //   title: "Facebook",
                      //   subtitle: MyGlobals.currentUser.facB ?? "",
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget bodyData() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          profileColumn(),
          CommonDivider(),
          followColumn(deviceSize),
          CommonDivider(),
          descColumn(),
          CommonDivider(),
          accountColumn()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController profileName = new TextEditingController(),
        des = new TextEditingController(),
        number = new TextEditingController(),
        profession = new TextEditingController(),
        city = new TextEditingController();
    var user = MyGlobals.currentUser;
    profileName.text = user.profileName == null || user.profileName == ""
        ? null
        : user.profileName;
    des.text = user.des == null || user.des == "" ? null : user.des;
    number.text = user.number == null || user.number == "" ? null : user.number;
    city.text = user.city == null || user.city == "" ? null : user.city;
    profession.text = user.profession == null || user.profession == ""
        ? null
        : user.profession;
    deviceSize = MediaQuery.of(context).size;
    return CommonScaffold(
        appTitle: Constants.appName,
        bodyData: bodyData(),
        showFAB: true,
        showDrawer: true,
        click: () {
          Alert(
              context: context,
              title: "Setting",
              content: Column(
                children: <Widget>[
                  TextField(
                    controller: profileName,
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_circle),
                      labelText: 'Enter Name',
                    ),
                    maxLength: 15,
                  ),
                  TextField(
                    controller: number,
                    decoration: InputDecoration(
                      icon: Icon(Icons.call),
                      labelText: 'Enter Number',
                    ),
                    maxLength: 15,
                  ),
                  TextField(
                    controller: city,
                    decoration: InputDecoration(
                      icon: Icon(Icons.location_city),
                      labelText: 'Enter City Name',
                    ),
                    maxLength: 15,
                  ),
                  TextField(
                    controller: profession,
                    decoration: InputDecoration(
                      icon: Icon(Icons.work),
                      labelText: 'Enter Profession',
                    ),
                    maxLength: 15,
                  ),
                  TextField(
                    controller: des,
                    decoration: InputDecoration(
                      icon: Icon(Icons.description),
                      labelText: 'BIO',
                    ),
                    maxLength: 180,
                    maxLines: 5,
                  ),
                ],
              ),
              buttons: [
                DialogButton(
                  onPressed: () {
                    if (profileName.text == null ||
                        des.text == null ||
                        number.text == null ||
                        profession.text == null ||
                        city.text == null) {
                    } else {
                      try {
                        setState(() {
                          MyGlobals.currentUser.profileName = profileName.text;
                          MyGlobals.currentUser.des = des.text;
                          MyGlobals.currentUser.number = number.text;
                          MyGlobals.currentUser.city = city.text;
                          MyGlobals.currentUser.profession = profession.text;
                          FbDatabase.updateProfileOfUser();
                          Navigator.pop(context);
                        });
                      } catch (e) {
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Text(
                    "Update",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ]).show();
        });
  }
}
