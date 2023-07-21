import 'dart:collection';

import 'package:firebase_core/firebase_core.dart';
import 'package:surveyapp/screening_data.dart';
import 'firebase_options.dart'; // Import the Firebase options file
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Database {
  Database() {
    initBase();
  }

  static void initBase() async {
    await Firebase.initializeApp(
      options:
          DefaultFirebaseOptions.currentPlatform, // Pass the Firebase options
    );
  }

  static Future<void> addUser(String? email, String? password) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore
          .collection('users')
          .doc(email)
          .set({'email': email, "completed": false, "password": password});

      print('User added to Firestore');
    } catch (error) {
      print('Error adding user to Firestore: $error');
    }
  }

  static Future<void> deleteUser(String email) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Delete user document from the 'users' collection
      await firestore.collection('users').doc(email).delete();

      await firestore.collection('first-survey').doc(email).delete();

      // Delete futureScreenings document associated with the user
      await firestore.collection('futureScreenings').doc(email).delete();

      // Delete completedScreenings document associated with the user
      await firestore.collection('completedScreenings').doc(email).delete();

      print('$email deleted from Firestore');
    } catch (error) {
      print('Error deleting $email from Firestore: $error');
    }
  }

  static Future<void> updateComplete(String? email) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore
          .collection('users')
          .doc(email)
          .update({"completed": true});
    } catch (error) {}
  }

  static Future<bool?> validateUser(String email, String password) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore.collection('users').get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    for (var document in documents) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      if (data["email"] == email && data["password"] == password) {
        return true;
      }
    }
    return false;
  }

  static Future<bool?> findUser(String email) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore.collection('users').get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    for (var document in documents) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      if (data["email"] == email) {
        return true;
      }
    }
    return false;
  }

  static Future<String> getPassword(String email) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore.collection('users').get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    for (var document in documents) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      if (data["email"] == email) {
        return data["password"];
      }
    }
    return ' ';
  }

  static Future<bool?> userCompleted(String email) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore.collection('users').get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    for (var document in documents) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      if (data["email"] == email) {
        return data["completed"];
      }
    }
    return false;
  }

  static void setFutureScreenings(String email) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection('futureScreenings').doc(email).get();
    List<ScreeningData> complete = [];
    Map<String, dynamic> data = {};
    if (querySnapshot.exists) {
      data = querySnapshot.data()!;
      for (var key in data.keys) {
        ScreeningData? newScreen = ScreeningData(
            icon: ScreeningItemsData.data[key]!.icon,
            name: ScreeningItemsData.data[key]!.name,
            color: ScreeningItemsData.data[key]!.color,
            notes: []);

        List<String> notes = [];
        if (newScreen != null) {
          for (dynamic note in data[key]) {
            notes.add(note);
          }
          notes = notes.toSet().toList(); //removes duplicates
          for (String note in notes) {
            newScreen.notes.add(note);
          }
          complete.add(newScreen);
        }
      }
    }
    ScreeningItemsData.setFutureScreenings(complete);
  }

  static void setCompleteScreenings(String email) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection('completedScreenings').doc(email).get();
    List<ScreeningData> complete = [];
    Map<String, dynamic> data = {};
    if (querySnapshot.exists) {
      data = querySnapshot.data()!;
      for (var key in data.keys) {
        ScreeningData? newScreen = ScreeningData(
            icon: ScreeningItemsData.data[key]!.icon,
            name: ScreeningItemsData.data[key]!.name,
            color: ScreeningItemsData.data[key]!.color,
            notes: []);

        List<String> notes = [];
        if (newScreen != null) {
          for (dynamic note in data[key]) {
            notes.add(note);
          }
          notes = notes.toSet().toList(); //removes duplicates
          for (String note in notes) {
            newScreen.notes.add(note);
          }
          complete.add(newScreen);
        }
      }
    }
    ScreeningItemsData.setCompleteScreenings(complete);
  }

  static void deleteCompletedNote(
      String email, String screeningName, String noteVal) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    final DocumentReference documentRef =
        firestore.collection('completedScreenings').doc(email);
    final DocumentSnapshot documentSnapshot = await documentRef.get();

    if (documentSnapshot.exists) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;

      data.forEach((key, value) async {
        // print('$key: $value');
        if (key == screeningName) {
          final List<dynamic> array = data[key];
          array.removeWhere((item) => item == noteVal);
          await documentRef.update({screeningName: array});
          ScreeningItemsData
              .completedItems[
                  ScreeningItemsData.completedIndexFromValue(screeningName)]!
              .notes
              .removeWhere((item) => item == noteVal);
        }
      });
    }
    Future.delayed(const Duration(milliseconds: 2250));
  }

  static void deleteFutureNote(
      String email, String screeningName, String noteVal) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    final DocumentReference documentRef =
        firestore.collection('futureScreenings').doc(email);
    final DocumentSnapshot documentSnapshot = await documentRef.get();

    if (documentSnapshot.exists) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;

      data.forEach((key, value) async {
        // print('$key: $value');
        if (key == screeningName) {
          final List<dynamic> array = data[key];
          array.removeWhere((item) => item == noteVal);
          await documentRef.update({screeningName: array});
          ScreeningItemsData
              .futureItems[
                  ScreeningItemsData.futureIndexFromValue(screeningName)]!
              .notes
              .removeWhere((item) => item == noteVal);
        }
      });
    }
    Future.delayed(const Duration(milliseconds: 2250));
  }

  static void deleteNote(String email, String screeningName, String noteVal) {
    deleteFutureNote(email, screeningName, noteVal);
    deleteCompletedNote(email, screeningName, noteVal);
  }

  static void addFutureNote(
      String email, String screeningName, String note) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    final DocumentReference documentRef =
        firestore.collection('futureScreenings').doc(email);
    final DocumentSnapshot documentSnapshot = await documentRef.get();

    if (documentSnapshot.exists) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;

      data.forEach((key, value) async {
        // print('$key: $value');
        if (key == screeningName) {
          final List<dynamic> array = data[key];
          array.add(note);
          await documentRef.update({screeningName: array});
          ScreeningItemsData
              .futureItems[
                  ScreeningItemsData.futureIndexFromValue(screeningName)]!
              .notes
              .add(note);
        }
      });
    }
  }

  static void addCompleteNote(
      String email, String screeningName, String note) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    final DocumentReference documentRef =
        firestore.collection('completedScreenings').doc(email);
    final DocumentSnapshot documentSnapshot = await documentRef.get();

    if (documentSnapshot.exists) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;

      data.forEach((key, value) async {
        // print('$key: $value');
        if (key == screeningName) {
          // print("#########");
          final List<dynamic> array = data[key];
          array.add(note);
          await documentRef.update({screeningName: array});
          ScreeningItemsData
              .completedItems[
                  ScreeningItemsData.completedIndexFromValue(screeningName)]!
              .notes
              .add(note);
        }
      });
    }
  }

  static List<int> dateToList(String date) {
    List<String> dateParts = date.split('/');
    int month = int.parse(dateParts[0]);
    int day = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);

    return [year, month, day];
  }

  static String FormatDate() {
    return "";
  }

  static void addNotes(String email, String screeningName, String note) {
    addFutureNote(email, screeningName, note);
    addCompleteNote(email, screeningName, note);
  }

  static List<String> getFutureScreenings(Map<String, dynamic> response) {
    List<String> ret = [];
    /*
    DateTime now = DateTime.now();
    DateTime ctNewTime = DateTime(
        now.year + 1, now.month, now.day, now.hour, now.minute, now.second);
   DateTime ngNewTime = DateTime(
        now.year + 1, now.month, now.day, now.hour, now.minute, now.second);
        */

    if (response['What is your sex?'] == 'Female') {
      int age = int.parse(response['How old are you?']);
      if (response['Are you sexually active?'] == 'Yes') {
        if (age < 24) {
          /* if (response[
                  'When was your last screening for chlamydia trachomatis (mm/dd/yyyy)'] !=
              null) {
            String ctTime = response[
                'When was your last screening for chlamydia trachomatis (mm/dd/yyyy)'];
            List<int> ctDateList = dateToList(ctTime);

            DateTime ctNewTime = DateTime(
                ctDateList[0],
                now.month + ctDateList[0],
                now.day + ctDateList[1],
                now.hour,
                now.minute,
                now.second);
          }
           if (response[
                  'When was your last screening for chlamydia trachomatis (mm/dd/yyyy)'] !=
              null) {
            String ngTime = response[
                'When was your last screening for Neisseria gonorrhoeae (mm/dd/yyyy)'];
            List<int> ngDateList = dateToList(ngTime);

            DateTime ngNewTime = DateTime(
                ngDateList[0] + 1,
                ngDateList[1] ,
                ngDateList[2]  ,
                now.hour,
                now.minute,
                now.second);
          }
          DateFormat formatter = DateFormat('mm/dd/yyyy');
          String formattedDate = formatter.format(ctNewTime);
          */
          //screening for Chlamydia trachomatis and Neisseria gonorrhoeae every 1 year
          ret.add('Chlamydia Trachomatis (Every 1 year)');
          ret.add('Neisseria Gonorrhoeae (Every 1 year)');
        } else {
          if (response[
                  'If you are sexually active, does your partner have an STI or history of STIs?'] ==
              'Yes') {
            //screening for Chlamydia trachomatis and Neisseria gonorrhoeae every 1 year
            ret.add('Chlamydia Trachomatis (Every 1 year)');
            ret.add('Neisseria Gonorrhoeae (Every 1 year)');
          }
        }
      }

      if (age <= 20) {
        //self breast exams every 1 month
        ret.add('Self breast exams (Every 1 month)');
      } else if (21 <= age && age <= 29) {
        //Papanicolaou test with cytology every 3 years
        ret.add('Papanicolaou test with cytology (Every 3 years)');
      } else if (30 <= age && age <= 65) {
        //Papanicolaou test with cytology every 3 years
        // Papanicolaou test with high risk testing with cytology every 5 years
        ret.add('Papanicolaou test with cytology (Every 3 years)');
        ret.add(
            'Papanicolaou test high risk testing with cytology (Every 5 years)');
      }

      if (response['Do you have a family history of osteoporosis?'] == 'Yes') {
        // Dexa scan every 2 years
        ret.add('Dexa scan (Every 2 years)');
      } else {
        if (age > 65) {
          // Dexa scan every 2 years
          ret.add('Dexa scan (Every 2 years)');
        }
      }

      if (response['Do you have a family history of colon cancer?'] == 'Yes') {
        int relativeAge = int.parse(response[
            'If you answered yes to the previous question, please enter the age that family member was diagnosed with colon cancer.']);
        if (relativeAge < 50) {
          //colonscopy every 5 years
          ret.add("Colonoscopy (Every 5 years)");
        } else if (50 <= relativeAge && relativeAge <= 59) {
          if (age >= 40) {
            //colonscopy every 5 years
            ret.add("Colonoscopy (Every 5 years)");
          }
        } else if (60 <= relativeAge) {
          if (age >= 40) {
            //colonscopy every 10 years
            ret.add("Colonoscopy (Every 10 years)");
          }
        }
      } else {
        if (age >= 45) {
          // Colonscopy every 10 years
          // FOBT every 1 year
          // FIT-DNA every 3 years
          // Flexible sigmoidoscopy every 5 years
          ret.add("Colonoscopy (Every 10 years)");
          ret.add("FOBT (Every 1 years)");
          ret.add("FIT-DNA (Every 3 years)");
          ret.add("Flexible sigmoidoscopy (Every 5 years)");
        }
      }
    }

    if (response['What is your sex?'] == 'Male') {
      if (response['Do you have a family history of colon cancer?'] == 'Yes') {
        int relativeAge = response[
            'If you answered yes to the previous question, please enter the age that family member was diagnosed with colon cancer.'];
        if (relativeAge < 50) {
          //colonoscopy every 5 years
          ret.add("Colonoscopy (Every 5 years)");
        } else if (50 <= relativeAge && relativeAge <= 59) {
          if (response['How old are you?'] >= 40) {
            //colonoscopy every 5 years
            ret.add("Colonoscopy (Every 5 years)");
          }
        } else if (relativeAge >= 60) {
          if (response['How old are you?'] >= 45) {
            // Colonscopy every 10 years
            // FOBT every 1 year
            // FIT-DNA test every 3 years
            // Flexible sigmoidoscopy every 5 years
            ret.add("Colonoscopy (Every 10 years)");
            ret.add("FOBT (Every 1 years)");
            ret.add("FIT-DNA (Every 3 years)");
            ret.add("Flexible sigmoidoscopy (Every 5 years)");
          }
        }
      }
    }

    return ret;
  }

  static void addFutureScreenings(String email, List<String> toAdd) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Map<String, List> data = {};

    for (String s in toAdd) {
      data[s] = [];
    }
    firestore.collection('futureScreenings').doc(email).set(data);
  }

  static void writeToDB(dynamic data, dynamic name) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('first-survey').doc(name).set(data);
  }

  static Future<String> getName(String email) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot documentSnapshot = await firestore.collection('first-survey').doc(email).get();
    if (documentSnapshot.exists){
      return documentSnapshot['What is your name?'];
    }
    return '';
  }
}
