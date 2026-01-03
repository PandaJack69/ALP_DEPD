part of 'pages.dart';

class Navbar extends StatelessWidget {
  final bool isLoggedIn;
  final String activePage;

  const Navbar({super.key, required this.isLoggedIn, this.activePage = "Home"});

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
              ),
          ],
        ),
      ),
    );
  }

  // --- FUNGSI BARU: MENAMPILKAN DIALOG KONFIRMASI LOGOUT ---
  void _showLogoutDialog(BuildContext context, DatabaseProvider dbProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Konfirmasi Logout"),
          content: const Text("Apakah Anda yakin ingin keluar akun?"),
          actions: [
            // Tombol Batal
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text("Batal", style: TextStyle(color: Colors.grey)),
            ),
            // Tombol Ya (Logout)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog dulu
                
                // Proses Logout
                dbProvider.logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text("Ya, Keluar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final dbProvider = context.watch<DatabaseProvider>();
    final user = dbProvider.currentUser; // Ambil data user
    final bool isDesktop = width > 800;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xFF3F054F), Color(0xFF291F51), Color(0xFF103D52)],
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/Image/Logo.png',
            height: 50,
          ),
          const Spacer(),

          if (isDesktop) ...[
            _navLink(context, "Home", activePage == "Home", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
              );
            }),
            _navLink(context, "Event", activePage == "Event", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Eventpage()),
              );
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
                      builder: (context) => const OrganizerDashboard(),
                    ),
                  );
                } else if (value == 'admin') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminDashboard(),
                    ),
                  );
                } else if (value == 'profile') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                } else if (value == 'logout') {
                  // --- PERUBAHAN DI SINI: Panggil Dialog Dulu ---
                  _showLogoutDialog(context, dbProvider);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                if (user?.role == 'organizer')
                  const PopupMenuItem<String>(
                    value: 'organize',
                    child: Text('Organize Events'),
                  ),
                if (user?.role == 'admin')
                  const PopupMenuItem<String>(
                    value: 'admin',
                    child: Text('Manage Admin'),
                  ),
                const PopupMenuItem<String>(
                  value: 'profile',
                  child: Text('Manage Profile'),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Logout', style: TextStyle(color: Colors.red)), // Opsional: Beri warna merah
                ),
              ],
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey[300],
                    backgroundImage:
                        (user?.avatarUrl != null && user!.avatarUrl!.isNotEmpty)
                            ? NetworkImage(user.avatarUrl!)
                            : const NetworkImage(
                                "https://cdn-icons-png.freepik.com/512/6522/6522516.png",
                              ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    user?.email ?? "User",
                    style: const TextStyle(color: Colors.white),
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