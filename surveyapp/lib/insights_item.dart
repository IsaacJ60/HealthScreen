import 'package:flutter/material.dart';
import 'insights_item.dart';
import 'insights_card.dart';

//import 'package:universal_html/html.dart' as html;

class InsightItem {
  final String name;
  final String imagePath;
  final int headerID;
  final List<String> articleTexts;
  final List<String> gifPaths;
  // final List<InsightsCard> cardPages;
  // each box should have a list of gif paths and a txt.file
  //read txt.file and create a article text list
  // txt.file should

  InsightItem({
    required this.name,
    required this.imagePath,
    required this.headerID,
    required this.articleTexts,
    required this.gifPaths,
  });
}

class InsightItemsData {
  static List<InsightItem> items = [
    InsightItem(
      name: 'The Importance of Regular Health Screening',
      imagePath: 'screening1.jpeg',
      headerID: 1,
      articleTexts: [
        'Regular health screening tests are an important part of maintaining your well-being. These tests and exams can help catch potential health issues early when they are typically more manageable. We will discuss the key screening tests that every adult should consider. ',
        '''Why Are Health Screening Tests Important? 
           They can help identify potential health problems before symptoms become noticeable which allows you to be treated promptly. Early detection and treatment can lead to better health
           outcomes. Screening tests can also provide a baseline for future health assessments, which
           allows your doctor to identify and keep track of long term trends and risk factors.''',
        ''' Recommended Health Screening Tests By Age and Gender:
            The specific health screening tests you need can vary, depending on your age, gender, and individual health risks. 
            Here is a general guideline to help you understand which screening tests are relevant to you.
        ''',
        ''' For Adults
-	Blood pressure: get your blood pressure checked regularly, at least every 2 years
-	Cholesterol: checking your cholesterol levels are recommended every 5 years
-	Blood sugar: regular glucose tests starting at age 45 to check for diabetes
-	Colorectal Cancer: colonoscopies or other screening tests are recommended starting at age 45
-	Eye Exam: regular eye exams are essential to monitor vision and eye health
-	Dental check-up: schedule a dental check-up every six months
-	Skin check: a dermatologist should evaluate your skin regularly, especially if you have a history of skin cancer
''',
        ''' For Women
-	Mammograms: women should start getting mammograms starting at age 40-50 to screen for breast cancer
-	Pap smears: screening for cervical cancer is recommended to start at age 21, or earlier depending on risk factors
-	Bone density: consider bone density tests after menopause or if you have risk factors for osteoporosis
''',
        ''' 
For Men
- Prostate Cancer: Prostate-specific antigen (PSA) tests and digital rectal exams are
recommended for men starting at age 50, or earlier depending on risk factors.
''',
        '''
What to Expect During Screening Tests
   During your health screening tests, healthcare professionals with typically perform the following:
-	Blood pressure check: a cuff is placed around your arm to measure blood pressure
-	Cholesterol test: a blood sample is take to measure cholesterol levels
-	Blood sugar test: a blood sample is analyzed to check for elevated blood sugar
-	Colonoscopy: a flexible tube with a camera is used to inspect the colon
-	Mammogram: x-rays of the breasts are taken to detect potential abnormalities
-	Pap smear: A sample of cervical cells is collected for analysis
-	Bone Density Test: this test measures bone density in different parts of the body

'''
      ],
      gifPaths: ["download.gif", "assets/piku.gif"],
    ),
    InsightItem(
      name: 'Understanding Your Cholesterol Levels',
      imagePath: 'general1.png',
      headerID: 2,
      articleTexts: [
        '''High cholesterol is a risk factor for heart disease.
       In this article, we are going to look at the importance of cholesterol levels, what they mean for your health, and how you can manage them. Understanding your cholesterol levels and what they mean can help you to make informed decisions about your dietary and lifestyle choices. ''',
        '''Types of Cholesterol
There are 2 main types of cholesterol:
1.	Low Density Lipoprotein (LDL): LDL is often called "bad" cholesterol, because high LDL levels are associated with an increased risk of heart disease. Atherosclerosis, or the narrowing of the arteries, can occur when LDL cholesterol builds up on the walls of your arteries creating plaques. 
2.	High Density Lipoprotein (HDL): also known as "good" cholesterol. HDL helps to remove LDL cholesterol from the bloodstream, which reduces the risk of atherosclerosis
''',
        '''  
Your Cholesterol Levels
Ideal cholesterol levels depend on individual risk factors. Here are some general guidelines:
-	Total cholesterol: ideally less than 200 mg/dL
-	LDL Cholesterol: normal levels are less than 100 mg/dL. Below 70 mg/dL is recommended for those at high risk for heart disease
-	HDL Cholesterol: for men, levels above 40 md/dL are typically normal. For women, levels above 50 mg/dL are normal
-	Triglycerides: levels should be below 150 mg/dL
''',
        '''Managing Your Cholesterol Levels
If you have high cholesterol, there are several lifestyle changes you can make to naturally lower your cholesterol levels:
-	Diet: eat a health-healthy diet rich in fruits, vegetables, whole grains, lean proteins, and healthy fats. Limit saturated fats, and avoid trans fats
-	Exercise: engage in regular physical activity, aiming for at least 150 minutes of moderate intensity exercise per week
-	Weight Management: losing excess weight can significantly lower LDL cholesterol and raise HDL cholesterol
-	Smoking cessation: quitting smoking can improve your cholesterol level and overall heart health
-	Alcohol: limit your alcohol intake
 ''',
        ''' Medications for High Cholesterol
In some cases, lifestyle changes may not be enough to manage high cholesterol. Your physician may recommend medication such as statins to lower your cholesterol levels. The decision to start medication is based on individual risk factors and discussion with your doctor. 
''',
      ],
      gifPaths: ["download.gif", "piku.gif"],
    ),
  ];
  /*
  static void loadArticleText() {
    for (var item in items) {
      String filePath = 'txt_files/article.txt';

      html.HttpRequest.request(filePath).then((request) {
        var response = request.response;
        if (response is html.Blob) {
          final reader = html.FileReader();
          reader.readAsText(response);
          reader.onLoadEnd.listen((event) {
            item.articleText = reader.result.toString();
          });
        } else {
          print('Invalid response type');
        }
      }).catchError((error) {
        print('Error loading text: $error');
      });
    }
  }
  */
}
