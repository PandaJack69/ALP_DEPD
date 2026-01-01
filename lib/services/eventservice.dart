import 'package:supabase_flutter/supabase_flutter.dart';

class EventService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // 1. AMBIL SEMUA EVENT (Untuk Halaman Home User & Admin)
  Future<List<Map<String, dynamic>>> getAllEvents() async {
    try {
      final response = await _supabase
          .from('events')
          .select('*, profiles(full_name)') // Join supaya tau nama pembuatnya
          .order('created_at', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print("Error get events: $e");
      return [];
    }
  }

  // 2. AMBIL EVENT KHUSUS ORGANIZER (Hanya yg dia buat)
  Future<List<Map<String, dynamic>>> getMyEvents() async {
    try {
      final userId = _supabase.auth.currentUser!.id;
      final response = await _supabase
          .from('events')
          .select()
          .eq('created_by', userId); // Filter by ID sendiri
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      return [];
    }
  }

  // 3. TAMBAH EVENT BARU (Create)
  Future<bool> createEvent({
    required String title,
    required String description,
    required String category, // 'event', 'lomba', 'pengmas'
    required DateTime date,
    required String posterUrl,
    // Parameter lain sesuai kebutuhan form kamu...
  }) async {
    try {
      final userId = _supabase.auth.currentUser!.id;
      await _supabase.from('events').insert({
        'created_by': userId,
        'title': title,
        'description': description,
        'category': category,
        'event_date': date.toIso8601String(),
        'poster_url': posterUrl,
        // Isi kolom lain sesuai tabel database kamu
      });
      return true;
    } catch (e) {
      print("Error create event: $e");
      return false;
    }
  }

  // 4. DAFTAR EVENT (User Register ke Event)
  Future<bool> registerToEvent(String eventId, String division) async {
    try {
      final userId = _supabase.auth.currentUser!.id;
      await _supabase.from('registrations').insert({
        'user_id': userId,
        'event_id': eventId,
        'chosen_division': division,
        'status': 'pending',
      });
      return true;
    } catch (e) {
      print("Error registration: $e"); // Mungkin error karena sudah daftar (Unique constraint)
      return false;
    }
  }
}