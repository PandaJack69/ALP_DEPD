import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewmodel/authviewmodel.dart';
import '../../widgets/pages.dart';
import '../../widgets/registrationformcard.dart';
import '../../../model/eventmodel.dart';
import '../../widgets/footer_section.dart';

class RegistrationPage extends StatelessWidget {
  final EventModel event;

  const RegistrationPage({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // NAVBAR
            Navbar(
              isLoggedIn: authViewModel.isLoggedIn,
              activePage: "Event",
            ),

            // FORM
            RegistrationForm(event: event),

            // FOOTER
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}
