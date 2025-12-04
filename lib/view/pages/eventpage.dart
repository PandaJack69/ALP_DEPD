import 'package:alp_depd/view/widgets/pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/authviewmodel.dart';
// If you have a register page

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
             EventHeader(
              isLoggedIn: authViewModel.isLoggedIn,
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