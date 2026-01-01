import 'package:flutter/material.dart';

class LombaSoloTable extends StatelessWidget {
  final Map<String, int> statusMap;
  final Function(String, int) onStatusChanged;

  const LombaSoloTable({super.key, required this.statusMap, required this.onStatusChanged});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowColor: WidgetStateProperty.all(const Color(0xFFF1F5F9)),
      columns: const [
        DataColumn(label: Text('NAMA PESERTA')),
        DataColumn(label: Text('UNIVERSITAS')),
        DataColumn(label: Text('YEAR')),
        DataColumn(label: Text('PHONE')),
        DataColumn(label: Text('COMPETITION')),
        DataColumn(label: Text('STATUS')),
      ],
      rows: [
        _buildRow("Andi Wijaya", "ITS", "2020", "0811223344", "Competitive Programming"),
      ],
    );
  }

  DataRow _buildRow(String name, String univ, String year, String phone, String comp) {
    int currentStatus = statusMap[name] ?? 0;
    return DataRow(cells: [
      DataCell(Text(name, style: const TextStyle(fontWeight: FontWeight.bold))),
      DataCell(Text(univ)),
      DataCell(Text(year)),
      DataCell(Text(phone)),
      DataCell(Text(comp)),
      DataCell(Row(
        children: [
          _statusIcon(Icons.check_circle, Colors.green, name, 1, currentStatus == 1),
          _statusIcon(Icons.cancel, Colors.red, name, 2, currentStatus == 2),
        ],
      )),
    ]);
  }

  Widget _statusIcon(IconData icon, Color color, String name, int idx, bool isSelected) {
    return IconButton(
      icon: Icon(icon, color: isSelected ? color : color.withOpacity(0.2), size: 22),
      onPressed: () => onStatusChanged(name, idx),
    );
  }
}