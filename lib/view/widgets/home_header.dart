import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class HomeHeader extends StatelessWidget {
  final bool isLoggedIn;
  final VoidCallback onLoginPressed;
  final VoidCallback onRegisterPressed;
  final VoidCallback onProfilePressed;
  final VoidCallback? onHomePressed;
  final VoidCallback? onEventPressed;
  final VoidCallback? onCompetitionPressed;
  final VoidCallback? onPengMasPressed;

  const HomeHeader({
    super.key,
    required this.isLoggedIn,
    required this.onLoginPressed,
    required this.onRegisterPressed,
    required this.onProfilePressed,
    this.onHomePressed,
    this.onEventPressed,
    this.onCompetitionPressed,
    this.onPengMasPressed,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width > 800;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 40,
      ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNavbar(isDesktop),
          const SizedBox(height: 60),
          const Text(
            "Find Your Next Experience",
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 16),
          const Text(
            "Discover & Promote\nUpcoming Events",
            style: TextStyle(
              color: Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 40),
          _buildSearchBar(),
        ],
      ),
    );
  }

  // ----------------------------- NAVBAR -----------------------------
  Widget _buildNavbar(bool isDesktop) {
    return Row(
      children: [
        const Text(
          "The Event",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),

        // Desktop navbar links
        if (isDesktop)
          Row(
            children: [
              _navItem("Home", onPressed: onHomePressed),
              _navItem("Event", onPressed: onEventPressed),
              _navItem("Competition", onPressed: onCompetitionPressed),
              _navItem("PengMas", onPressed: onPengMasPressed),
            ],
          ),

        const SizedBox(width: 20),

        // ---------------- LOGIN / PROFILE BUTTON ----------------
        if (isLoggedIn)
          ElevatedButton(
            onPressed: onProfilePressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text("Profile"),
          )
        else
          Row(
            children: [
              // Login Button
              ElevatedButton(
                onPressed: onLoginPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF360C4C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("Log In"),
              ),
              const SizedBox(width: 10),

              // Register Button
              ElevatedButton(
                onPressed: onRegisterPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("Register"),
              ),
            ],
          ),
      ],
    );
  }

  Widget _navItem(String text, {VoidCallback? onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white70, fontSize: 15),
        ),
      ),
    );
  }

  // --------------------------- SEARCH BAR ---------------------------
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFEC83BB).withOpacity(0.6),
            blurRadius: 25,
            spreadRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
        border: GradientBoxBorder(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFEC82B9),
              Color(0xFFB763DD),
            ],
          ),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xFF263238)),
          const SizedBox(width: 10),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search events",
                hintStyle: TextStyle(color: Color(0xFF263238)),
              ),
            ),
          ),
          const Icon(Icons.send, color: Color(0xFF263238)),
        ],
      ),
    );
  }
}