import 'package:alp_depd/view/pages/admin/registrationpage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../model/eventmodel.dart';
import '../../../viewmodel/authviewmodel.dart';
import '../../widgets/pages.dart';
import 'package:alp_depd/view/widgets/footer_section.dart';

const Color titleColor = Color(0xFF0F2A44); // navy gelap
const Color subColor   = Color(0xFF334155); // abu kebiruan

class EventDetailPage extends StatelessWidget {
  final EventModel event;

  const EventDetailPage({super.key, required this.event});
  


  @override
  Widget build(BuildContext context) {
    final authVM = context.watch<AuthViewModel>();
    final df = DateFormat('dd MMM yyyy');
    final diff = event.eventDate.difference(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // ===== BACKGROUND IMAGE (HERO + CONTENT) =====
            SizedBox(
              width: double.infinity,
              height: 1600, // cukup untuk hero + content
              child: Image.network(
                event.posterUrl,
                fit: BoxFit.cover,
              ),
            ),

            // ===== WHITE OVERLAY =====
            Container(
              width: double.infinity,
              height: 1600,
              color: Colors.white.withOpacity(0.82),
            ),

            // ===== PAGE CONTENT =====
            Column(
              children: [
                // ================= NAVBAR =================
                Navbar(
                  isLoggedIn: authVM.isLoggedIn,
                  activePage: "Event",
                ),

                // ================= HERO =================
                SizedBox(
                  height: 600,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          event.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 56,
                            fontWeight: FontWeight.w900,
                            color: titleColor,
                            letterSpacing: -0.8,
                          ),
                        ),

                        const SizedBox(height: 30),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _count(diff.inDays, 'days'),
                            const SizedBox(width: 90),
                            _colon(),
                            const SizedBox(width: 90),
                            _count(diff.inHours % 24, 'hours'),
                            const SizedBox(width: 90),
                            _colon(),
                            const SizedBox(width: 90),
                            _count(diff.inMinutes % 60, 'minutes'),
                          ],
                        ),

                        const SizedBox(height: 90),

                        SizedBox(
                          width: 620,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Get Notified",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: titleColor,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: "Enter your email",
                                        hintStyle:
                                            const TextStyle(color: subColor),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 22, vertical: 18),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(32),
                                          borderSide: const BorderSide(
                                            color: titleColor,
                                            width: 1.5,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(32),
                                          borderSide: const BorderSide(
                                            color: titleColor,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 18),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 38,
                                              vertical: 20),
                                      backgroundColor:
                                          const Color(0xff3F054F),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(32),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      "Notify",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ================= CONTENT =================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 150),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ========= POSTER =========
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.network(
                          event.posterUrl,
                          width: 380,
                          height: 620,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 80),

                      // ========= CONTENT =========
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // TITLE
                            Text(
                              event.name,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: titleColor,
                              ),
                            ),

                            const SizedBox(height: 10),

                            // DESCRIPTION
                            Text(
                              event.description,
                              style: const TextStyle(
                                fontSize: 15,
                                color: subColor,
                                height: 1.6,
                                fontWeight: FontWeight.w800,
                              ),
                            ),

                            const SizedBox(height: 40),

                            // ========= EVENT DETAIL + BENEFIT =========
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // EVENT DETAIL
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Event Detail",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: titleColor,
                                        ),
                                      ),
                                      const SizedBox(height: 16),

                                      _detailRow("Organization", event.organization),
                                      _detailRow(
                                        "Start Entry",
                                        DateFormat('dd MMM yyyy').format(event.openRegDate),
                                      ),
                                      _detailRow(
                                        "Last Entry",
                                        DateFormat('dd MMM yyyy').format(event.closeRegDate),
                                      ),
                                      _detailRow(
                                        "The Day",
                                        DateFormat('dd MMM yyyy').format(event.eventDate),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(width: 60),

                                // BENEFIT (NUMBERED)
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Event Benefit",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: titleColor,
                                        ),
                                      ),
                                      const SizedBox(height: 16),

                                      ...event.benefits.asMap().entries.map(
                                        (entry) => Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 6),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${entry.key + 1}.",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: titleColor,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  entry.value,
                                                  style: const TextStyle(
                                                    color: subColor,
                                                    height: 1.5,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 40),

                            // ========= DIVISION =========
                            const Text(
                              "Divisions",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: titleColor,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: event.divisions
                                  .map((d) => Chip(label: Text(d)))
                                  .toList(),
                            ),

                            const SizedBox(height: 40),

                            // ========= CONTACT =========
                            Row(
                              children: [
                                _contact(Icons.phone, event.whatsapp),
                                const SizedBox(width: 20),
                                _contact(Icons.message, event.lineId),
                                const SizedBox(width: 20),
                                _contact(Icons.camera_alt, event.instagram),
                              ],
                            ),

                            const SizedBox(height: 40),

                            // ========= APPLY BUTTON =========
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 18),
                                  backgroundColor: const Color(0xff3F054F),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          RegistrationPage(event: event),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Apply Now !",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),


                // ================= FOOTER =================
                const FooterSection(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ================= HELPERS =================
  static Widget _count(int v, String l) => Column(
  children: [
    Text(
      '$v',
      style: const TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.bold,
        color: Color(0xFF0F2A44),
      ),
    ),
    Text(
      l,
      style: const TextStyle(
        color: Color(0xFF334155),
      ),
    ),
  ],
);

  static Widget _info(String t, String v) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text('$t : $v'),
      );

  static Widget _colon() => const Text(
      ":",
      style: TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.bold,
        color: Color(0xFF0F2A44),
      ),
    );
  
  static Widget _contact(IconData icon, String text) => Row(
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: 6),
        Text(text),
      ],
    );

  static Widget _detailRow(String label, String value) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(
              color: subColor, // ✅ disamain
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const Text(
          ": ",
          style: TextStyle(
            color: subColor,
            fontWeight: FontWeight.w800,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: subColor, 
              fontWeight: FontWeight.w500,// ✅ disamain
            ),
          ),
        ),
      ],
    ),
  );



}
