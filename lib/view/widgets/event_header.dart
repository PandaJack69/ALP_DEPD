part of 'pages.dart';


class EventHeader extends StatelessWidget {
  final bool isLoggedIn;

  const EventHeader({
    super.key,
    required this.isLoggedIn,

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
              Navigator.pushReplacementNamed(context, "/home");
            },
            onEventPressed: () {
              Navigator.pushReplacementNamed(context, "/event");
            },
            onCompetitionPressed: () {
              Navigator.pushReplacementNamed(context, "/competition");
            },
            onPengMasPressed: () {
              Navigator.pushReplacementNamed(context, "/pengmas");
            },

            onLoginPressed: () {
              Navigator.pushReplacementNamed(context, "/login");
            },
            onRegisterPressed: () {
              Navigator.pushReplacementNamed(context, "/register");
            },
            onProfilePressed: () {
              Navigator.pushReplacementNamed(context, "/profile");
            },
          ),
          const SizedBox(height: 16),
          const Text(
            "Upcoming\nEvents",
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