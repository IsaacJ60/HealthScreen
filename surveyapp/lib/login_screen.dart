import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:surveyapp/initial_survey.dart';
import 'package:surveyapp/database.dart';
import 'package:surveyapp/dashboard_ui.dart';
import 'package:surveyapp/email_sender.dart';

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
      bool emailSent = sendEmailInBackground(name, "Insert the password here") as bool;
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
      onLogin: _authUser,
      onSignup: _signupUser,
      onRecoverPassword: _recoverPassword,
      onSubmitAnimationCompleted: () {
        if (!completed) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return InitialSurvey(title: "random", username: name);
          }));
        } else {
          //change to dashboard TO DO
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DashboardUI(username: name);
          }));
        }
      },
    );
  }
}
