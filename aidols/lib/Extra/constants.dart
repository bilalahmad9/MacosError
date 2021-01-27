import 'package:aidols/Models/user.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/src/widgets/framework.dart';

class Constants {
  static const String appName = 'Aidols';
  static const String logoTag = 'near.huscarl.loginsample.logo';
  static const String titleTag = 'near.huscarl.loginsample.title';

  static Duration get loginTime =>
      Duration(milliseconds: timeDilation.ceil() * 2250);
}

class MyGlobals {
  static User currentUser = new User();
  static BuildContext myContext;
}
