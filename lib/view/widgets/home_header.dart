part of 'pages.dart';

class HomeHeader extends StatefulWidget {
  final bool isLoggedIn;
  const HomeHeader({super.key, required this.isLoggedIn});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  // 1. Tambahkan Controller
  final TextEditingController _searchController = TextEditingController();

  // 2. Fungsi untuk memicu pencarian
  void _onSearch() {
    final query = _searchController.text.trim();
    // Panggil fungsi search yang ada di DatabaseProvider
    context.read<DatabaseProvider>().searchEvents(query);
  }

  @override
  void dispose() {
    _searchController.dispose(); // Jangan lupa dispose
    super.dispose();
  }

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
          Navbar(isLoggedIn: widget.isLoggedIn, activePage: "Home"),
          const SizedBox(height: 60),
          const Text(
            "Find Your Next Experience",
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 16),
          const Text(
            "Discover & Promote\nUpcoming Events",
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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFEC82B9), Color(0xFFB763DD)],
          ),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xFF263238)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _searchController, // Hubungkan controller
              onSubmitted: (_) => _onSearch(), // Pencarian saat tekan 'Enter' di keyboard
              style: const TextStyle(color: Color(0xFF263238)),
              decoration: const InputDecoration(
                hintText: "Search events by name or category...",
                hintStyle: TextStyle(color: Color(0xFF263238)),
                border: InputBorder.none,
              ),
            ),
          ),
          // Tombol Kirim/Search
          GestureDetector(
            onTap: _onSearch, 
            child: Icon(Icons.send, color: const Color(0xFF263238).withOpacity(0.9)),
          ),
        ],
      ),
    );
  }
}