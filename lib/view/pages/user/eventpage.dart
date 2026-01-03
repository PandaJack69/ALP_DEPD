import 'package:alp_depd/view/pages/admin/event_register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewmodel/database_provider.dart'; 
import 'package:alp_depd/view/widgets/pages.dart';
import 'package:alp_depd/view/widgets/footer_section.dart';

class Eventpage extends StatelessWidget {
  const Eventpage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Listen ke DatabaseProvider
    final dbProvider = context.watch<DatabaseProvider>();
    
    return Scaffold(
      backgroundColor: Colors.white,
      
      // Tombol Add Event
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
        : null,
        
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. HEADER (Dibiarkan di luar agar tetap Full Width)
            EventHeader(isLoggedIn: dbProvider.isLoggedIn),

            // 2. KONTEN TENGAH (Diberi Padding Horizontal)
            Padding(
              // Atur jarak kiri-kanan di sini (misal: 24 atau 30)
              padding: const EdgeInsets.symmetric(horizontal: 120), 
              child: Column(
                children: [
                  const RecentEventsSection(),
                  const LastChanceEventsSection(),
                  const AllEventsSection(),
                ],
              ),
            ),
            
            // 3. FOOTER (Dibiarkan di luar agar tetap Full Width)
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}