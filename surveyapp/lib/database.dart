import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Import the Firebase options file
import 'package:cloud_firestore/cloud_firestore.dart';

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
        print("PASS");
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

  static void writeToDB(dynamic data, dynamic name) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('first-survey').doc(name).set(data);
  }
}
