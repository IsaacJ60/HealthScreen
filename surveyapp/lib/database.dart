import 'dart:collection';

import 'package:firebase_core/firebase_core.dart';
import 'package:surveyapp/screening_data.dart';
import 'firebase_options.dart'; // Import the Firebase options file
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  Database(){ 
    initBase();
  }

  static void initBase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, // Pass the Firebase options
    );
  }

  static Future<void> addUser(String? email, String? password) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection('users').doc(email).set({
        'email': email,
        "completed": false,
        "password": password
      });

      print('User added to Firestore');
    } catch (error) {
      print('Error adding user to Firestore: $error');
    }
  }

  static Future<void> updateComplete(String? email) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection('users').doc(email).update({
        "completed": true
      });
    } catch (error) {
    }
  }

  static Future<bool?> validateUser(String email, String password) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore.collection('users').get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    for (var document in documents) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      
      if (data["email"] == email && data["password"] == password){
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
      if (data["email"] == email){
        return true;
      }
    }
    return false;
  }

  static Future<String> getPassword(String email) async{
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore.collection('users').get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    for (var document in documents) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      if (data["email"] == email){
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
      
      if (data["email"] == email){
        return data["completed"];
      }
    }
    return false;
  }

  static void setFutureScreenings(String email) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> querySnapshot = await firestore.collection('futureScreenings').doc(email).get();
    List <ScreeningData> complete = [];
    Map <String, dynamic> data = {};
    if (querySnapshot.exists){
      data = querySnapshot.data()!;
      for (var key in data.keys){
        ScreeningData? newScreen = ScreeningData(
                                    icon: ScreeningItemsData.data[key]!.icon,
                                    name: ScreeningItemsData.data[key]!.name,
                                    color: ScreeningItemsData.data[key]!.color,
                                    notes: []
                                  );          
        

        List<String> notes = [];
        if (newScreen != null){
          for (dynamic note in data[key]){
            notes.add(note);
          }
          notes = notes.toSet().toList(); //removes duplicates
          for (String note in notes){
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
    DocumentSnapshot<Map<String, dynamic>> querySnapshot = await firestore.collection('completedScreenings').doc(email).get();
    List <ScreeningData> complete = [];
    Map <String, dynamic> data = {};
    if (querySnapshot.exists){
      data = querySnapshot.data()!;
      for (var key in data.keys){
        ScreeningData? newScreen = ScreeningData(
                                    icon: ScreeningItemsData.data[key]!.icon,
                                    name: ScreeningItemsData.data[key]!.name,
                                    color: ScreeningItemsData.data[key]!.color,
                                    notes: []
                                  );          
        

        List<String> notes = [];
        if (newScreen != null){
          for (dynamic note in data[key]){
            notes.add(note);
          }
          notes = notes.toSet().toList(); //removes duplicates
          for (String note in notes){
            newScreen.notes.add(note);
          }
          complete.add(newScreen);
        }
      
      }
    }
    ScreeningItemsData.setCompleteScreenings(complete);
  }

  static void deleteCompletedNote(String email, String screeningName, String noteVal) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
  
    final DocumentReference documentRef = firestore.collection('completedScreenings').doc(email);
    final DocumentSnapshot documentSnapshot = await documentRef.get();

    if (documentSnapshot.exists){
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

      data.forEach((key, value) async {
        // print('$key: $value');
        if (key == screeningName){
          final List<dynamic> array = data[key];
          array.removeWhere((item) => item == noteVal);
          await documentRef.update({screeningName: array});
          ScreeningItemsData.completedItems[ScreeningItemsData.completedIndexFromValue(screeningName)]!.notes.removeWhere((item) => item == noteVal);
        }
      });
    }
    Future.delayed(const Duration(milliseconds: 2250));
  }

  static void deleteFutureNote(String email, String screeningName, String noteVal) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
  
    final DocumentReference documentRef = firestore.collection('futureScreenings').doc(email);
    final DocumentSnapshot documentSnapshot = await documentRef.get();

    if (documentSnapshot.exists){
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

      data.forEach((key, value) async {
        // print('$key: $value');
        if (key == screeningName){
          final List<dynamic> array = data[key];
          array.removeWhere((item) => item == noteVal);
          await documentRef.update({screeningName: array});
          ScreeningItemsData.futureItems[ScreeningItemsData.futureIndexFromValue(screeningName)]!.notes.removeWhere((item) => item == noteVal);
        
        }
      });
    }
    Future.delayed(const Duration(milliseconds: 2250));
  }  

  static void deleteNote(String email, String screeningName, String noteVal){
    deleteFutureNote(email, screeningName, noteVal);
    deleteCompletedNote(email, screeningName, noteVal);
  }

  static void addFutureNote(String email, String screeningName, String note) async{
    FirebaseFirestore firestore = FirebaseFirestore.instance;
  
    final DocumentReference documentRef = firestore.collection('futureScreenings').doc(email);
    final DocumentSnapshot documentSnapshot = await documentRef.get();

    if (documentSnapshot.exists){
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

      data.forEach((key, value) async {
        // print('$key: $value');
        if (key == screeningName){
          final List<dynamic> array = data[key];
          array.add(note);
          await documentRef.update({screeningName: array});
          ScreeningItemsData.futureItems[ScreeningItemsData.futureIndexFromValue(screeningName)]!.notes.add(note);        
        }
      });
    }
  }

  static void addCompleteNote(String email, String screeningName, String note) async{
    FirebaseFirestore firestore = FirebaseFirestore.instance;
  
    final DocumentReference documentRef = firestore.collection('completedScreenings').doc(email);
    final DocumentSnapshot documentSnapshot = await documentRef.get();

    if (documentSnapshot.exists){
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

      data.forEach((key, value) async {
        // print('$key: $value');
        if (key == screeningName){
          // print("#########");
          final List<dynamic> array = data[key];
          array.add(note);
          await documentRef.update({screeningName: array});
          ScreeningItemsData.completedItems[ScreeningItemsData.completedIndexFromValue(screeningName)]!.notes.add(note);        
        }
      });
    }
  }

  static void addNotes(String email, String screeningName, String note){
    addFutureNote(email, screeningName, note);
    addCompleteNote(email, screeningName, note);
  }

  static List<String> getFutureScreenings(Map<String, dynamic> response){
    List<String> ret = [];

    if (response['What is your sex?'] == 'Female'){
      int age = response['How old are you?'];
      if (response['Are you sexually active?'] == 'Yes'){
        if (age < 24){
          //screening for Chlamydia trachomatis and Neisseria gonorrhoeae every 1 year
        }
        else{
          if (response['If you are sexually active, does your partner have an STI or history of STIs?'] == 'Yes'){
            //screening for Chlamydia trachomatis and Neisseria gonorrhoeae every 1 year
          }
        }
      }

      if (age <= 20){

      }

      else if (21 <= age && age <= 29){
        //Papanicolaou test with cytology every 3 years 
      }

      else if (30 <= age && age <= 65){
        //Papanicolaou test with cytology every 3 years
        // Papanicolaou test with high risk testing with cytology every 5 years
      }

    }

    if (response['What is your sex?'] == 'Male'){
      if (response['Do you have a family history of colon cancer?'] == 'Yes'){
        int relativeAge = response['If you answered yes to the previous question, please enter the age that family member was diagnosed with colon cancer.'];
        if (relativeAge < 50){
          //colonoscopy every 5 years
        }
        else if (50 <= relativeAge && relativeAge <= 59){
          if (response['How old are you?'] >= 40){
            //colonoscopy every 5 years
          }
        }
        else if (relativeAge >= 60){
          if (response['How old are you?'] >= 45){
            // Colonscopy every 10 years
            // FOBT every 1 year
            // FIT-DNA test every 3 years
            // Flexible sigmoidoscopy every 5 years
          }
        }
      }
    }

    return ret;
  }

  static void addFutureScreenings(String email, List<String> toAdd) async{
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    for (String s in toAdd){
      firestore.collection('futureScreenings').add(
        {
          s : []
        }
      );
    }
  }

  static void writeToDB(dynamic data, dynamic name) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('first-survey').doc(name).set(data);
  }

  
}