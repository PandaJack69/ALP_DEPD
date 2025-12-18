part of 'pages.dart';

class LastChanceEventsSection extends StatelessWidget {
  const LastChanceEventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final lastChanceEvents = dummyEvents
        .where((event) {
          final daysLeft =
              event.closeRegDate.difference(now).inDays;

          return now.isAfter(event.openRegDate) &&
              now.isBefore(event.closeRegDate) &&
              daysLeft >= 0 &&
              daysLeft <= 7;
        })
        .toList()
      // 🔥 paling mepet tampil dulu
      ..sort(
        (a, b) => a.closeRegDate.compareTo(b.closeRegDate),
      );

    // kalau ga ada, section ga muncul
    if (lastChanceEvents.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================= TITLE =================
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Last Chance Events",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w900,
                color: Color(0xFF0F172A),
              ),
            ),
          ),

          const SizedBox(height: 10),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "This Isn’t Just an Event. It’s the Experience\n"
              "Everyone Will Talk About.",
              style: TextStyle(
                color: Colors.grey,
                height: 1.5,
              ),
            ),
          ),

          const SizedBox(height: 45),

          // ================= EVENT LIST =================
          SizedBox(
            height: 420,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: lastChanceEvents.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(width: 30),
              itemBuilder: (context, index) {
                final event = lastChanceEvents[index];

                return EventCard(
                  event: event,
                  tag: "Closing Soon",
                  tagColor: const Color(0xffA0025B),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
