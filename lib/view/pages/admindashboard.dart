import 'package:flutter/material.dart';
import '../widgets/organizer_form.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  String activeTab = "Monitor Konten";

  final List<Map<String, dynamic>> allContent = [
    {"id": "1", "nama": "Leadership 2024", "org": "BEM UC", "type": "Event"},
    {"id": "2", "nama": "UI/UX Design", "org": "IMT UC", "type": "Lomba"},
  ];

  final List<Map<String, dynamic>> users = [
    {"name": "Justin Mason", "email": "justin@mail.com", "role": "Mahasiswa"},
    {"name": "Budi Panitia", "email": "budi@mail.com", "role": "Organizer"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text("Admin Control Center"),
        backgroundColor: const Color(0xff123C52),
        foregroundColor: Colors.white,
      ),
      body: Row(
        children: [
          // Sidebar Admin
          Container(
            width: 250,
            color: Colors.white,
            child: Column(
              children: [
                _sideItem("Monitor Konten", Icons.dashboard),
                _sideItem("Manajemen Role", Icons.admin_panel_settings),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: activeTab == "Monitor Konten" ? _buildMonitorTable() : _buildRoleTable(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sideItem(String t, IconData i) => ListTile(
    leading: Icon(i, color: activeTab == t ? const Color(0xff123C52) : Colors.grey),
    title: Text(t, style: TextStyle(fontWeight: activeTab == t ? FontWeight.bold : FontWeight.normal)),
    onTap: () => setState(() => activeTab = t),
  );

  Widget _buildMonitorTable() {
    return Card(
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Nama Proker')),
          DataColumn(label: Text('Organizer')),
          DataColumn(label: Text('Aksi')),
        ],
        rows: allContent.map((item) => DataRow(cells: [
          DataCell(Text(item['nama'])),
          DataCell(Text(item['org'])),
          DataCell(Row(
            children: [
              IconButton(icon: const Icon(Icons.edit, color: Colors.orange), onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => OrganizerForm(category: item['type'], initialData: item)));
              }),
              IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () {}),
            ],
          )),
        ])).toList(),
      ),
    );
  }

  Widget _buildRoleTable() {
    return Card(
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Nama')),
          DataColumn(label: Text('Role Saat Ini')),
          DataColumn(label: Text('Ubah Role')),
        ],
        rows: users.map((user) => DataRow(cells: [
          DataCell(Text(user['name'])),
          DataCell(Text(user['role'])),
          DataCell(DropdownButton<String>(
            value: user['role'],
            items: <String>['Admin', 'Organizer', 'Mahasiswa', 'Siswa'].map((String v) {
              return DropdownMenuItem<String>(value: v, child: Text(v));
            }).toList(),
            onChanged: (newRole) {},
          )),
        ])).toList(),
      ),
    );
  }
}