import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthViewModel extends ChangeNotifier {
  // Supabase Instance
  final SupabaseClient _supabase = Supabase.instance.client;

  // State Variables
  bool _isLoading = false;
  String? _errorMessage;
  
  // We check the actual Firebase user to see if they are logged in
  User? _currentUser;

  // Constructor: Check if user is already logged in when app starts
  AuthViewModel() {
    _currentUser = _supabase.auth.currentUser;
    _supabase.auth.onAuthStateChange.listen((data) {
      _currentUser = data.session?.user;
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
      await _supabase.auth.signInWithPassword(
        email: email,
        password: password
      );
      
      _setLoading(false);
      return true; // Success

    } on AuthException catch (e) {
      // Handle specific Supabase errors
      _errorMessage = e.message;
      
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
      // 1. Create the user in Supabase Auth
      final AuthResponse res = await _supabase.auth.signUp(
        email: email,
        password: password
      );

      // 2. Create a row in the 'users' table for this user
      if (res.user != null) {
        await _supabase.from('users').insert({
          'uid': res.user!.id,
          'email': email,
          'name': 'New User', // Placeholder name
          'university': '',
          'major': '',
          'created_at': DateTime.now().toIso8601String(),
        });
      }

      _setLoading(false);
      return true; // Success

    } on AuthException catch (e) {
      _errorMessage = e.message;
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
    await _supabase.auth.signOut();
    notifyListeners();
  }

  // Helper to update UI
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}