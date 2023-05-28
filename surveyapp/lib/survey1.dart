import 'package:flutter/material.dart';
import 'package:flutter_survey/flutter_survey.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Import the Firebase options file
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:surveyapp/database.dart';
import 'package:surveyapp/dashboard_ui.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/survey1'; 
  const MyHomePage(
    {
      super.key, 
      required this.title, 
      required this.username
    }
    );

  final String title;
  final String username;

  String getUsername(){
    return username;
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String username;
  
  @override
  void initState() {
    super.initState();
    username = widget.username;
  }

  
  final _formKey = GlobalKey<FormState>();
  List<QuestionResult> _questionResults = [];
  final List<Question> _initialData = [
    Question(
      question: "How old are you?",
      isMandatory: true,
    ),
    Question(
      question: "What height are you?",
      isMandatory: true,
    ),
    Question(
      question: "What is your sex?",
      isMandatory: true,
      answerChoices: const {
        "Male": null,
        "Female": null,
        "Other": null,
      },
    ),
    Question(
      question: "What weight group do you belong in?",
      isMandatory: true,
      answerChoices: const {
        "Weight 1": null,
        "Weight 2": null,
        "OBESE": null,
      },
    ),
    Question(
      question: "Are you sexually active?",
      isMandatory: true,
      answerChoices: const {
        "Yes": null,
        "No": null,
      },
    ),
    Question(
      question: "How often do you smoke?",
      isMandatory: true,
      answerChoices: const {
        "Often": null,
        "Sometimes": null,
        "Almost Never": null,
        "Never": null,
      },
    ),
    Question(
      isMandatory: true,
      question: 'Do you like drinking coffee?',
      answerChoices: {
        "Yes": [
          Question(
              singleChoice: false,
              question: "What are the brands that you've tried?",
              answerChoices: {
                "Nestle": null,
                "Starbucks": null,
                "Coffee Day": [
                  Question(
                    question: "Did you enjoy visiting Coffee Day?",
                    isMandatory: true,
                    answerChoices: {
                      "Yes": [
                        Question(
                          question: "Please tell us why you like it",
                        )
                      ],
                      "No": [
                        Question(
                          question: "Please tell us what went wrong",
                        )
                      ],
                    },
                  )
                ],
              })
        ],
        "No": [
          Question(
            question: "Do you like drinking Tea then?",
            answerChoices: {
              "Yes": [
                Question(
                    question: "What are the brands that you've tried?",
                    answerChoices: {
                      "Nestle": null,
                      "ChaiBucks": null,
                      "Indian Premium Tea": [
                        Question(
                          question: "Did you enjoy visiting IPT?",
                          answerChoices: {
                            "Yes": [
                              Question(
                                question: "Please tell us why you like it",
                              )
                            ],
                            "No": [
                              Question(
                                question: "Please tell us what went wrong",
                              )
                            ],
                          },
                        )
                      ],
                    })
              ],
              "No": null,
            },
          )
        ],
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Survey(
            onNext: (questionResults) {
              _questionResults = questionResults;
            },
            initialData: _initialData),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.cyanAccent, // Background Color
              ),
              child: const Text("Validate"),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Map <String, dynamic> answers = {};

                  for (QuestionResult q in _questionResults){
                    while (q.children.isNotEmpty) {
                      
                      answers[q.question] = q.answers;
                      q = q.children[0];
                    }
                    answers[q.question] = q.answers;
                  }
                  print(username);
                  //WEIRD
                  Database.updateComplete(username);
                  Database.writeToDB(answers, username); 

                  //GO TO DASHBOARD
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DashboardUI( username: username);
                  }));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
