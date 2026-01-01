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
    final authViewModel = context.watch<AuthViewModel>();
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
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'organize') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminDashboard()));
                } else if (value == 'profile') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()));
                } else if (value == 'logout') {
                  authViewModel.logout();
                  // Optionally, navigate to home page after logout
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (Route<dynamic> route) => false,
                  );
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'organize',
                  child: Text('Organize Events'),
                ),
                const PopupMenuItem<String>(
                  value: 'profile',
                  child: Text('Manage Profile'),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ],
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(
                        "https://picsum.photos/id/64/200/200"), // Placeholder
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Violet@gmail.com", // Placeholder
                    style: TextStyle(color: Colors.white),
                  ),
                  const Icon(Icons.arrow_drop_down, color: Colors.white),
                ],
              ),
            )
          else
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
    );
  }
}