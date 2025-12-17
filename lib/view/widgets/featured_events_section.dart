import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  String activeTab = "Event";

  // Map untuk menyimpan status setiap peserta (Key: Nama Peserta, Value: Status)
  // Status: 1 untuk Centang, 2 untuk Silang, 3 untuk Strip
  Map<String, int> participantStatus = {};

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          // --- NAVBAR ADMIN ---
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff123C52), Color(0xff3F054F)],
              ),
            ),
            child: Row(
              children: [
                const Text(
                  "Admin Dashboard",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(width: 60),
                _navItem("Event"),
                const SizedBox(width: 30),
                _navItem("Lomba"),
                const Spacer(),
                const CircleAvatar(
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person, color: Colors.white),
                )
              ],
            ),
          ),

          // --- KONTEN TABEL ---
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(40),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Daftar Peserta $activeTab",
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff143952)),
                      ),
                      const SizedBox(height: 20),
                      activeTab == "Event" ? _buildEventTable() : _buildLombaTable(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(String title) {
    bool isActive = activeTab == title;
    return GestureDetector(
      onTap: () => setState(() => activeTab = title),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.white70,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 2,
              width: 20,
              color: Colors.white,
            )
        ],
      ),
    );
  }

  Widget _buildEventTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(Colors.grey[100]),
        columns: const [
          DataColumn(label: Text('Nama Lengkap')),
          DataColumn(label: Text('Universitas')),
          DataColumn(label: Text('Major')),
          DataColumn(label: Text('Year')),
          DataColumn(label: Text('Phone')),
          DataColumn(label: Text('Division')),
          DataColumn(label: Text('CV')),
          DataColumn(label: Text('Portfolio')),
          DataColumn(label: Text('Action')),
        ],
        rows: [
          _buildDataRow(
            name: "Budi Santoso",
            univ: "Universitas Ciputra",
            major: "Informatika",
            year: "2022",
            phone: "08123456789",
            division: "PDD Design",
            cvUrl: "https://google.com",
            portUrl: "https://google.com",
          ),
          _buildDataRow(
            name: "Siti Aminah",
            univ: "ITS",
            major: "Sistem Informasi",
            year: "2021",
            phone: "08987654321",
            division: "Event",
            cvUrl: "https://google.com",
            portUrl: "https://google.com",
          ),
        ],
      ),
    );
  }

  Widget _buildLombaTable() {
    return const Center(child: Text("Konten Tabel Lomba Belum Tersedia"));
  }

  DataRow _buildDataRow({
    required String name,
    required String univ,
    required String major,
    required String year,
    required String phone,
    required String division,
    required String cvUrl,
    required String portUrl,
  }) {
    // Ambil status pilihan saat ini untuk baris ini (default ke 0 jika belum pilih)
    int currentStatus = participantStatus[name] ?? 0;

    return DataRow(cells: [
      DataCell(Text(name)),
      DataCell(Text(univ)),
      DataCell(Text(major)),
      DataCell(Text(year)),
      DataCell(Text(phone)),
      DataCell(Text(division)),
      DataCell(
        TextButton(
          onPressed: () => _launchURL(cvUrl),
          child: const Text("View CV", style: TextStyle(color: Colors.blue)),
        ),
      ),
      DataCell(
        TextButton(
          onPressed: () => _launchURL(portUrl),
          child: const Text("View Port", style: TextStyle(color: Colors.blue)),
        ),
      ),
      DataCell(
        Row(
          children: [
            // Ikon Centang (Status 1)
            _buildStatusIcon(
              icon: Icons.check_circle,
              color: Colors.green,
              isSelected: currentStatus == 1,
              onTap: () => setState(() => participantStatus[name] = 1),
            ),
            const SizedBox(width: 8),
            // Ikon Silang (Status 2)
            _buildStatusIcon(
              icon: Icons.cancel,
              color: Colors.red,
              isSelected: currentStatus == 2,
              onTap: () => setState(() => participantStatus[name] = 2),
            ),
            const SizedBox(width: 8),
            // Ikon Strip (Status 3)
            _buildStatusIcon(
              icon: Icons.remove_circle,
              color: Colors.grey,
              isSelected: currentStatus == 3,
              onTap: () => setState(() => participantStatus[name] = 3),
            ),
          ],
        ),
      ),
    ]);
  }

  // Widget Helper untuk membuat Ikon dengan Background jika dipilih
  Widget _buildStatusIcon({
    required IconData icon,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          // Jika dipilih, kasih warna background sesuai warna ikon dengan opacity
          color: isSelected ? color.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 1,
          ),
        ),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }
}