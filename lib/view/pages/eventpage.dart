import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import '../../viewmodel/authviewmodel.dart'; // Import ViewModel
// import 'loginpage.dart';
// import 'profilepage.dart'; 
import 'package:alp_depd/view/widgets/pages.dart';

class Eventpage extends StatelessWidget {
  const Eventpage({super.key});


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
            Navbar(isLoggedIn: isLoggedIn, activePage: "Event"),

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
            children: const [
              EventCard(
                title: "Leadership 101 | Batch 1",
                tag: "Closing Soon",
                tagColor: Colors.pink,
                imageUrl: "https://picsum.photos/id/1/400/300", 
              ),
              EventCard(
                title: "Hackfest 2025",
                tag: "Closing Soon",
                tagColor: Colors.pink,
                imageUrl: "https://picsum.photos/id/20/400/300",
              ),
              EventCard(
                title: "Anggota Muda",
                tag: "Closing Soon",
                tagColor: Colors.pink,
                imageUrl: "https://picsum.photos/id/36/400/300",
              ),
              // Row 2
              EventCard(
                title: "Leadership 101 | Batch 2",
                tag: "Coming Soon",
                tagColor: Colors.orange,
                imageUrl: "https://picsum.photos/id/48/400/300",
              ),
              EventCard(
                title: "Hackfest 2025",
                tag: "Just New",
                tagColor: Colors.purple,
                imageUrl: "https://picsum.photos/id/60/400/300",
              ),
              EventCard(
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