import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Header (Navbar only)
            const _ProfileHeader(),

            // 2. Profile Content
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Section
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
                          color: const Color(0xFF0F172A), // Underline style
                        )
                      ],
                    ),
                    const SizedBox(height: 40),

                    // Avatar & Name Section
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                image: NetworkImage("https://picsum.photos/id/64/200/200"), // Placeholder Avatar
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(color: Colors.deepPurple, width: 3),
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            "Violet Evergarden",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF360C4C),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                            ),
                            child: const Text("Edit Profile", style: TextStyle(color: Colors.white)),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Form Fields
                    _buildLabel("Nama"),
                    _buildTextField("Violet Evergarden"),

                    _buildLabel("Universitas"),
                    _buildTextField("Universitas Ciputra"),

                    _buildLabel("Jurusan"),
                    _buildTextField("Informatika - FSD"),

                    _buildLabel("Angkatan"),
                    _buildTextField("2023"),

                    _buildLabel("No. Telpon"),
                    _buildTextField("082226563528"),

                    _buildLabel("CV"),
                    _buildTextField("...."),

                    _buildLabel("Portfolio"),
                    _buildTextField("...."),

                    const SizedBox(height: 40),

                    // Bottom Buttons (Cancel / Save)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context); // Go back
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF360C4C), width: 2),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          ),
                          child: const Text("Cancel", style: TextStyle(color: Color(0xFF360C4C), fontWeight: FontWeight.bold)),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFC2185B), // Pinkish Red
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

            // 3. Footer
            const _ProfileFooter(),
          ],
        ),
      ),
    );
  }

  // Helper widget for Labels (Pink Color)
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

  // Helper widget for TextFields
  Widget _buildTextField(String initialValue) {
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
        decoration: InputDecoration(
          fillColor: Colors.white,
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

// --- Header for Profile Page ---
class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF0F172A), // Dark Navy Background
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        children: [
          const Text(
            "The Event",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const Spacer(),
          // Navigation Links
          _navLink("Home", context),
          _navLink("Event", context),
          _navLink("Competition", context),
          _navLink("PengMas", context),
          const SizedBox(width: 20),
          // Profile Button (Active State)
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text("Profile", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _navLink(String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextButton(
        onPressed: () {
            if(text == "Home") Navigator.pop(context); // Basic navigation back
        },
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

// --- Footer for Profile Page ---
class _ProfileFooter extends StatelessWidget {
  const _ProfileFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF1E1135),
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
      child: const Center(
        child: Text(
          "© 2025 The Event. All rights reserved",
          style: TextStyle(color: Colors.white54, fontSize: 12),
        ),
      ),
    );
  }
}