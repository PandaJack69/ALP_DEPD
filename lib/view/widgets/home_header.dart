import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xFF3F054F), Color(0xFF291F51), Color(0xFF103D52)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNavbar(),
          const SizedBox(height: 60),
          const Text(
            "Find Your Next Experience",
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 16),
          const Text(
            "AAA Discover & Promote\nUpcoming Events",
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 30),
          _buildSearchBar(),
        ],
      ),
    );
  }

  // ----------------------------- NAVBAR -----------------------------
  Widget _buildNavbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "The Event",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        Row(
          children: [
            _navItem("Home"),
            _navItem("Event"),
            _navItem("Competition"),
            _navItem("PengMas"),
          ],
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text("Profile", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _navItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white70, fontSize: 15),
      ),
    );
  }

  // --------------------------- SEARCH BAR ---------------------------
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 55,

      decoration: BoxDecoration(
        color: Colors.white, // ← plain white background
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFEC83BB).withOpacity(0.6), // soft pink glow
            blurRadius: 25, // how soft the glow is
            spreadRadius: 2, // how far the glow spreads
            offset: const Offset(0, 0), // centered glow
          ),
        ],
        border: GradientBoxBorder(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFEC82B9), // pink
              Color(0xFFB763DD), // purple
            ],
          ),
          width: 2,
        ),
      ),

      // decoration: BoxDecoration(
      //   color: Colors.white.withOpacity(0.15),
      //   borderRadius: BorderRadius.circular(40),
      //   border: Border.all(color: Colors.white30),
      // ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xFF263238)),
          const SizedBox(width: 10),
          const Expanded(
            child: TextField(
              style: TextStyle(color: Color(0xFF263238)),
              decoration: InputDecoration(
                hintText: "Search events",
                hintStyle: TextStyle(color: Color(0xFF263238)),
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(Icons.send, color: Color(0xFF263238).withOpacity(0.9)),
        ],
      ),
    );
  }
}
