import 'package:aidols/API/auth.dart';
import 'package:aidols/flutter_login.dart';
import 'package:aidols/src/models/login_data.dart';
import 'package:flutter/material.dart';
import '../Extra/constants.dart';
import 'package:aidols/UI/profile.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/auth';

  Future<String> _loginUser(context, LoginData data) {
    return Future.delayed(Constants.loginTime).then((_) async {
      if (await Accounts.signInWithEmail(context, data.name, data.password)) {
        return null;
      } else {
        return 'Email is not Register';
      }
    });
  }

  Future<String> _recoverPassword(context, String name) {
    return Future.delayed(Constants.loginTime).then((_) async {
      if (await Accounts.forgetEmail(context, name)) {
        return null;
      } else {
        return 'Error In Email Reset';
      }
    });
  }

  Future<String> _signUpUser(context, LoginData data) {
    return Future.delayed(Constants.loginTime).then((_) async {
      if (await Accounts.signUpWithEmail(context, data.name, data.password)) {
        return null;
      } else {
        return 'Email is already Register';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    MyGlobals.myContext = context;
    return FlutterLogin(
      title: Constants.appName,
      logo: 'assets/images/logo.png',
      emailValidator: (value) {
        if (!value.contains('@') || !value.endsWith('.com')) {
          return "Email must contain '@' and end with '.com'";
        }
        return null;
      },
      passwordValidator: (value) {
        if (value.isEmpty) {
          return 'Password is empty';
        } else if (value.length < 6) {
          return 'Password is too short';
        }
        return null;
      },
      onLogin: (loginData) {
        return _loginUser(context, loginData);
      },
      onSignup: (loginData) {
        return _signUpUser(context, loginData);
      },
      onSubmitAnimationCompleted: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ProfilePage(),
          ),
        );
      },
      onRecoverPassword: (name) {
        return _recoverPassword(context, name);
      },
    );
  }
}
