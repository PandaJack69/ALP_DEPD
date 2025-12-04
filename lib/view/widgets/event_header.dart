part of 'pages.dart';

class EventHeader extends StatelessWidget {
  final bool isLoggedIn;
  const EventHeader({super.key, required this.isLoggedIn,});

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
          Navbar(isLoggedIn: isLoggedIn, activePage: "Event"),
          const SizedBox(height: 60),
          const Text(
            "AAA Upcoming \n Events",
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
