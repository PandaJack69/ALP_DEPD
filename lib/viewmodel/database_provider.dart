// File: lib/viewmodel/database_provider.dart

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/custom_models.dart';

class DatabaseProvider extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  // --- STATE VARIABLES ---
  UserProfile? _currentUser;
  List<EventData> _events = [];
  bool _isLoading = false;

  // --- GETTERS ---
  UserProfile? get currentUser => _currentUser;
  List<EventData> get events => _events;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _currentUser != null;

  // ================== AUTH SECTION ==================

  // 1. Cek User saat aplikasi dibuka
  Future<void> loadUser() async {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      await _fetchProfile(user.id);
    }
  }

  // 2. Login
  Future<String?> login(String email, String password) async {
    _setLoading(true);
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      
      if (response.user != null) {
        await _fetchProfile(response.user!.id);
        _setLoading(false);
        return null; // Sukses (null error)
      }
      return "Login gagal";
    } on AuthException catch (e) {
      _setLoading(false);
      return e.message;
    } catch (e) {
      _setLoading(false);
      return e.toString();
    }
  }

  // 3. Register & Buat Profile
  Future<String?> register(String email, String password, String name, String role, String institution) async {
    _setLoading(true);
    try {
      // A. Buat Akun Auth
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      // B. Simpan ke Tabel Profiles
      if (response.user != null) {
        await _supabase.from('profiles').insert({
          'id': response.user!.id,
          'email': email,
          'full_name': name,
          'role': role.toLowerCase(), // admin, organizer, mahasiswa, siswa
          'institution': institution,
        });
        
        await _fetchProfile(response.user!.id); // Load profile setelah regis
        _setLoading(false);
        return null; // Sukses
      }
      return "Register gagal";
    } catch (e) {
      _setLoading(false);
      return e.toString();
    }
  }

  // 4. Logout
  Future<void> logout() async {
    await _supabase.auth.signOut();
    _currentUser = null;
    _events = [];
    notifyListeners();
  }

  // Helper: Ambil data profile dari tabel 'profiles'
  Future<void> _fetchProfile(String userId) async {
    try {
      final data = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();
      
      _currentUser = UserProfile.fromJson(data);
      notifyListeners();
      
      // Setelah dapat user, langsung load event
      fetchAllEvents(); 
    } catch (e) {
      print("Error fetch profile: $e");
    }
  }

  // ================== DATA SECTION (EVENTS) ==================

  // 1. Ambil Semua Event (Untuk Home & Admin)
  Future<void> fetchAllEvents() async {
    try {
      final response = await _supabase
          .from('events')
          .select('*')
          .order('created_at', ascending: false);
      
      _events = (response as List).map((e) => EventData.fromJson(e)).toList();
      notifyListeners();
    } catch (e) {
      print("Error fetching events: $e");
    }
  }

  // 2. Tambah Event Baru (Organizer)
  Future<bool> addEvent({
    required String title,
    required String description,
    required String category,
    required String orgName,
  }) async {
    if (_currentUser == null) return false;

    try {
      await _supabase.from('events').insert({
        'created_by': _currentUser!.id,
        'title': title,
        'description': description,
        'category': category, // event, lomba, pengmas
        'organization_name': orgName,
        'start_reg_date': DateTime.now().toIso8601String(), // Contoh default
      });
      
      await fetchAllEvents(); // Refresh list
      return true;
    } catch (e) {
      print("Error add event: $e");
      return false;
    }
  }

  // 3. Hapus Event (Admin/Organizer)
  Future<void> deleteEvent(String eventId) async {
    try {
      await _supabase.from('events').delete().eq('id', eventId);
      _events.removeWhere((e) => e.id == eventId);
      notifyListeners();
    } catch (e) {
      print("Error delete event: $e");
    }
  }

  // 4. Update Role User (Fitur Admin)
  Future<void> updateUserRole(String email, String newRole) async {
    try {
      // Cari ID berdasarkan email (karena update butuh ID / Unique key)
      // Catatan: Ini cara sederhana, idealnya admin punya list user lengkap
      // Untuk demo ini, kita asumsikan update user yang sedang dilihat
    } catch (e) {
      print("Error update role: $e");
    }
  }

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }
}