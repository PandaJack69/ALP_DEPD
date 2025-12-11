import 'package:alp_depd/view/widgets/pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/authviewmodel.dart';
import 'loginpage.dart';
import 'profilepage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to Auth State
    final authViewModel = context.watch<AuthViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeHeader(
              isLoggedIn: authViewModel.isLoggedIn,
              
              // 1. Navigate to Login Page (Default Mode)
              onLoginPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(startInRegisterMode: false),
                  ),
                );
              },

              // 2. Navigate to Login Page (Register Mode)
              onRegisterPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(startInRegisterMode: true),
                  ),
                );
              },

              // 3. Navigate to Profile Page
              onProfilePressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
            ),

            // Featured Events Section (Your Cards)
            const FeaturedEventsSection(),

            // Footer Section
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}