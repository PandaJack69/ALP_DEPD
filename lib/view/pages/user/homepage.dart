import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import '../../../viewmodel/authviewmodel.dart'; // Import ViewModel
// import 'loginpage.dart';
// import 'profilepage.dart'; 
import 'package:alp_depd/view/widgets/pages.dart';
import 'package:alp_depd/view/widgets/footer_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    // 1. Listen to the AuthViewModel
    // 'watch' means if the login state changes, this widget rebuilds immediately
    final authViewModel = context.watch<AuthViewModel>();
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 2. Pass the isLoggedIn state to the Header Section
            HomeHeader(isLoggedIn: authViewModel.isLoggedIn),

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


