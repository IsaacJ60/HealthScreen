import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:surveyapp/survey1.dart';
import 'package:surveyapp/database.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
  static const routeName = '/auth';
  String name = "a";

  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    name = data.name;
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    Database.validateUser(data.name, data.password);
    return Future.delayed(loginTime).then((_) async{
      bool? foundName = await Database.findUser(data.name);
      bool? validate = await Database.validateUser(data.name, data.password);

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
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return "hmm";
    });
  }

  String getName(){
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'HealthScreen',
      onLogin: _authUser,
      onSignup: _signupUser,
      onRecoverPassword: _recoverPassword,
      onSubmitAnimationCompleted: () {
        
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MyHomePage(title: "random");
        }));
      },
    );
  }
}
