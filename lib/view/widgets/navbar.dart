part of 'pages.dart';

class Navbar extends StatelessWidget {
  final bool isLoggedIn;
  final String activePage;

  const Navbar({
    super.key,
    required this.isLoggedIn,
    this.activePage = "Home",
  });

  Widget _navLink(
    BuildContext context,
    String text,
    bool isActive,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width > 800;

    return Container(
      // --- PENERAPAN GRADASI ---
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff123C52),
            Color(0xff3F054F),
          ],
        ),
      ),
      child: Row(
        children: [
          const Text(
            "The Event",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const Spacer(),

          if (isDesktop) ...[
            _navLink(context, "Home", activePage == "Home", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const HomePage()));
            }),
            _navLink(context, "Event", activePage == "Event", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const Eventpage()));
            }),
          ],

          const SizedBox(width: 20),

          if (isLoggedIn)
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
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
    );
  }
}