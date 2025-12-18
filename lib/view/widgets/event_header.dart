part of 'pages.dart';

class EventHeader extends StatelessWidget {
  final bool isLoggedIn;

  const EventHeader({
    super.key,
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    final upcomingEvents = dummyEvents
        .where((e) => DateTime.now().isBefore(e.openRegDate))
        .toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(32, 40, 32, 60),
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
          // ===== NAVBAR =====
          Navbar(isLoggedIn: isLoggedIn, activePage: "Event"),

          const SizedBox(height: 60),

          // ===== TITLE + CARD (SEJAJAR) =====
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== LEFT TEXT =====
             SizedBox(
                width: 420,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // ← INI KUNCINYA
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Upcoming\nEvents",
                      style: TextStyle(
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
                      "This Isn’t Just an Event. It’s the Experience\n"
                      "Everyone Will Talk About.",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),


              const SizedBox(width: 40),

              // ===== RIGHT CARD =====
              Expanded(
                child: SizedBox(
                  height: 420,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
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

          const SizedBox(height: 50),

          // ===== SEARCH (FULL WIDTH DI BAWAH) =====
          _buildSearchBar(),
        ],
      ),
    );
  }

  // ---------------- SEARCH BAR ----------------
  Widget _buildSearchBar() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        border: const GradientBoxBorder(
          gradient: LinearGradient(
            colors: [
              Color(0xFFEC82B9),
              Color(0xFFB763DD),
            ],
          ),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFEC83BB).withOpacity(0.5),
            blurRadius: 25,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xFF263238)),
          const SizedBox(width: 12),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search events",
                hintStyle: TextStyle(color: Color(0xFF263238)),
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(
            Icons.send,
            color: const Color(0xFF263238).withOpacity(0.8),
          ),
        ],
      ),
    );
  }
}
