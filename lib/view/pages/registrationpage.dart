import 'package:alp_depd/view/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/authviewmodel.dart';
import '../widgets/pages.dart'; // Import Navbar & FooterSection
import '../widgets/registrationformcard.dart'; // Import class di atas

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Navbar (Latar belakang gradien sudah ada di dalam Navbar.dart)
            Navbar(
              isLoggedIn: authViewModel.isLoggedIn,
              activePage: "Event",
            ),

            // 2. Konten Form (RegistrationForm yang baru saja dibuat)
            const RegistrationForm(),

            // 3. Footer Section
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}