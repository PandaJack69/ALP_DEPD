import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/authviewmodel.dart';
import '../widgets/pages.dart'; 
import 'homepage.dart'; 

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Access the ViewModel
    final authViewModel = context.watch<AuthViewModel>();
    
    // 2. Logic: Dynamic Name from Email
    // Default to "GUEST" if null, otherwise clean up the email string
    String displayName = "GUEST";
    String email = "";
    
    if (authViewModel.userEmail != null) {
      email = authViewModel.userEmail!;
      // Take part before '@', replace dots/underscores with space, uppercase
      if (email.contains('@')) {
        displayName = email.split('@')[0]
            .replaceAll(RegExp(r'[._]'), ' ')
            .toUpperCase();
      } else {
        displayName = email;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= HEADER (Navbar Only) =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF3F054F),
                    Color(0xFF291F51),
                    Color(0xFF103D52),
                  ],
                ),
              ),
              child: AppNavbar(
                isLoggedIn: authViewModel.isLoggedIn,
                
                // --- FIX: Explicit Navigation to Home ---
                onHomePressed: () {
                  Navigator.pushReplacement(
                    context, 
                    MaterialPageRoute(builder: (context) => const HomePage())
                  );
                },
                // Placeholders for other pages (Add similar logic when you create those pages)
                onEventPressed: () {}, 
                onCompetitionPressed: () {},
                onPengMasPressed: () {},

                // Login/Register shouldn't be clicked here (since we are logged in), 
                // but we add safety navigation just in case.
                onLoginPressed: () {}, 
                onRegisterPressed: () {},
                
                // Already on Profile
                onProfilePressed: () {}, 
              ),
            ),

            // ================= PROFILE CONTENT =================
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Profile Section",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        Container(
                          width: 120,
                          height: 4,
                          color: const Color(0xFF0F172A),
                        )
                      ],
                    ),
                    const SizedBox(height: 40),

                    // Avatar & Dynamic Name
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                image: NetworkImage("https://picsum.photos/id/64/200/200"),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(color: Colors.deepPurple, width: 3),
                            ),
                          ),
                          const SizedBox(height: 15),
                          
                          // --- DYNAMIC NAME DISPLAYED HERE ---
                          Text(
                            displayName, 
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          
                          const SizedBox(height: 10),
                          
                          // --- LOGOUT BUTTON ---
                          TextButton.icon(
                            onPressed: () async {
                              await authViewModel.logout();
                              if (context.mounted) {
                                // Navigate back to Login or Home after logout
                                Navigator.pushReplacement(
                                  context, 
                                  MaterialPageRoute(builder: (context) => const HomePage())
                                );
                              }
                            },
                            icon: const Icon(Icons.logout, color: Colors.red),
                            label: const Text("Log Out", style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Forms (Read-only Email, Dynamic Name)
                    _buildLabel("Email"), 
                    _buildTextField(email, enabled: false), // Show actual email

                    _buildLabel("Nama Lengkap"),
                    _buildTextField(displayName), // Pre-fill with dynamic name

                    _buildLabel("Universitas"),
                    _buildTextField("Universitas Ciputra"),

                    _buildLabel("Jurusan"),
                    _buildTextField("Informatika - FSD"),

                    _buildLabel("No. Telpon"),
                    _buildTextField("082226563528"),

                    const SizedBox(height: 40),

                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            // Cancel goes back to Home
                            Navigator.pushReplacement(
                              context, 
                              MaterialPageRoute(builder: (context) => const HomePage())
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF360C4C), width: 2),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          ),
                          child: const Text("Cancel", style: TextStyle(color: Color(0xFF360C4C), fontWeight: FontWeight.bold)),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Save Logic would go here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFC2185B),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                          ),
                          child: const Text("Save", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            // ================= FOOTER =================
            const FooterSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 15.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFFC2185B),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildTextField(String initialValue, {bool enabled = true}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: TextFormField(
        initialValue: initialValue,
        enabled: enabled,
        decoration: InputDecoration(
          fillColor: enabled ? Colors.white : Colors.grey[200],
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.black12),
          ),
        ),
      ),
    );
  }
}