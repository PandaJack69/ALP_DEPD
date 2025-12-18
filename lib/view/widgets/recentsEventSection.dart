part of 'pages.dart';

class RecentEventsSection extends StatelessWidget {
  const RecentEventsSection({super.key});

  bool _isRecent(EventModel event) {
    final now = DateTime.now();
    final diffDays = now.difference(event.openRegDate).inDays;

    return now.isAfter(event.openRegDate) &&
        now.isBefore(event.closeRegDate) &&
        diffDays <= 7;
  }

  @override
  Widget build(BuildContext context) {
    final recentEvents = dummyEvents.where(_isRecent).toList();

    if (recentEvents.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== TITLE =====
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Recent Events",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w900,
                color: Color(0xFF0F172A),
              ),
            ),
          ),

          const SizedBox(height: 12),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "This isn't Just an Event, It's the Experience\n"
              "Everyone Will Talk About.",
              style: TextStyle(
                color: Colors.grey,
                height: 1.5,
              ),
            ),
          ),

          const SizedBox(height: 50),

          // ===== HORIZONTAL LIST =====
          SizedBox(
            height: 430,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: recentEvents.length,
              separatorBuilder: (_, __) => const SizedBox(width: 30),
              itemBuilder: (context, index) {
                final event = recentEvents[index];
                return EventCard(
                  event: event,
                  tag: "Just Now",
                  tagColor: Colors.blue, // default sementara
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
