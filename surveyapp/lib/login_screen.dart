import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:surveyapp/initial_survey.dart';
import 'package:surveyapp/database.dart';
import 'package:surveyapp/dashboard_ui.dart';
import 'package:surveyapp/email_sender.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surveyapp/app_colors.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/auth';
  String name = "a";
  bool completed = false;

  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');

    name = data.name;

    return Future.delayed(loginTime).then((_) async {
      bool? foundName = await Database.findUser(data.name);
      bool? validate = await Database.validateUser(data.name, data.password);
      bool? comp = await Database.userCompleted(data.name);

      if (comp == true) {
        completed = true;
      }

      if (foundName != true) {
        return 'User not exists';
      }
      if (validate != true) {
        return 'Password does not match';
      }

      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      Database.addUser(data.name, data.password);
      name = data.name.toString();
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) async {
      bool? foundName = await Database.findUser(name);
      if (foundName != true) {
        return 'User not exists';
      }
      //convert to string
      Future<String> pw = Database.getPassword(name);
      String p = await pw;
      bool emailSent = await sendEmailInBackground(name, p);
      if (emailSent) {
        return "Email sent";
      }
      return "Email failed to send";
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'HealthScreen',
      // title: 'HEALTHSCREEN',
      theme: LoginTheme(
        titleStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        bodyStyle: const TextStyle(
          color: Colors.black,
        ),
        textFieldStyle: const TextStyle(
          color: Colors.black,
        ),
        buttonStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        cardTheme: CardTheme(
          elevation: 5,
          margin: const EdgeInsets.only(top: 15),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        inputTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        buttonTheme: LoginButtonTheme(
          splashColor: Colors.black,
          backgroundColor: AppColors.primaryColor,
          highlightColor: Colors.black,
          elevation: 9.0,
          highlightElevation: 6.0,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
      onLogin: _authUser,
      onSignup: _signupUser,
      onRecoverPassword: _recoverPassword,
      onSubmitAnimationCompleted: () {
        if (!completed) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return InitialSurvey(title: "random", username: name);
          }));
        } else {
          Database.setCompleteScreenings(name);
          Database.setFutureScreenings(name);
          Future.delayed(loginTime).then((_) async {
            //change to dashboard
            String realName = await Database.getName(name);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DashboardUI(username: name, name: realName);
            }));
          });
        }
      },
    );
  }
}
