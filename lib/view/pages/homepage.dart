import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import '../../viewmodel/authviewmodel.dart'; // Import ViewModel
import 'loginpage.dart';
import 'profilepage.dart'; 

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
            HeaderSection(isLoggedIn: authViewModel.isLoggedIn),

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

// ==============================================================================
// 1️⃣ HEADER SECTION (With Login Logic)
// ==============================================================================
class HeaderSection extends StatelessWidget {
  final bool isLoggedIn; // Variable to hold state

  const HeaderSection({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isDesktop = width > 800;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0F172A), // Dark Navy
            Color(0xFF360C4C), // Deep Purple
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 80.0 : 20.0, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Navigation Bar ---
            Row(
              children: [
                const Text(
                  "The Event",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                const Spacer(),
                if (isDesktop) ...[
                  _navLink("Home", isActive: true),
                  _navLink("Event"),
                  _navLink("Competition"),
                  _navLink("PengMas"),
                  const SizedBox(width: 20),
                ],
                
                // --- LOGIC SWITCH: Profile OR Log In ---
                if (isLoggedIn) 
                  // IF LOGGED IN: Show Profile Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfilePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent, // Outline style
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("Profile"),
                  )
                else 
                  // IF LOGGED OUT: Show Log In Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF360C4C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("Log In"),
                  ),
              ],
            ),

            const SizedBox(height: 80),

            // --- Hero Text ---
            const Text(
              "Find Your Next Experience",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Discover & Promote\nUpcoming Events",
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.w900,
                height: 1.2,
              ),
            ),

            const SizedBox(height: 50),

            // --- Search Bar ---
            Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 700),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purpleAccent.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 2,
                    )
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search the event",
                    border: InputBorder.none,
                    icon: const Icon(Icons.search,
                        color: Colors.black87, size: 28),
                    suffixIcon: Transform.rotate(
                      angle: -0.7,
                      child: const Icon(Icons.send, color: Color(0xFF360C4C)),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _navLink(String text, {bool isActive = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 2,
              width: 20,
              color: Colors.white,
            )
        ],
      ),
    );
  }
}

// ==============================================================================
// 2️⃣ FEATURED EVENTS SECTION
// ==============================================================================
class FeaturedEventsSection extends StatelessWidget {
  const FeaturedEventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          const Text(
            "Featured Events",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "This isn't Just an Event, It's the Experience\nEveryone Will Talk About.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, height: 1.5),
          ),
          const SizedBox(height: 50),

          // The Grid of Cards
          Wrap(
            spacing: 30, // Horizontal space between cards
            runSpacing: 40, // Vertical space between lines
            alignment: WrapAlignment.center,
            children: [
              _buildEventCard(
                title: "Leadership 101 | Batch 1",
                tag: "Closing Soon",
                tagColor: Colors.pink,
                imageUrl: "https://picsum.photos/id/1/400/300", 
              ),
              _buildEventCard(
                title: "Hackfest 2025",
                tag: "Closing Soon",
                tagColor: Colors.pink,
                imageUrl: "https://picsum.photos/id/20/400/300",
              ),
              _buildEventCard(
                title: "Anggota Muda",
                tag: "Closing Soon",
                tagColor: Colors.pink,
                imageUrl: "https://picsum.photos/id/36/400/300",
              ),
              // Row 2
              _buildEventCard(
                title: "Leadership 101 | Batch 2",
                tag: "Coming Soon",
                tagColor: Colors.orange,
                imageUrl: "https://picsum.photos/id/48/400/300",
              ),
              _buildEventCard(
                title: "Hackfest 2025",
                tag: "Just New",
                tagColor: Colors.purple,
                imageUrl: "https://picsum.photos/id/60/400/300",
              ),
              _buildEventCard(
                title: "Anggota Muda",
                tag: "Just New",
                tagColor: Colors.purple,
                imageUrl: "https://picsum.photos/id/96/400/300",
              ),
            ],
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildEventCard({
    required String title,
    required String tag,
    required Color tagColor,
    required String imageUrl,
  }) {
    return Container(
      width: 320, // Fixed width for the card
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Area
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.network(
                  imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(height: 200, color: Colors.grey),
                ),
              ),
              // Dark Overlay on image bottom
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                    ),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.access_time, color: Colors.white, size: 14),
                      SizedBox(width: 5),
                      Text("30 days | 15 hours left",
                          style: TextStyle(color: Colors.white, fontSize: 12)),
                    ],
                  ),
                ),
              ),
              // "Apply Now" Badge
              Positioned(
                top: 15,
                right: 15,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Apply Now",
                    style: TextStyle(
                        fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              )
            ],
          ),
          
          // Content Area
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: tagColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "2023-10-30",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Turn Your Passion Into Action,\nJoin the Team Now",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==============================================================================
// 3️⃣ FOOTER SECTION
// ==============================================================================
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