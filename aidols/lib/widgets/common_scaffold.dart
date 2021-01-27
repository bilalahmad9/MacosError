import 'package:aidols/widgets/common_drawer.dart';
import 'package:flutter/material.dart';

class CommonScaffold extends StatelessWidget {
  final appTitle;
  final Widget bodyData;
  final showFAB;
  final showDrawer;
  final backGroundColor;
  final actionFirstIcon;
  final scaffoldKey;
  final showBottomNav;
  final floatingIcon;
  final centerDocked;
  final elevation;
  final click;

  CommonScaffold(
      {this.appTitle,
      this.bodyData,
      this.showFAB = false,
      this.showDrawer = false,
      this.backGroundColor,
      this.actionFirstIcon = Icons.edit,
      this.scaffoldKey,
      this.showBottomNav = false,
      this.centerDocked = false,
      this.click,
      this.floatingIcon,
      this.elevation = 4.0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey != null ? scaffoldKey : null,
      backgroundColor: backGroundColor != null ? backGroundColor : null,
      appBar: AppBar(
        elevation: elevation,
        backgroundColor: Colors.grey[800],
        title: Text(appTitle),
        actions: <Widget>[
          SizedBox(
            width: 5.0,
          ),
          IconButton(
            onPressed: click,
            icon: Icon(actionFirstIcon),
          ),
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.more_vert),
          // )
        ],
      ),
      drawer: showDrawer ? CommonDrawer() : null,
      body: bodyData,
      // floatingActionButton: showFAB
      //     ? CustomFloat(
      //         builder: centerDocked
      //             ? Text(
      //                 "5",
      //                 style: TextStyle(color: Colors.white, fontSize: 10.0),
      //               )
      //             : null,
      //         icon: floatingIcon,
      //         qrCallback: () {},
      //       )
      //      : null,
      // floatingActionButtonLocation: centerDocked
      //     ? FloatingActionButtonLocation.centerDocked
      //     : FloatingActionButtonLocation.endFloat,
      // bottomNavigationBar: showBottomNav ? myBottomBar() : null,
    );
  }
}
