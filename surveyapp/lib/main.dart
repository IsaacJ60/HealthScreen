import 'package:flutter/material.dart';
import 'package:flutter_survey/flutter_survey.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:surveyapp/dashboard_ui.dart';
import 'package:surveyapp/insights_page.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:surveyapp/login_screen.dart';
import 'package:surveyapp/profile_page.dart';
import 'firebase_options.dart'; // Import the Firebase options file
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:surveyapp/login_screen.dart';
import 'package:surveyapp/database.dart';
import 'package:surveyapp/initial_survey.dart';
import 'package:surveyapp/transition_route_observer.dart';
import 'package:surveyapp/insights_item.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // InsightItemsData.loadArticleText();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Survey Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 40, 144, 255)),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Survey'),

      navigatorObservers: [TransitionRouteObserver()],
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        InitialSurvey.routeName: (context) =>
            const InitialSurvey(title: "Survey 1", username: "alan"),
        DashboardUI.routeName: (context) => DashboardUI(username: "alan", name:""),
        InsightsPage.routeName: (context) => InsightsPage(),
        ProfilePage.routeName: (context) => ProfilePage(username: "alan", name:""),
      },
    );
  }
}
