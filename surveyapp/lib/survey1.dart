import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:surveyapp/dashboard_ui.dart';
import 'package:surveyapp/database.dart';

class MyApp extends StatefulWidget {
  static const routeName = '/survey1';
  const MyApp(
  {
    super.key, 
    required this.title, 
    required this.username
  }
  );

  final String title;
  final String username;
  

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String username;
  
  @override
  void initState() {
    super.initState();
    username = widget.username;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // THINGY THAT CONTAINS AND DRAWS THE SURVEY
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Align(
            alignment: Alignment.center,
            child: FutureBuilder<Task>(
              future: initialSurvey(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData &&
                    snapshot.data != null) {
                  final task = snapshot.data!;
                  return SurveyKit(
                    onResult: (SurveyResult result) {
                      // USER FINISHES THE QUIZ
                      print(result.finishReason);
                      final jsonResult = result.toJson();
                      // print the json-formatted results

                      var questions = [
                        "",
                        "How old are you?",
                        "What is your sex?"
                      ];

                      Map <String, dynamic> data = {};

                      for (var i=1; i<questions.length; i++){
                        debugPrint(questions[i] + " " + jsonResult["results"][i]["results"][0]["valueIdentifier"].toString());
                        data[questions[i]] = jsonResult["results"][i]["results"][0]["valueIdentifier"].toString();
                      }

                      Database.updateComplete(username);
                      Database.writeToDB(data, username);

                      //GO TO DASHBOARD
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return DashboardUI( username: username);
                      }));
                    },
                    task: task,
                    showProgress: true,
                    localizations: const {
                      'cancel': 'Cancel',
                      'next': 'Next',
                    },
                    themeData: Theme.of(context).copyWith(
                      primaryColor: Colors.cyan,
                      appBarTheme: const AppBarTheme(
                        color: Colors.white,
                        iconTheme: IconThemeData(
                          color: Colors.cyan,
                        ),
                        titleTextStyle: TextStyle(
                          color: Colors.cyan,
                        ),
                      ),
                      iconTheme: const IconThemeData(
                        color: Colors.cyan,
                      ),
                      textSelectionTheme: const TextSelectionThemeData(
                        cursorColor: Colors.cyan,
                        selectionColor: Colors.cyan,
                        selectionHandleColor: Colors.cyan,
                      ),
                      cupertinoOverrideTheme: const CupertinoThemeData(
                        primaryColor: Colors.cyan,
                      ),
                      outlinedButtonTheme: OutlinedButtonThemeData(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            const Size(150.0, 60.0),
                          ),
                          side: MaterialStateProperty.resolveWith(
                            (Set<MaterialState> state) {
                              if (state.contains(MaterialState.disabled)) {
                                return const BorderSide(
                                  color: Colors.grey,
                                );
                              }
                              return const BorderSide(
                                color: Colors.cyan,
                              );
                            },
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          textStyle: MaterialStateProperty.resolveWith(
                            (Set<MaterialState> state) {
                              if (state.contains(MaterialState.disabled)) {
                                return Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      color: Colors.grey,
                                    );
                              }
                              return Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: Colors.cyan,
                                  );
                            },
                          ),
                        ),
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(
                            Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: Colors.cyan,
                                ),
                          ),
                        ),
                      ),
                      textTheme: const TextTheme(
                        displayMedium: TextStyle(
                          fontSize: 28.0,
                          color: Colors.black,
                        ),
                        headlineSmall: TextStyle(
                          fontSize: 24.0,
                          color: Colors.black,
                        ),
                        bodyMedium: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                        titleMedium: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                      inputDecorationTheme: const InputDecorationTheme(
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      colorScheme: ColorScheme.fromSwatch(
                        primarySwatch: Colors.cyan,
                      )
                          .copyWith(
                            onPrimary: Colors.white,
                          )
                          .copyWith(background: Colors.white),
                    ),
                    surveyProgressbarConfiguration: SurveyProgressConfiguration(
                      backgroundColor: Colors.white,
                    ),
                  );
                }
                return const CircularProgressIndicator.adaptive();
              },
            ),
          ),
        ),
      ),
    );
  }

  // THE SURVEY TO BE DISPLAYED
  Future<Task> initialSurvey() {
    var surveyQuestions = NavigableTask(
      id: TaskIdentifier(),
      steps: [
        InstructionStep(
          title: 'Welcome to HealthScreen',
          text: 'Please answer all questions to the best of your ability.',
          buttonText: 'Let\'s go!',
        ),
        QuestionStep(
          title: 'How old are you?',
          answerFormat: const IntegerAnswerFormat(
            hint: 'Please enter your age',
          ),
          isOptional: false,
        ),
        QuestionStep(
          title: 'What is your sex?',
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Male', value: 'Male'),
              TextChoice(text: 'Female', value: 'Female'),
              TextChoice(text: 'Other', value: 'Other'),
            ],
            defaultSelection: TextChoice(text: 'Other', value: 'Other'),
          ),
        ),
        CompletionStep(
          stepIdentifier: StepIdentifier(id: '321'),
          text: 'Thanks for answering',
          title: 'Done!',
          buttonText: 'Submit survey',
        ),
      ],
    );
    return Future.value(surveyQuestions);
  }
}
