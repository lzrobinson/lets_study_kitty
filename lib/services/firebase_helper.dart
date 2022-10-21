import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_study_kitti/models/user.dart';

class FirebaseHelper {
  const FirebaseHelper._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<bool> saveUser(
      {required String email,
      required String password,
      required String name,
      required String major}) async {
    final UserCredential credential = await _auth
        .createUserWithEmailAndPassword(email: email, password: password);

    if (credential.user == null) {
      return false;
    }

    // implementing firestore for users

    var userRef = _db.collection('users').doc(credential.user!.uid);

    final now = DateTime.now();
    final String createdAt = '${now.year}-${now.month}-${now.day}';

    // GENERATE TOKEN
    const String token = '';

    final userModel = UserModel(
        createdAt: createdAt,
        token: token,
        name: name,
        major: major,
        uid: credential.user!.uid);

    await userRef.set(userModel.toJson());

    return true;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> get buildViews =>
      _db.collection('users').snapshots();
}
