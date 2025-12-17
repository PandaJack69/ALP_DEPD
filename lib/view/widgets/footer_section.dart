import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF1E1135), // Very dark purple/blue
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
      child: Wrap(
        spacing: 60,
        runSpacing: 40,
        alignment: WrapAlignment.spaceBetween,
        children: [
          // Column 1: Brand & Social
          SizedBox(
            width: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "The Event",
                  style: TextStyle(
                      color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _socialIcon(Icons.camera_alt_outlined),
                    const SizedBox(width: 15),
                    _socialIcon(Icons.facebook),
                    const SizedBox(width: 15),
                    _socialIcon(Icons.close), // Used for X/Twitter
                  ],
                )
              ],
            ),
          ),

          // Column 2: Contact Us
          SizedBox(
            width: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Contact Us",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 15),
                Text("theevent@gmail.com",
                    style: TextStyle(color: Colors.white70, fontSize: 12, height: 2)),
                Text("Universitas Ciputra Citraland",
                    style: TextStyle(color: Colors.white70, fontSize: 12, height: 2)),
                Text("081133112345778890",
                    style: TextStyle(color: Colors.white70, fontSize: 12, height: 2)),
              ],
            ),
          ),

          // Column 3: Subscribe
          SizedBox(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Subscribe",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 10),
                const Text("Enter your email to get notified about newest event",
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
                const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(fontSize: 12),
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.mail_outline, size: 18),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Icon(icon, color: const Color(0xFF1E1135), size: 20),
    );
  }
}