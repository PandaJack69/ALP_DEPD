part of 'pages.dart';

class EventCard extends StatefulWidget {
  final String title;
  final String tag;
  final Color tagColor;
  final String imageUrl;

  const EventCard({
    super.key,
    required this.title,
    required this.tag,
    required this.tagColor,
    required this.imageUrl,
  });

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  // Variabel untuk melacak apakah tombol sedang di-hover
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== IMAGE =====
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Image.network(
                  widget.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              // Overlay Hitam Bawah Gambar
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.white, size: 14),
                      SizedBox(width: 5),
                      Text(
                        "30 days | 15 hours left",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),

              // ===== APPLY NOW BUTTON DENGAN ANIMASI GRADIENT MELUNCUR =====
              Positioned(
                top: 15,
                right: 15,
                child: MouseRegion(
                  onEnter: (_) => setState(() => _isHovered = true),
                  onExit: (_) => setState(() => _isHovered = false),
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegistrationPage(),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 90, // Ukuran lebar tombol
                        height: 30, // Ukuran tinggi tombol
                        color: Colors.white, // Warna dasar tombol saat normal
                        child: Stack(
                          children: [
                            // Lapisan Gradient yang meluncur dari kanan
                            AnimatedPositioned(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              left: _isHovered ? 0 : 90, // Jika hover, masuk ke 0. Jika tidak, geser ke kanan (90)
                              child: Container(
                                width: 90,
                                height: 30,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xff123C52),
                                      Color(0xff3F054F),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Label Teks
                            Center(
                              child: AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 200),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "VisueltPro",
                                  // Berubah jadi putih saat hover, hitam saat normal
                                  color: _isHovered ? Colors.white : Colors.black,
                                ),
                                child: const Text("Apply Now"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: widget.tagColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        widget.tag,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "2023-10-30",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Turn Your Passion Into Action,\nJoin the Team Now",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}