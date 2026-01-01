import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthViewModel extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  User? get user => _supabase.auth.currentUser;
  
  // Variabel untuk menyimpan role user yang sedang login
  String? _role;
  String? get role => _role;

  // Cek Session saat aplikasi baru dibuka
  Future<void> loadUserSession() async {
    final session = _supabase.auth.currentSession;
    if (session != null) {
      await _fetchUserRole(session.user.id);
    }
    notifyListeners();
  }

  // --- FUNGSI LOGIN ---
  Future<bool> login(String email, String password) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        // Setelah login auth berhasil, ambil data Role dari tabel 'profiles'
        await _fetchUserRole(response.user!.id);
        return true;
      }
      return false;
    } catch (e) {
      print("Login Error: $e");
      return false;
    }
  }

  // --- FUNGSI AMBIL ROLE DARI SUPABASE ---
  Future<void> _fetchUserRole(String userId) async {
    try {
      final data = await _supabase
          .from('profiles')
          .select('role')
          .eq('id', userId)
          .single();
      
      _role = data['role']; // 'admin', 'organizer', atau 'mahasiswa'
      notifyListeners();
    } catch (e) {
      print("Gagal ambil role: $e");
    }
  }

  // --- FUNGSI REGISTER (Otomatis isi tabel profiles) ---
  Future<bool> register(String email, String password, String name, String role, {String? school}) async {
    try {
      // 1. Buat akun di Auth Supabase
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      // 2. Masukkan data detail ke tabel 'profiles'
      if (response.user != null) {
        await _supabase.from('profiles').insert({
          'id': response.user!.id, // Penting! ID harus sama
          'email': email,
          'full_name': name,
          'role': role, // 'mahasiswa' atau 'siswa'
          'institution': school ?? '-', // Asal sekolah/univ
        });
        return true;
      }
      return false;
    } catch (e) {
      print("Register Error: $e");
      return false;
    }
  }

  Future<void> logout() async {
    await _supabase.auth.signOut();
    _role = null;
    notifyListeners();
  }
}