import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import '../../viewmodel/authviewmodel.dart'; // Import ViewModel
// import 'loginpage.dart';
// import 'profilepage.dart'; 
import 'package:alp_depd/view/widgets/pages.dart';
import 'package:alp_depd/view/widgets/footer_section.dart';
import 'event_register.dart';

class Eventpage extends StatelessWidget {
  const Eventpage({super.key});


  @override
  Widget build(BuildContext context) {
    // 1. Listen to the AuthViewModel
    // 'watch' means if the login state changes, this widget rebuilds immediately
    final authViewModel = context.watch<AuthViewModel>();
    
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EventRegisterPage()),
          );
        },
        label: const Text('Add Event', style: TextStyle(color: Colors.white)),
        icon: const Icon(Icons.add, color: Colors.white),
        backgroundColor: const Color(0xFF3F054F),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 2. Pass the isLoggedIn state to the Header Section
            EventHeader(isLoggedIn: authViewModel.isLoggedIn),

            // Featured Events Section
            // const FeaturedEventsSection(),
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
