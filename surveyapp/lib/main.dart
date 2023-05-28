import 'package:flutter/material.dart';
import 'package:flutter_survey/flutter_survey.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:surveyapp/dashboard_ui.dart';
import 'firebase_options.dart'; // Import the Firebase options file
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:surveyapp/login_screen.dart';
import 'package:surveyapp/dashboard_ui.dart';
import 'package:surveyapp/survey1.dart';
import 'package:surveyapp/transition_route_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Pass the Firebase options
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Survey Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Survey'),

      navigatorObservers: [TransitionRouteObserver()],
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        MyHomePage.routeName: (context) => const MyHomePage(title: "Survey 1", username:"alan"),
        DashboardUI.routeName: (context) => DashboardUI(username: "alan")
      },
    );
  }
}

