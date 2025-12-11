part of 'pages.dart';


class HomeHeader extends StatelessWidget {
  final bool isLoggedIn;
  
  // ADD THESE CALLBACKS
  final VoidCallback? onLoginPressed;
  final VoidCallback? onRegisterPressed;
  final VoidCallback? onProfilePressed;

  const HomeHeader({
    super.key,
    required this.isLoggedIn,
    // ADD THEM TO CONSTRUCTOR
    this.onLoginPressed,
    this.onRegisterPressed,
    this.onProfilePressed,
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
          AppNavbar(
            isLoggedIn: isLoggedIn,
            onHomePressed: () {
              // Default navigation or pass this in too if you want
            },
            onEventPressed: () {},
            onCompetitionPressed: () {},
            onPengMasPressed: () {},

            // PASS THE FUNCTIONS DOWN HERE
            // If the parent (HomePage) provides a function, use it. 
            // Otherwise, do nothing or use a default.
            onLoginPressed: onLoginPressed ?? () {},
            onRegisterPressed: onRegisterPressed ?? () {},
            onProfilePressed: onProfilePressed ?? () {},
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