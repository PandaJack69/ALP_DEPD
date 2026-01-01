import 'package:flutter/material.dart';

class LombaParticipantTable extends StatefulWidget {
  const LombaParticipantTable({super.key});

  @override
  State<LombaParticipantTable> createState() => _LombaParticipantTableState();
}

class _LombaParticipantTableState extends State<LombaParticipantTable> {
  String viewType = "Siswa"; 

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(children: [_toggleBtn("Siswa"), const SizedBox(width: 10), _toggleBtn("Mahasiswa")]),
        ),
        SingleChildScrollView(scrollDirection: Axis.horizontal, child: viewType == "Siswa" ? _buildSiswaTable() : _buildMahasiswaTable()),
      ],
    );
  }

  Widget _toggleBtn(String mode) {
    bool isSel = viewType == mode;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: isSel ? const Color(0xff143952) : Colors.grey[200], foregroundColor: isSel ? Colors.white : Colors.black),
      onPressed: () => setState(() => viewType = mode),
      child: Text(mode),
    );
  }

  Widget _buildSiswaTable() {
    return DataTable(
      columns: const [DataColumn(label: Text('Nama')), DataColumn(label: Text('Sekolah')), DataColumn(label: Text('Kontak')), DataColumn(label: Text('Bukti Bayar'))],
      rows: [DataRow(cells: [const DataCell(Text("Andi")), const DataCell(Text("SMA 1")), const DataCell(Text("0811")), DataCell(IconButton(icon: const Icon(Icons.receipt_long, color: Colors.green), onPressed: () {}))])],
    );
  }

  Widget _buildMahasiswaTable() {
    return DataTable(
      columns: const [DataColumn(label: Text('Nama')), DataColumn(label: Text('Univ')), DataColumn(label: Text('Angkatan')), DataColumn(label: Text('Kontak')), DataColumn(label: Text('Bukti Bayar'))],
      rows: [DataRow(cells: [const DataCell(Text("Rina")), const DataCell(Text("UC")), const DataCell(Text("2021")), const DataCell(Text("0855")), DataCell(IconButton(icon: const Icon(Icons.receipt_long, color: Colors.green), onPressed: () {}))])],
    );
  }
}