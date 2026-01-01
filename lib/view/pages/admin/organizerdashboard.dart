// File: lib/view/pages/admin/organizerdashboard.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewmodel/database_provider.dart';

class OrganizerDashboard extends StatefulWidget {
  const OrganizerDashboard({super.key});

  @override
  State<OrganizerDashboard> createState() => _OrganizerDashboardState();
}

class _OrganizerDashboardState extends State<OrganizerDashboard> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DatabaseProvider>();
    final myEvents = provider.events; // Mengambil data asli dari Supabase

    return Scaffold(
      appBar: AppBar(
        title: const Text("Organizer Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => provider.logout(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddEventDialog(context, provider),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: myEvents.length,
        itemBuilder: (context, index) {
          final event = myEvents[index];
          return Card(
            child: ListTile(
              title: Text(event.title),
              subtitle: Text("${event.category} • ${event.organization}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => provider.deleteEvent(event.id),
              ),
            ),
          );
        },
      ),
    );
  }

  // Dialog sederhana untuk input data
  void _showAddEventDialog(BuildContext context, DatabaseProvider provider) {
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    String category = 'event';

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Tambah Event Baru"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: "Nama Event")),
            TextField(controller: descCtrl, decoration: const InputDecoration(labelText: "Deskripsi")),
            // Dropdown sederhana
            DropdownButton<String>(
              value: category,
              items: ['event', 'lomba', 'pengmas'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => category = val!,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Batal")),
          ElevatedButton(
            onPressed: () async {
              bool success = await provider.addEvent(
                title: titleCtrl.text,
                description: descCtrl.text,
                category: category,
                orgName: provider.currentUser?.fullName ?? "Organizer",
              );
              if (success && mounted) Navigator.pop(ctx);
            },
            child: const Text("Simpan"),
          )
        ],
      ),
    );
  }
}