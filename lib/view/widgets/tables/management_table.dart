import 'package:flutter/material.dart';
import '../details/organizer_event_detail.dart';
import '../details/organizer_lomba_detail.dart';

class ManagementTable extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final String type; // "Event", "Lomba", atau "Pengmas"
  final Function(Map<String, dynamic>) onEdit;
  final Function(Map<String, dynamic>) onCheckParticipants;

  const ManagementTable({
    super.key, 
    required this.data, 
    required this.type, 
    required this.onEdit, 
    required this.onCheckParticipants
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const Center(child: Padding(padding: EdgeInsets.all(40), child: Text("Belum ada data.")));

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: WidgetStateProperty.all(const Color(0xFFF1F5F9)),
        columns: const [
          DataColumn(label: Text('Nama')),
          DataColumn(label: Text('Registrasi')),
          DataColumn(label: Text('Aksi')),
        ],
        rows: data.map((item) => DataRow(cells: [
          DataCell(Text(item['nama'] ?? "-", style: const TextStyle(fontWeight: FontWeight.bold))),
          DataCell(Row(
            children: [
              Text("${item['registrasi']}"),
              const SizedBox(width: 8),
              IconButton(
                tooltip: "Lihat Pendaftar",
                icon: const Icon(Icons.people, size: 20, color: Color(0xff143952)), 
                onPressed: () => onCheckParticipants(item)
              ),
            ],
          )),
          DataCell(Row(
            children: [
              IconButton(
                tooltip: "Lihat Detail Konten",
                icon: const Icon(Icons.visibility, color: Colors.blue), 
                onPressed: () {
                  // Navigasi ke halaman detail berdasarkan tipe [cite: 33]
                  if (type == "Lomba") {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OrganizerLombaDetail(lombaData: item)));
                  } else {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OrganizerEventDetail(eventData: item)));
                  }
                }
              ),
              IconButton(icon: const Icon(Icons.edit, color: Colors.orange), onPressed: () => onEdit(item)),
              IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () {}),
            ],
          )),
        ])).toList(),
      ),
    );
  }
}