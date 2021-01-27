import 'package:aidols/API/auth.dart';
import 'package:aidols/Extra/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              MyGlobals.currentUser.profileName ?? "",
            ),
            accountEmail: Text(
              MyGlobals.currentUser.emailId ?? "",
              style: GoogleFonts.roboto(),
            ),
            currentAccountPicture: new CircleAvatar(
              backgroundImage:
                  new NetworkImage(MyGlobals.currentUser.profilePic ?? ""),
            ),
          ),
          new ListTile(
            title: Text(
              "Profile",
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
            leading: Icon(
              Icons.person,
              color: Colors.blue,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(),
          new ListTile(
            title: Text(
              "LogOut",
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
            leading: Icon(
              Icons.logout,
              color: Colors.blue,
            ),
            onTap: () {
              Accounts.logoutUser(context);
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
