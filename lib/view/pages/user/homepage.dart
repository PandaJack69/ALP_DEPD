// File: lib/view/pages/user/homepage.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewmodel/database_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DatabaseProvider>();
    final allEvents = provider.events; // Data Real-time

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, ${provider.currentUser?.fullName ?? 'Guest'}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => provider.logout(),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => provider.fetchAllEvents(), // Tarik layar untuk refresh data
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: allEvents.length,
          itemBuilder: (context, index) {
            final event = allEvents[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    color: Colors.grey.shade300, // Placeholder Poster
                    child: const Center(child: Icon(Icons.image, size: 50, color: Colors.grey)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(event.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(event.description),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Chip(label: Text(event.category)),
                            const SizedBox(width: 8),
                            Text("By: ${event.organization}", style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // LOGIC DAFTAR EVENT DI SINI
                              // provider.registerToEvent(event.id);
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Fitur Daftar (Insert ke tabel registrations)")));
                            },
                            child: const Text("Daftar Sekarang"),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}