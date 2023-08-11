import 'package:flutter/material.dart';
import 'package:surveyapp/app_colors.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:surveyapp/dashboard_ui.dart';
import 'package:surveyapp/insights_page.dart';
import 'firebase_options.dart';
import 'package:surveyapp/login_screen.dart';
import 'package:surveyapp/profile_page.dart';

import 'package:surveyapp/initial_survey.dart';
import 'package:surveyapp/transition_route_observer.dart';
import 'package:google_fonts/google_fonts.dart';

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
        primaryColor: AppColors.primaryColor,
        secondaryHeaderColor: AppColors.accentColor,
        indicatorColor: AppColors.accentColor,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primaryColor,
          secondary: AppColors.secondaryColor,
          tertiary: AppColors.accentColor,
          background: AppColors.backgroundColor,
        ),
        fontFamily: GoogleFonts.poppins().fontFamily,
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Survey'),

      navigatorObservers: [TransitionRouteObserver()],
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        InitialSurvey.routeName: (context) =>
            const InitialSurvey(title: "Survey 1", username: "alan"),
        DashboardUI.routeName: (context) =>
            DashboardUI(username: "alan", name: ""),
        InsightsPage.routeName: (context) => InsightsPage(),
        ProfilePage.routeName: (context) =>
            ProfilePage(username: "alan", name: ""),
      },
    );
  }
}
