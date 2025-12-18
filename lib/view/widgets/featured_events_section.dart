part of 'pages.dart';

class FeaturedEventsSection extends StatelessWidget {
  const FeaturedEventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // ===== AMBIL DATA DARI pages.dart =====
    final featuredEvents = dummyEvents
        .where(
          (e) =>
              DateTime.now().isAfter(e.openRegDate) &&
              DateTime.now().isBefore(e.closeRegDate),
        )
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          const Text(
            "Featured Events",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Color(0xFF0F172A),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "This isn't Just an Event, It's the Experience\n"
            "Everyone Will Talk About.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 50),

          // ===== EVENT CARD =====
          Wrap(
            spacing: 30,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: featuredEvents.map((event) {
              return EventCard(
                event: event,
                tag: "Closing Soon",
                tagColor: Colors.pink,
              );
            }).toList(),
          ),

          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
