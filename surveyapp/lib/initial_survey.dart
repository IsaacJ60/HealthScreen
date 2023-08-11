import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey/flutter_survey.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:surveyapp/dashboard_ui.dart';
import 'package:surveyapp/database.dart';
import 'package:surveyapp/screening_data.dart';
import 'package:surveyapp/app_colors.dart';

class InitialSurvey extends StatefulWidget {
  static const routeName = '/initial_survey';
  const InitialSurvey({super.key, required this.title, required this.username});

  final String title;
  final String username;

  @override
  _InitialSurveyState createState() => _InitialSurveyState();
}

class _InitialSurveyState extends State<InitialSurvey> {
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
                        "What is your name?",
                        "How old are you?",
                        "What is your sex?",
                        "What is your height (meters)?",
                        "What is your weight (kilograms)?",
                        "Are you sexually active?",
                        "If you are sexually active, does your partner have an STI or history of STIs?",
                        'Do you currently smoke?',
                        'Do you have a family history of osteoporosis?',
                        'Do you have a family history of colon cancer?',
                        'If you answered yes to the previous question, please enter the age that family member was diagnosed with colon cancer.',
                        'Do you have a personal history of fractures?',
                        'Are you premenopausal or postmenopausal?',
                        'If you are postmenopausal, what was your age of menopause?'
                      ];

                      Map<String, dynamic> data = {};

                      for (var i = 1; i < questions.length; i++) {
                        debugPrint(questions[i] +
                            " " +
                            jsonResult["results"][i]["results"][0]
                                    ["valueIdentifier"]
                                .toString());
                        data[questions[i]] = jsonResult["results"][i]["results"]
                                [0]["valueIdentifier"]
                            .toString();
                      }

                      Database.updateComplete(username);
                      Database.writeToDB(data, username);

                      List<String> screenings =
                          Database.getFutureScreenings(data);
                      Database.addFutureScreenings(username, screenings);
                      Database.setFutureScreenings(username);

                      Future.delayed(const Duration(milliseconds: 5000))
                          .then((_) {
                        //change to dashboard
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DashboardUI(
                              username: username,
                              name: data['What is your name?']);
                        }));
                      });

                      //GO TO DASHBOARD
                    },
                    task: task,
                    showProgress: true,
                    localizations: const {
                      'cancel': 'Cancel',
                      'next': 'Next',
                    },
                    themeData: Theme.of(context).copyWith(
                      primaryColor: AppColors.primaryColor,
                      appBarTheme: const AppBarTheme(
                        color: Colors.white,
                        iconTheme: IconThemeData(
                          color: AppColors.primaryColor,
                        ),
                        titleTextStyle: TextStyle(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      iconTheme: const IconThemeData(
                        color: AppColors.primaryColor,
                      ),
                      textSelectionTheme: const TextSelectionThemeData(
                        cursorColor: AppColors.primaryColor,
                        selectionColor: AppColors.primaryColor,
                        selectionHandleColor: AppColors.primaryColor,
                      ),
                      cupertinoOverrideTheme: const CupertinoThemeData(
                        primaryColor: AppColors.primaryColor,
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
                                color: AppColors.primaryColor,
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
                                    color: AppColors.primaryColor,
                                  );
                            },
                          ),
                        ),
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(
                            Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: AppColors.primaryColor,
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
                        primarySwatch: Colors.blueGrey,
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
          title: 'What is your name?',
          answerFormat: const TextAnswerFormat(
            hint: 'Please enter your name',
          ),
        ), // ADDED THIS LINE
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
          ),
        ),
        QuestionStep(
          title: 'What is your height (meters)?',
          answerFormat: const DoubleAnswerFormat(
            hint: 'Height in Meters',
          ),
        ),
        QuestionStep(
          title: 'What is your weight (kilograms)?',
          answerFormat: const DoubleAnswerFormat(
            hint: 'Weight in Kilograms',
          ),
        ),
        QuestionStep(
          title: 'Are you sexually active?',
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Yes', value: 'Yes'),
              TextChoice(text: 'No', value: 'No'),
            ],
          ),
        ),
        QuestionStep(
          title:
              'If you are sexually active, does your partner have an STI or history of STIs?',
          isOptional: true,
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Yes', value: 'Yes'),
              TextChoice(text: 'No', value: 'No'),
              TextChoice(text: 'I don\'t know', value: 'I don\'t know'),
            ],
          ),
        ),
        QuestionStep(
          title: 'Do you currently smoke?',
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Yes', value: 'Yes'),
              TextChoice(text: 'No', value: 'No'),
            ],
          ),
        ),
        QuestionStep(
          title: 'Do you have a family history of osteoporosis?',
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Yes', value: 'Yes'),
              TextChoice(text: 'No', value: 'No'),
              TextChoice(text: 'I don\'t know', value: 'I don\'t know'),
            ],
          ),
        ),
        QuestionStep(
          title: 'Do you have a family history of colon cancer?',
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Yes', value: 'Yes'),
              TextChoice(text: 'No', value: 'No'),
              TextChoice(text: 'I don\'t know', value: 'I don\'t know'),
            ],
          ),
        ),
        QuestionStep(
          title:
              'If you answered yes to the previous question, please enter the age that family member was diagnosed with colon cancer.',
          isOptional: true,
          answerFormat: const IntegerAnswerFormat(
            hint: 'Skip if this does not apply to you.',
          ),
        ),
        QuestionStep(
          title: 'Do you have a personal history of fractures?',
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Yes', value: 'Yes'),
              TextChoice(text: 'No', value: 'No'),
              TextChoice(text: 'I don\'t know', value: 'I don\'t know'),
            ],
          ),
        ),
        QuestionStep(
          title: 'Are you premenopausal or postmenopausal?',
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Premenopausal', value: 'Premenopausal'),
              TextChoice(text: 'Postmenopausal', value: 'Postmenopausal'),
              TextChoice(text: "I don't know", value: "I don't know"),
              TextChoice(text: "I'm a male", value: "I'm a male"),
            ],
          ),
        ),
        QuestionStep(
          title: 'If you are postmenopausal, what was your age of menopause?',
          isOptional: true,
          answerFormat: const IntegerAnswerFormat(
            hint: 'Skip if this does not apply to you.',
          ),
        ),
        QuestionStep(
            title:
                'When was your last screening for chlamydia trachomatis (mm/dd/yyyy)',
            isOptional: true,
            answerFormat:
                TextAnswerFormat(hint: 'Skip if this does not apply to you.')),
        QuestionStep(
            title:
                'When was your last screening for Neisseria gonorrhoeae (mm/dd/yyyy)',
            isOptional: true,
            answerFormat:
                TextAnswerFormat(hint: 'Skip if this does not apply to you.')),
        QuestionStep(
            title:
                'When was your last Papanicolaou test with cytology (mm/dd/yyyy)',
            isOptional: true,
            answerFormat:
                TextAnswerFormat(hint: 'Skip if this does not apply to you.')),
        QuestionStep(
            title: 'When was your last Dexa scan (mm/dd/yyyy)',
            isOptional: true,
            answerFormat:
                TextAnswerFormat(hint: 'Skip if this does not apply to you.')),
        QuestionStep(
            title: 'When was your last colonoscopy (mm/dd/yyyy)',
            isOptional: true,
            answerFormat:
                TextAnswerFormat(hint: 'Skip if this does not apply to you.')),
        QuestionStep(
            title: 'When was your last Flexible sigmoidoscopy (mm/dd/yyyy)',
            isOptional: true,
            answerFormat:
                TextAnswerFormat(hint: 'Skip if this does not apply to you.')),
        QuestionStep(
            title: 'When was your last FIT-DNA test (mm/dd/yyyy)',
            isOptional: true,
            answerFormat:
                TextAnswerFormat(hint: 'Skip if this does not apply to you.')),
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
