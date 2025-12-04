part of 'pages.dart';

class FeaturedEventsSection extends StatelessWidget {
  const FeaturedEventsSection({super.key});

  @override
  Widget build(BuildContext context) {
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

          // The Grid of Cards
          Wrap(
            spacing: 30,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: [
              EventCard(
                title: "Leadership 101 | Batch 1",
                tag: "Closing Soon",
                tagColor: Colors.pink,
                imageUrl: "https://picsum.photos/id/1/400/300",
              ),
              EventCard(
                title: "Hackfest 2025",
                tag: "Closing Soon",
                tagColor: Colors.pink,
                imageUrl: "https://picsum.photos/id/20/400/300",
              ),
              EventCard(
                title: "Anggota Muda",
                tag: "Closing Soon",
                tagColor: Colors.pink,
                imageUrl: "https://picsum.photos/id/36/400/300",
              ),
              // Row 2
              EventCard(
                title: "Leadership 101 | Batch 2",
                tag: "Coming Soon",
                tagColor: Colors.orange,
                imageUrl: "https://picsum.photos/id/48/400/300",
              ),
              EventCard(
                title: "Hackfest 2025",
                tag: "Just New",
                tagColor: Colors.purple,
                imageUrl: "https://picsum.photos/id/60/400/300",
              ),
              EventCard(
                title: "Anggota Muda",
                tag: "Just New",
                tagColor: Colors.purple,
                imageUrl: "https://picsum.photos/id/96/400/300",
              ),
            ],
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}