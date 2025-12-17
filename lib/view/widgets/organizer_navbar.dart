import 'package:flutter/material.dart';

class OrganizerNavbar extends StatelessWidget {
  final String activeTab;
  final Function(String) onTabChanged;

  const OrganizerNavbar({super.key, required this.activeTab, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xff123C52), Color(0xff3F054F)])
      ),
      child: Row(
        children: [
          const Text("Organizer Dashboard", 
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
          const SizedBox(width: 40),
          _item("Daftar Event"),
          _item("Daftar Lomba"),
          _item("Daftar Pengmas"),
          const Spacer(),
          const CircleAvatar(child: Icon(Icons.person)),
        ],
      ),
    );
  }

  Widget _item(String t) => Padding(
    padding: const EdgeInsets.only(right: 20),
    child: InkWell(
      onTap: () => onTabChanged(t),
      child: Text(t, style: TextStyle(
        color: activeTab == t ? Colors.white : Colors.white70, 
        fontWeight: activeTab == t ? FontWeight.bold : FontWeight.normal
      )),
    ),
  );
}