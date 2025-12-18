import 'package:flutter/material.dart';

class EventParticipantTable extends StatelessWidget {
  const EventParticipantTable({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: WidgetStateProperty.all(const Color(0xFFF1F5F9)),
        columns: const [
          DataColumn(label: Text('Nama')),
          DataColumn(label: Text('Jurusan')),
          DataColumn(label: Text('Angkatan')),
          DataColumn(label: Text('Nomor Tlp')),
          DataColumn(label: Text('ID Line')),
          DataColumn(label: Text('CV')),
          DataColumn(label: Text('Portfolio')),
        ],
        rows: [
          DataRow(cells: [
            const DataCell(Text("Budi Santoso")),
            const DataCell(Text("Informatika")),
            const DataCell(Text("2022")),
            const DataCell(Text("08123456789")),
            const DataCell(Text("budis_line")),
            DataCell(IconButton(icon: const Icon(Icons.description, color: Colors.blue), onPressed: () {})),
            DataCell(IconButton(icon: const Icon(Icons.link, color: Colors.blue), onPressed: () {})),
          ]),
        ],
      ),
    );
  }
}