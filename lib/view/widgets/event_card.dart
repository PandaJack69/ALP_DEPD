part of 'pages.dart';

class EventCard extends StatefulWidget {
  final EventModel event;
  final String tag;
  final Color tagColor;

  const EventCard({
    super.key,
    required this.event,
    required this.tag,
    required this.tagColor,
  });

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool _isHovered = false;

  bool get isComingSoon =>
      DateTime.now().isBefore(widget.event.openRegDate);

  bool get isOpen {
    final now = DateTime.now();
    return now.isAfter(widget.event.openRegDate) &&
        now.isBefore(widget.event.closeRegDate);
  }

  bool get isClosed =>
      DateTime.now().isAfter(widget.event.closeRegDate);

  Duration get remainingTime =>
      widget.event.closeRegDate.difference(DateTime.now());

  String get countdownText {
    if (remainingTime.isNegative) return "Closed";
    final days = remainingTime.inDays;
    final hours = remainingTime.inHours % 24;
    return "$days days | $hours hours left";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EventDetailPage(event: widget.event),
          ),
        );
      },
      child: Container(
        width: 320,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= IMAGE =================
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  child: Image.network(
                    widget.event.posterUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                // ===== APPLY NOW (TOP RIGHT) =====
                if (isOpen)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: MouseRegion(
                      onEnter: (_) => setState(() => _isHovered = true),
                      onExit: (_) => setState(() => _isHovered = false),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  RegistrationPage(event: widget.event),
                            ),
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: _isHovered
                                ? const Color(0xff3F054F)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Apply Now",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: _isHovered
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                // ===== COUNTDOWN (BOTTOM LEFT) =====
                Positioned(
                  left: 12,
                  bottom: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.access_time,
                            size: 14, color: Colors.white),
                        const SizedBox(width: 6),
                        Text(
                          countdownText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // ================= CONTENT =================
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // STATUS + DATE
                  Row(
                    children: [
                      _statusChip(),
                      const SizedBox(width: 10),
                      Text(
                        _formatDate(widget.event.closeRegDate),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // TITLE
                  Text(
                    widget.event.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // DESCRIPTION
                  const Text(
                    "Turn Your Passion Into Action,\nJoin the Team Now",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusChip() {
    if (isComingSoon) {
      return _chip("Coming Soon", Colors.orange);
    }
    if (isClosed) {
      return _chip("Closed", Colors.red);
    }
    return _chip("Closing Soon", const Color(0xffA0025B));
  }

  Widget _chip(String text, Color color) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}
