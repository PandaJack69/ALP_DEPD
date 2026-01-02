part of 'pages.dart';

class AllEventsSection extends StatelessWidget {
  const AllEventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Ambil data dari Provider
    final dbProvider = context.watch<DatabaseProvider>();

    // 2. Tentukan data mana yang dipakai (Search Result atau Semua Data)
    final List<EventModel> displayEvents = dbProvider.searchQuery.isNotEmpty
        ? dbProvider.filteredEvents
        : dbProvider.events;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- JUDUL ---
          const Text(
            "All Events",
            style: TextStyle(
              fontFamily: 'VisuletPro',
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF143952),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(), // Atur jarak kiri-kanan di sini
            child: Container(
              width: 120,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF143952),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(),
            child: Text(
              "This Isn’t Just an Event. It’s the Experience\n"
              "Everyone Will Talk About.",
              style: TextStyle(
                color: Color(0xFF143952),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // --- LOGIKA ISI KONTEN ---
          if (displayEvents.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Tidak ada event saat ini.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // Scroll ikut parent
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 350,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.75, // Sedikit disesuaikan agar EventCard proporsional
              ),
              itemCount: displayEvents.length,
              itemBuilder: (context, index) {
                final event = displayEvents[index];
                
                // MENGGUNAKAN EVENT CARD
                // Tag "Open Now" hanya muncul jika tanggal pendaftaran sedang berlangsung.
                // Jika belum mulai, EventCard otomatis ubah jadi "Coming Soon".
                // Jika sudah lewat, EventCard otomatis ubah jadi "Closed".
                return EventCard(
                  event: event,
                  tag: "Open Now", 
                  tagColor: Colors.green, 
                );
              },
            ),
        ],
      ),
    );
  }
}