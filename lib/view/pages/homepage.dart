import 'package:flutter/material.dart';
import '../widgets/home_header.dart'; // <-- Import your header

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            // 1️⃣ Header Section (gradient + navbar + hero + search bar)
            HomeHeader(),

            // 2️⃣ Placeholder for upcoming sections
            SizedBox(height: 40),

            // Example placeholder text
            Text(
              "Featured Events Section Coming Soon...",
              style: TextStyle(fontSize: 18),
            ),

            SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
// test
