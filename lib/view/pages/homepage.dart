import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/authviewmodel.dart';
import '../widgets/home_header.dart'; // Import the modified home_header
import '../widgets/featured_events_section.dart';
import '../widgets/footer_section.dart';
import 'loginpage.dart';
import 'profilepage.dart';
import 'registerpage.dart'; // If you have a register page

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeHeader(
              isLoggedIn: authViewModel.isLoggedIn,
              onLoginPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              onRegisterPressed: () {
                // If you have a register page, uncomment this:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
                
                // If you don't have a register page yet, you can:
                // 1. Navigate to LoginPage with a "register" flag
                // 2. Show a snackbar
                // 3. Create RegisterPage later
              },
              onProfilePressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              // Optional: Add navigation callbacks for navbar items
              onHomePressed: () {
                // Scroll to top or reload home
              },
              onEventPressed: () {
                // Navigate to events page
              },
              onCompetitionPressed: () {
                // Navigate to competitions page
              },
              onPengMasPressed: () {
                // Navigate to PengMas page
              },
            ),
            
            // Featured Events Section
            const FeaturedEventsSection(),
            
            // Footer Section
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}