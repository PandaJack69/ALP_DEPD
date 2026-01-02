part of 'pages.dart';

class EventHeader extends StatefulWidget {
  final bool isLoggedIn;

  const EventHeader({super.key, required this.isLoggedIn});

  @override
  State<EventHeader> createState() => _EventHeaderState();
}

class _EventHeaderState extends State<EventHeader> {
  // 1. Controller untuk input search
  final TextEditingController _searchController = TextEditingController();

  // 2. Fungsi pencarian (Logika sama dengan HomeHeader)
  void _onSearch(String query) {
    context.read<DatabaseProvider>().searchEvents(query);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Ambil data dari database
    final dbProvider = context.watch<DatabaseProvider>();
    final now = DateTime.now();

    // Filter event Upcoming (hanya yang belum lewat tanggal pendaftarannya)
    final upcomingEvents = dbProvider.events.where((e) {
      return now.isBefore(e.openRegDate);
    }).toList();

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xFF3F054F), Color(0xFF291F51), Color(0xFF103D52)],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== NAVBAR =====
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: Navbar(isLoggedIn: widget.isLoggedIn, activePage: "Event"),
            ),

            const SizedBox(height: 20),

            // ===== TITLE + CARD (SEJAJAR) =====
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===== LEFT TEXT (DENGAN PADDING) =====
                SizedBox(
                  width: 450, // Sedikit diperlebar agar padding muat
                  child: Padding(
                    // --- PERBAIKAN: Menambahkan Padding di sini ---
                    padding: const EdgeInsets.only(left: 60.0, top: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Upcoming\nEvents",
                          style: TextStyle(
                            fontFamily: 'VisuletPro', // Pastikan font terpasang
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            height: 1.15,
                          ),
                        ),

                        const SizedBox(height: 14),

                        Container(
                          width: 90,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        const SizedBox(height: 22),

                        const Text(
                          "This Isn’t Just an Event. It’s \nthe Experience Everyone \nWill Talk About.",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'VisuletPro', // Pastikan font terpasang
                            fontSize: 16,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 20),

                // ===== RIGHT CARD (DATA UPCOMING) =====
                Expanded(
                  child: SizedBox(
                    height: 340,
                    child: upcomingEvents.isEmpty
                        ? const Center(
                            child: Text(
                              "No upcoming events",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          )
                        : ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(
                              right: 40,
                            ), // Padding kanan list
                            itemCount: upcomingEvents.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 24),
                            itemBuilder: (context, index) {
                              return UpcomingEventCard(
                                event: upcomingEvents[index],
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // ===== SEARCH BAR (DENGAN PADDING) =====
            Padding(
              // Memberikan jarak kiri-kanan-bawah
              padding: const EdgeInsets.symmetric(
                horizontal: 180,
                vertical: 30,
              ),
              child: _buildSearchBar(),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ---------------- SEARCH BAR FUNCTIONAL ----------------
  Widget _buildSearchBar() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: const Color(0xFFB763DD), width: 2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFEC83BB).withOpacity(0.5),
            blurRadius: 25,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xFF263238)),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _searchController,
              // --- PERBAIKAN: Menambahkan fungsi onChanged ---
              onChanged: _onSearch,
              style: const TextStyle(color: Color(0xFF263238)),
              decoration: const InputDecoration(
                hintText: "Search events by name...",
                hintStyle: TextStyle(color: Color(0xFF263238)),
                border: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _onSearch(_searchController.text),
            child: Icon(
              Icons.send,
              color: const Color(0xFF263238).withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
