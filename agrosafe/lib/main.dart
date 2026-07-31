import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'core/services/service_locator.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseAuth? authInstance;
  FirebaseFirestore? firestoreInstance;

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    authInstance = FirebaseAuth.instance;
    firestoreInstance = FirebaseFirestore.instance;
  } catch (e) {
    debugPrint('Firebase initialization notice: $e');
  }

  await initServiceLocator(
    firebaseAuth: authInstance,
    firestore: firestoreInstance,
  );

  runApp(const AgroSafeApp());
}
