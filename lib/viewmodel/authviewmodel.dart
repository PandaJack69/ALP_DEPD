import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  // --- State Variables ---
  bool _isLoading = false;
  String? _errorMessage;
  bool _isLoggedIn = false;
  
  // Simple in-memory storage for registered users (Email -> Password)
  // We pre-populate it with the user from your design.
  final Map<String, String> _registeredUsers = {
    'jonas_kahnwald@gmail.com': 'password123', 
  };

  // --- Getters ---
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _isLoggedIn;

  // --- Login Logic ---
  Future<bool> login(String email, String password) async {
    _setLoading(true);
    
    // Simulate network delay (1.5 seconds)
    await Future.delayed(const Duration(milliseconds: 1500));

    if (_registeredUsers.containsKey(email)) {
      if (_registeredUsers[email] == password) {
        // Success
        _isLoggedIn = true;
        _errorMessage = null;
        _setLoading(false);
        return true;
      } else {
        // Wrong Password
        _errorMessage = "Invalid password.";
        _setLoading(false);
        return false;
      }
    } else {
      // User not found
      _errorMessage = "User not found. Please register first.";
      _setLoading(false);
      return false;
    }
  }

  // --- Register Logic ---
  Future<bool> register(String email, String password) async {
    _setLoading(true);
    await Future.delayed(const Duration(milliseconds: 1500));

    if (_registeredUsers.containsKey(email)) {
      _errorMessage = "Email already exists.";
      _setLoading(false);
      return false;
    }

    // Save user
    _registeredUsers[email] = password;
    _isLoggedIn = true; // Auto login after register
    _errorMessage = null;
    _setLoading(false);
    return true;
  }

  // --- Logout ---
  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  // Helper to update UI
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}