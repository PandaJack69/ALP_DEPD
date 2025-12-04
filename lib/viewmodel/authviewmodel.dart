import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthViewModel extends ChangeNotifier {
  // Firebase Instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // State Variables
  bool _isLoading = false;
  String? _errorMessage;
  
  // We check the actual Firebase user to see if they are logged in
  User? _currentUser;

  // Constructor: Check if user is already logged in when app starts
  AuthViewModel() {
    _auth.authStateChanges().listen((User? user) {
      _currentUser = user;
      notifyListeners();
    });
  }

  // --- Getters ---
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  
  // If _currentUser is not null, we are logged in
  bool get isLoggedIn => _currentUser != null;
  String? get userEmail => _currentUser?.email;

  // --- Login Logic ---
  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      
      _setLoading(false);
      return true; // Success

    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase errors
      if (e.code == 'user-not-found') {
        _errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        _errorMessage = 'Wrong password provided.';
      } else if (e.code == 'invalid-email') {
        _errorMessage = 'The email address is badly formatted.';
      } else {
        _errorMessage = e.message ?? 'An error occurred';
      }
      
      _setLoading(false);
      return false; // Failed
    } catch (e) {
      _errorMessage = 'System error: ${e.toString()}';
      _setLoading(false);
      return false;
    }
  }

  // --- Register Logic ---
  Future<bool> register(String email, String password) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      // 1. Create the user in Firebase Auth
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );

      // 2. Create a document in Firestore (Database) for this user
      // We use the 'uid' as the document ID so it's easy to find later
      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'email': email,
          'uid': userCredential.user!.uid,
          'name': 'New User', // Placeholder name
          'university': '',
          'major': '',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      _setLoading(false);
      return true; // Success

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        _errorMessage = 'The account already exists for that email.';
      } else {
        _errorMessage = e.message;
      }
      _setLoading(false);
      return false;
    } catch (e) {
      _errorMessage = 'System error: ${e.toString()}';
      _setLoading(false);
      return false;
    }
  }

  // --- Logout ---
  Future<void> logout() async {
    await _auth.signOut();
    notifyListeners();
  }

  // Helper to update UI
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}