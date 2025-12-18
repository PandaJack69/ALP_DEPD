import 'package:flutter/material.dart';
import '../widgets/organizer_navbar.dart';
import '../widgets/organizer_form.dart';
import '../widgets/tables/event_participant_table.dart';
import '../widgets/tables/lomba_participant_table.dart';
import '../widgets/tables/management_table.dart';

class OrganizerDashboard extends StatefulWidget {
  const OrganizerDashboard({super.key});

  @override
  State<OrganizerDashboard> createState() => _OrganizerDashboardState();
}

class _OrganizerDashboardState extends State<OrganizerDashboard> {
  String activeTab = "Daftar Event";
  Map<String, dynamic>? selectedItem; 
  String? currentViewType; 

  // Data Dummy sesuai instruksi
  final List<Map<String, dynamic>> dummyEvents = [
    {"id": "1", "nama": "Leadership 2024", "registrasi": 120}
  ];
  final List<Map<String, dynamic>> dummyLomba = [
    {"id": "2", "nama": "UI/UX Design", "registrasi": 45}
  ];
  final List<Map<String, dynamic>> dummyPengmas = [
    {"id": "3", "nama": "Desa Binaan", "registrasi": 30}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      floatingActionButton: selectedItem == null
          ? FloatingActionButton.extended(
              onPressed: () => _openForm(),
              backgroundColor: const Color(0xff3F054F),
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text("Tambah Baru", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            )
          : null,
      body: Column(
        children: [
          OrganizerNavbar(
            activeTab: activeTab,
            onTabChanged: (tab) => setState(() {
              activeTab = tab;
              selectedItem = null; 
            }),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 25),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: _buildActiveTable(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    String title = selectedItem != null 
        ? "Pendaftar: ${selectedItem!['nama']}" 
        : activeTab;
    return Row(
      children: [
        if (selectedItem != null)
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => setState(() => selectedItem = null),
          ),
        Text(title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xff143952))),
      ],
    );
  }

  void _openForm({Map<String, dynamic>? data}) {
    String category = activeTab.split(" ").last;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrganizerForm(category: category, initialData: data)),
    );
  }

  Widget _buildActiveTable() {
    if (selectedItem != null) {
      return currentViewType == "Lomba" 
          ? const LombaParticipantTable() 
          : const EventParticipantTable();
    }

    switch (activeTab) {
      case "Daftar Event":
        return ManagementTable(
          data: dummyEvents, type: "Event", 
          onEdit: (d) => _openForm(data: d), 
          onCheckParticipants: (d) => setState(() { selectedItem = d; currentViewType = "Event"; })
        );
      case "Daftar Lomba":
        return ManagementTable(
          data: dummyLomba, type: "Lomba", 
          onEdit: (d) => _openForm(data: d), 
          onCheckParticipants: (d) => setState(() { selectedItem = d; currentViewType = "Lomba"; })
        );
      case "Daftar Pengmas":
        return ManagementTable(
          data: dummyPengmas, type: "Pengmas", 
          onEdit: (d) => _openForm(data: d), 
          onCheckParticipants: (d) => setState(() { selectedItem = d; currentViewType = "Pengmas"; })
        );
      default:
        return const SizedBox();
    }
  }
}