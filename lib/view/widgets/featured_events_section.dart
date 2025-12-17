part of 'pages.dart';

class FeaturedEventsSection extends StatelessWidget {
  const FeaturedEventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // ================= DUMMY EVENT =================
    final events = [
      EventModel(
        id: '1',
        name: 'Leadership 101 | Batch 1',
        description: 'Event leadership untuk mahasiswa.',
        posterUrl: 'https://picsum.photos/id/1/400/300',
        organization: 'Tech Community Indonesia',
        openRegDate: DateTime(2025, 1, 1),
        closeRegDate: DateTime(2025, 1, 30),
        eventDate: DateTime(2025, 2, 20),
        benefits: ['E-Certificate', 'Networking'],
        divisions: ['Design', 'Development'],
      ),
      EventModel(
        id: '2',
        name: 'Hackfest 2025',
        description: 'Hackathon nasional.',
        posterUrl: 'https://picsum.photos/id/20/400/300',
        organization: 'Hack Community',
        openRegDate: DateTime(2025, 2, 1),
        closeRegDate: DateTime(2025, 2, 15),
        eventDate: DateTime(2025, 3, 10),
        benefits: ['Prize Pool'],
        divisions: ['Frontend', 'Backend'],
      ),EventModel(
        id: '3',
        name: 'Hackfest 2026',
        description: 'Hackathon nasional.',
        posterUrl: 'https://picsum.photos/id/20/400/300',
        organization: 'Hack Community',
        openRegDate: DateTime(2026, 2, 1),
        closeRegDate: DateTime(2026, 2, 15),
        eventDate: DateTime(2026, 3, 10),
        benefits: ['Prize Pool'],
        divisions: ['Frontend', 'Backend'],
      ),
      EventModel(
        id: '4',
        name: 'NPLC',
        description: 'Hackathon nasional.',
        posterUrl: 'https://picsum.photos/id/20/400/300',
        organization: 'Hack Community',
        openRegDate: DateTime(2025, 12, 1),
        closeRegDate: DateTime(2026, 2, 15),
        eventDate: DateTime(2026, 3, 10),
        benefits: ['Prize Pool'],
        divisions: ['Frontend', 'Backend'],
      ),
    ];

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
            "This isn't Just an Event, It's the Experience\nEveryone Will Talk About.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, height: 1.5),
          ),
          const SizedBox(height: 50),

          Wrap(
            spacing: 30,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: events.map((event) {
              return EventCard(
                event: event,
                tag: 'Closing Soon',
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
