part of 'pages.dart';

class UpcomingEventsSection extends StatelessWidget {
  const UpcomingEventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // HANYA EVENT YANG BELUM OPEN REGISTRATION
    final upcomingEvents = dummyEvents
        .where((e) => DateTime.now().isBefore(e.openRegDate))
        .toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF103D52),
            Color(0xFF291F51),
            Color(0xFF3F054F),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== TITLE =====
          const Text(
            "Upcoming\nEvents",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),

          const SizedBox(height: 12),

          // ===== UNDERLINE =====
          Container(
            width: 90,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(height: 20),

          // ===== SUBTITLE =====
          const Text(
            "This Isn’t Just an Event. It’s\n"
            "the Experience Everyone\n"
            "Will Talk About.",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 50),

          // ===== HORIZONTAL CARD =====
          SizedBox(
            height: 420,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: upcomingEvents.length,
              separatorBuilder: (_, __) => const SizedBox(width: 24),
              itemBuilder: (context, index) {
                return UpcomingEventCard(
                  event: upcomingEvents[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
