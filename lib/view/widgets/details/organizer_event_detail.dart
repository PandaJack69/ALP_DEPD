import 'package:flutter/material.dart';

class OrganizerEventDetail extends StatelessWidget {
  final Map<String, dynamic> eventData;

  const OrganizerEventDetail({super.key, required this.eventData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail: ${eventData['nama']}"),
        backgroundColor: const Color(0xff123C52),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Statistik
            Row(
              children: [
                _buildStatCard("Total Registrasi", "${eventData['registrasi']}", Icons.people, Colors.blue),
                const SizedBox(width: 20),
                _buildStatCard("Status", "Active", Icons.check_circle, Colors.green),
              ],
            ),
            const SizedBox(height: 30),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Kolom Kiri: Poster
                Expanded(
                  flex: 1,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        Image.network(
                          "https://via.placeholder.com/400x600",
                          fit: BoxFit.cover,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text("Poster Proker", style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 30),

                // Kolom Kanan: Informasi Detail Sesuai Alur Pembuatan (PDF Halaman 2)
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      _buildInfoCard(
                        "Informasi Umum",
                        [
                          _buildDetailRow("Nama Proker", eventData['nama']),
                          _buildDetailRow("Start Pendaftaran", eventData['start'] ?? "-"),
                          _buildDetailRow("End Pendaftaran", eventData['end'] ?? "-"),
                          _buildDetailRow("Hari H Acara", eventData['hariH'] ?? "-"),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildInfoCard(
                        "Koordinasi & S&K",
                        [
                          _buildDetailRow("WA/Line Group", "Link terlampir"),
                          _buildDetailRow("CP WhatsApp", "0812xxxxxx"),
                          _buildDetailRow("CP Line", "ID_Line"),
                          const Divider(),
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
                            label: const Text("Lihat Dokumen S&K", style: TextStyle(color: Colors.blue)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildInfoCard(
                        "Divisi yang Dicari",
                        [
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              _buildTag("Inventory"),
                              _buildTag("Event"),
                              _buildTag("Security"),
                              _buildTag("PDD"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color)),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff143952))),
            const Divider(height: 30),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          SizedBox(width: 150, child: Text(label, style: const TextStyle(color: Colors.grey))),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xff3F054F).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xff3F054F).withOpacity(0.3)),
      ),
      child: Text(label, style: const TextStyle(color: Color(0xff3F054F), fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}