import 'package:flutter/material.dart';

class OrganizerLombaDetail extends StatelessWidget {
  final Map<String, dynamic> lombaData;

  const OrganizerLombaDetail({super.key, required this.lombaData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Lomba: ${lombaData['nama']}"),
        backgroundColor: const Color(0xff123C52),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Statistik Singkat
            Row(
              children: [
                _buildStatCard("Registrasi Peserta", "${lombaData['registrasi']}", Icons.group, Colors.blue),
                const SizedBox(width: 20),
                _buildStatCard("Biaya Daftar", "Rp 50.000", Icons.payments, Colors.orange),
                const SizedBox(width: 20),
                _buildStatCard("Status", "Open", Icons.door_front_door, Colors.green),
              ],
            ),
            const SizedBox(height: 30),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Poster
                Expanded(
                  flex: 1,
                  child: Card(
                    child: Column(
                      children: [
                        Image.network("https://via.placeholder.com/300x400", fit: BoxFit.cover),
                        const Padding(padding: EdgeInsets.all(10), child: Text("Poster Lomba")),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 30),

                // Info Detail Lomba (PDF Halaman 2)
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      _buildInfoCard("Timeline & Teknis", [
                        _infoRow("Nama Lomba", lombaData['nama']),
                        _infoRow("Pendaftaran", "${lombaData['start'] ?? '-'} s/d ${lombaData['end'] ?? '-'}"),
                        _infoRow("TM (Technical Meeting)", "12 Maret 2024"),
                        _infoRow("Babak Prelim", "15 Maret 2024"),
                        _infoRow("Hari H Lomba", "20 Maret 2024"),
                      ]),
                      const SizedBox(height: 20),
                      _buildInfoCard("Administrasi & Kontak", [
                        _infoRow("Biaya", "Rp 50.000"),
                        _infoRow("No Rekening", "BCA - 12345678 (A/N Panitia)"),
                        _infoRow("CP WhatsApp", "0812xxxxxx"),
                        _infoRow("CP Line", "id_lomba_line"),
                      ]),
                      const SizedBox(height: 20),
                      _buildInfoCard("Sub-Event / Jenis Lomba", [
                        const Text("- Web Development", style: TextStyle(height: 1.5)),
                        const Text("- UI/UX Design", style: TextStyle(height: 1.5)),
                        const Text("- Mobile App Dev", style: TextStyle(height: 1.5)),
                      ]),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String t, String v, IconData i, Color c) {
    return Expanded(
      child: Card(
        child: ListTile(
          leading: CircleAvatar(backgroundColor: c.withOpacity(0.1), child: Icon(i, color: c)),
          title: Text(t, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          subtitle: Text(v, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String t, List<Widget> c) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff143952))),
            const Divider(),
            ...c
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String l, String v) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(width: 150, child: Text(l, style: const TextStyle(color: Colors.grey))),
          Expanded(child: Text(": $v", style: const TextStyle(fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}