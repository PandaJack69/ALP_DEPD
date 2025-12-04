part of 'pages.dart';

class AppNavbar extends StatelessWidget {
  final bool isLoggedIn;

  final VoidCallback? onHomePressed;
  final VoidCallback? onEventPressed;
  final VoidCallback? onCompetitionPressed;
  final VoidCallback? onPengMasPressed;

  final VoidCallback onLoginPressed;
  final VoidCallback onRegisterPressed;
  final VoidCallback onProfilePressed;

  const AppNavbar({
    super.key,
    required this.isLoggedIn,
    required this.onLoginPressed,
    required this.onRegisterPressed,
    required this.onProfilePressed,
    this.onHomePressed,
    this.onEventPressed,
    this.onCompetitionPressed,
    this.onPengMasPressed,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width > 800;

    return Row(
      children: [
        const Text(
          "The Event",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const Spacer(),

        // ================= MENU DESKTOP =================
        if (isDesktop)
          Row(
            children: [
              _navItem("Home", onPressed: onHomePressed),
              _navItem("Event", onPressed: onEventPressed),
              _navItem("Competition", onPressed: onCompetitionPressed),
              _navItem("PengMas", onPressed: onPengMasPressed),
            ],
          ),

        const SizedBox(width: 20),

        // ================= LOGIN / PROFILE =================
        if (isLoggedIn)
          ElevatedButton(
            onPressed: onProfilePressed,
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
          Row(
            children: [
              ElevatedButton(
                onPressed: onLoginPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF360C4C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("Log In"),
              ),
              const SizedBox(width: 10),

              ElevatedButton(
                onPressed: onRegisterPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("Register"),
              ),
            ],
          ),
      ],
    );
  }

  Widget _navItem(String text, {VoidCallback? onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white70, fontSize: 15),
        ),
      ),
    );
  }
}