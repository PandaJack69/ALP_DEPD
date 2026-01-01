import 'package:alp_depd/view/pages/admin/event_register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewmodel/database_provider.dart'; // Pakai Provider Baru
import 'package:alp_depd/view/widgets/pages.dart';
import 'package:alp_depd/view/widgets/footer_section.dart';

class Eventpage extends StatelessWidget {
  const Eventpage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Listen ke DatabaseProvider (Pengganti AuthViewModel)
    final dbProvider = context.watch<DatabaseProvider>();
    
    return Scaffold(
      backgroundColor: Colors.white,
      
      // Tombol Add Event: Hanya muncul jika user login & role-nya organizer atau admin
      floatingActionButton: (dbProvider.isLoggedIn && 
          (dbProvider.currentUser?.role == 'organizer' || dbProvider.currentUser?.role == 'admin')) 
        ? FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EventRegisterPage()),
              );
            },
            label: const Text('Add Event', style: TextStyle(color: Colors.white)),
            icon: const Icon(Icons.add, color: Colors.white),
            backgroundColor: const Color(0xFF3F054F),
          )
        : null, // Hilang jika user biasa / belum login
        
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 2. Pass status login ke Header
            EventHeader(isLoggedIn: dbProvider.isLoggedIn),

            // Section Event (Pastikan widget ini nanti mengambil data dari provider juga)
            const RecentEventsSection(),
            const LastChanceEventsSection(),
            
            // Footer Section
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}